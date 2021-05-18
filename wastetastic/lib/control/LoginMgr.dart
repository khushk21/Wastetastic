import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

/// Controller Class to manage user login
///
/// * Interacts with firebase auth to authenticate user login
/// * Ensures that user details are correctly stored in code locally after successful
///   login
/// * Rewards points to user for each login
class LoginMgr {
  /// /// A firebase firestore instance to interact with the User Account database
  static final _firestore = FirebaseFirestore.instance;

  /// A firebase authentication instance to validate user login
  static final _auth = FirebaseAuth.instance;

  /// Verifies credentials entered by user.
  ///
  /// Determines email corresponding to [username] from User Account database.
  /// Makes use of [_auth] to sign in with email and password. Updates the points
  /// of the user in the User Account database using [_firestore]. Returns success
  /// status of login (true/false).
  static Future<bool> verifyCredentials(
      String username, String enteredPassword) async {
    var userAccount =
        await _firestore.collection('UserAccounts').doc(username).get();
    //print(userAccount);
    if (userAccount.exists) {
      String email = userAccount.data()['email'];
//      if (enteredPassword == user['password']) {
//        await UserAccountMgr.readUserDetails(username);
//        return true;
//      } else {
//        return false;
//      }
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: enteredPassword);
        if (user != null) {
          await UserAccountMgr.readUserDetails(username);
          int new_point = UserAccountMgr.userDetails.points;
          new_point += 3;
          _firestore
              .collection('UserAccounts')
              .doc('$username')
              .update({'points': new_point});
          UserAccountMgr.userDetails.points = new_point;
          return true;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }
    return false;
  }

  /// Intermediate function to abstract login
  static dynamic loginToSystem(String username, String password) async {
    var login = await verifyCredentials(username, password);
    return login;
  }
}
