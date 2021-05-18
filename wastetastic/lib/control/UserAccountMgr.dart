import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/entity/UserAccount.dart';

import '../entity/UserAccount.dart';
import '../entity/WasteRecord.dart';
import '../entity/WastePOI.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';

/// Controller Class to manage user accounts
///
/// * Interacts with the firestore database of User Accounts
/// * Keeps track of current logged in user
class UserAccountMgr {
  /// A firebase firestore instance to interact with the User Account database
  static final _firestore = FirebaseFirestore.instance;

  /// A firebase authentication instance to validate user login
  static final _auth = FirebaseAuth.instance;

  /// A static User Account variable for details of logged in user
  static UserAccount userDetails = new UserAccount();

  /// Reads details of logged in user from database into local variable
  ///
  /// Finds a record in database using [_firestore] having key [username]
  /// and populates the details in static variable [userDetails]. Returns void.
  static readUserDetails(String username) async {
    //UserAccount userDetails = new UserAccount();

    await for (var snapshot in _firestore
        .collection('UserAccounts')
        //.where('username', isEqualTo: username)
        .snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);
        for (var Documents in documents) {
          if (Documents.id == username) {
            //print(y);
            //print('Hello There!');
            //print('Doc id' + Doc.id);
            userDetails.username = username;
            userDetails.email = Documents['email'];
            userDetails.name = Documents['name'];
            userDetails.points = Documents['points'];

            List<WastePOI> WastePOIs = List<WastePOI>();
            try {
              for (var waste_POI_name in Documents['favorites']) {
                var w = await _firestore
                    .collection('WastePOI')
                    .doc(waste_POI_name)
                    .get();
                List<String> nearbyCarParks = List<String>();

                nearbyCarParks = [];
                for (String carParkNum in w['nearbyCarPark']) {
                  nearbyCarParks.add(carParkNum);
                }

                WastePOIs.add(WastePOI(
                  id: waste_POI_name,
                  name: w['name'],
                  category: WasteCategory.values.firstWhere(
                      (element) => element.toString() == w['category']),
                  location: gp.GeoPoint.fromLatLng(
                      point: LatLng(
                          w['location'].latitude, w['location'].longitude)),
                  address: w['address'],
                  POI_postalcode: w['POI_postalcode'],
                  nearbyCarPark: nearbyCarParks,
                  POI_description: w['POI_description'],
                  POI_inc_crc: w['POI_inc_crc'],
                  POI_feml_upd_d: w['POI_feml_upd_d'],
                ));
              }
            } catch (e) {
              //print(e);
              WastePOIs = [];
            }
            userDetails.favorites = WastePOIs;

            List<WasteRecord> WasteRecords = List<WasteRecord>();

            await for (var snapshot in _firestore
                .collection('UserAccounts')
                .doc(username)
                .collection('WasteRecords')
                .snapshots()) {
              var docs = snapshot.docs;
              if (docs.isNotEmpty) {
                print(docs.length);
                for (var Doc in docs) {
                  //print(y);
                  print('Hello There!');
                  print('Doc id' + Doc.id);
                  WasteRecords.add(WasteRecord(
                    dateTime:
                        DateTime.fromMillisecondsSinceEpoch(int.parse(Doc.id)),
                    weight: Doc['weight'].toDouble(),
                    category: WasteCategory.values.firstWhere(
                        (element) => element.toString() == Doc['category']),
                  ));
                }
              } else {
                WasteRecords = [];
              }
              break;
            }
            userDetails.waste_records = WasteRecords;
          }
        }
      }
      break;
    }

    //userDetails.printUserDetails();
    //print(userDetails.waste_records.first.weight);
  }

  /// Checks if a Waste POI is a favorite
  ///
  /// Determines if [wp] is in [userDetails.favorites]. Return true
  /// if it is a favorite, false if not.
  static bool isFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.id == w.id) {
        return true;
      }
    }
    return false;
  }

  /// Changes the favorite status of a Waste POI for the logged in user
  ///
  /// Adds [wp] to [userDetails.favorites] if it is not a favorite, and
  /// vice-versa. Also makes changes in database using [_firestore].
  /// Return void.
  static Future<void> editFav(WastePOI wp) async {
    if (UserAccountMgr.isFav(wp)) {
      print('Found! in editFav');
      UserAccountMgr.removeFav(wp);
    } else
      userDetails.favorites.add(wp);
    print(userDetails.favorites);
    //@todo add function to favourite/un-favourite POI in the database
    List<String> WastePOI_ids = List<String>();
    for (WastePOI w in userDetails.favorites) WastePOI_ids.add(w.id);
    try {
      await _firestore
          .collection('UserAccounts')
          .doc(userDetails.username)
          .update({'favorites': WastePOI_ids});
    } catch (e) {
      await _firestore
          .collection('UserAccounts')
          .doc(userDetails.username)
          .set({'favorites': WastePOI_ids});
    }
    return;
  }

  /// Removes a Waste POI from list of favorites
  ///
  /// Determines position of [wp] in [userDetails.favorites] and removes it.
  /// Returns void.
  static void removeFav(WastePOI wp) {
    for (WastePOI w in userDetails.favorites) {
      if (wp.id == w.id) {
        print('Found! in removeFav');
        userDetails.favorites.remove(w);
        return;
      }
    }
    return;
  }

  /// Updates the user's password in the database
  ///
  /// Makes use of [_auth] instance to change the password in the database.
  /// Returns void.
  static updateUserPassword(String email, String newPassword) async {
    String username;
    await for (var snapshot in _firestore
        .collection('UserAccounts')
        .where('email', isEqualTo: email)
        .snapshots()) {
      var docs = snapshot.docs;
      if (docs.isNotEmpty) {
        for (var Doc in docs) {
          if (Doc['email'] == email) {
            username = Doc.id;
            print(username);
          }
        }
      } else {
        print(
            "No user has this email id registered!"); // figure out how to fix this, maybe check email id in ForgotPassword when the user initially enters an email id
      }
      break;
    }
//    await _firestore
//        .collection('UserAccounts')
//        .doc(username)
//        .update({'password': newPassword});
    var user = _auth.currentUser;
    try {
      await user.updatePassword(newPassword);
    } catch (e) {
      print('Error changing password!');
    }
    await readUserDetails(username);
  }

  /// Sends a password reset email to [email] if user forgets password
  static forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// Validates if a user account exists
  ///
  /// Interacts with database using [_firestore] and checks if a record has key
  /// [username] or email field as [email]. Returns "Username" if found by username,
  /// "Email" if found by email, and null if not found.
  static Future<String> validateUsername_Email(
      String username, String email) async {
    await for (var snapshot
        in _firestore.collection('UserAccounts').snapshots()) {
      var documents = snapshot.docs;
      if (documents.isNotEmpty) {
        //print(docs.length);

        for (var Documents in documents) {
          if (Documents.id == username) return "Username";
          if (Documents['email'] == email) return "Email";
        }
      }
      return null;
    }
    return null;
  }
}
