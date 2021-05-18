import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WasteRecord.dart';

/// Controller Class for Waste record updates
///
/// Interacts with the firestore database to add new waste record details added by the user
class WasteRecordMgr {
  /// A firebase firestore instance to interact with the User Account database
  static final _firestore = FirebaseFirestore.instance;

  /// Adds new waste record to the user document in the database
  ///
  /// Adds a new waste record document with document id, [dateTime], timestamp of the waste disposal,
  /// weight: [weight] kgs and of category, [category],
  /// to the WasteRecords collection of user document [username].
  /// Also adds the points to the user according to the weight and category of the waste record.
  /// Returns void.
  static Future<void> addNewRecord(String username, DateTime dateTime,
      double weight, WasteCategory category) async {
    WasteRecord wasteRecord = WasteRecord(
      dateTime: dateTime,
      weight: weight,
      category: category,
    );
    wasteRecord.printDetails();
    print(dateTime.millisecondsSinceEpoch.toString());
    int new_point = UserAccountMgr.userDetails.points;
    if (category == WasteCategory.NORMAL_WASTE) {
      new_point += 7 * weight.toInt();
    } else if (category == WasteCategory.E_WASTE) {
      new_point += 3 * weight.toInt();
    } else if (category == WasteCategory.LIGHTING_WASTE) {
      new_point += 4 * weight.toInt();
    } else if (category == WasteCategory.WASTE_TREATMENT) {
      new_point += 6 * weight.toInt();
    } else {
      new_point += 9 * weight.toInt();
    }
    _firestore
        .collection('UserAccounts')
        .doc('$username')
        .update({'points': new_point});
    _firestore
        .collection('UserAccounts')
        .doc('$username')
        //.update('points': updated_points);
        .collection('WasteRecords')
        .doc(dateTime.millisecondsSinceEpoch.toInt().toString())
        .set({
      'weight': weight,
      'category': category.toString(),
    });
    await UserAccountMgr.readUserDetails(username);
    UserAccountMgr.userDetails.printUserDetails();
  }
}
