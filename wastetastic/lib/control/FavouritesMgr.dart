/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/entity/UserAccount.dart';

import '../entity/UserAccount.dart';
import '../entity/WasteRecord.dart';
import '../entity/WastePOI.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';

class UserAccountMgr {
  static final _firestore = FirebaseFirestore.instance;

  static getWastePOIByName_address(
    String name,
    String address,
  ) {
    Stream sc = _firestore
        .collection('WastePOI')
        .where('address', isEqualTo: address)
        .snapshots();

    List<DocumentSnapshot> documents = sc.data.doc();
  }
}
*/
