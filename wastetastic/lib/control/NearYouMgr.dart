import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sortedmap/sortedmap.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:latlong/latlong.dart';

/// Controller Class to determine nearby Waste POI
///
/// Contains intermediate helper functions to complete the task
class NearYouMgr {
//  /// A firebase firestore instance to interact with the Waste POI database
//  static final _firestore = FirebaseFirestore.instance;

  /// Retrieves the device's current location
  ///
  /// Makes use of the geolocator API. Returns current location.
  static Future<gp.GeoPoint> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      print(position.latitude);
      print(position.longitude);
      return gp.GeoPoint.fromLatLng(
          point: LatLng(position.latitude, position.longitude));
    } catch (e) {
      print(e);
    }
  }

  /// Determines the 5 nearest Waste POI
  ///
  /// Finds the nearest location from the Waste POI data obtained from firebase
  /// and stored in [documents], using the current location stored in [location].
  /// Returns the 5 nearest Waste POI.
  static retrieveNearbyWastePOI(
      List<DocumentSnapshot> documents, gp.GeoPoint location) {
    int count = 0;
    final Distance distance = Distance();
    var distances = SortedMap(Ordering.byValue());
    double m;
    for (var w in documents) {
      m = distance.as(LengthUnit.Meter, location.toLatLng(),
          LatLng(w['location'].latitude, w['location'].longitude));
      distances.addAll({count: m});
      count++;
    }
    List<WastePOI> nearbyWastePOI = List<WastePOI>();
    int counter = 0;
    List<String> nearbyCarParks = [];
    for (var index in distances.keys) {
      if (counter == 5) break;
      nearbyCarParks = [];
      for (String carParkNum in documents[index]['nearbyCarPark']) {
        nearbyCarParks.add(carParkNum);
        //print(carParkNum);
      }
      nearbyWastePOI.add(WastePOI(
        id: documents[index].id,
        name: documents[index]['name'],
        category: WasteCategory.values.firstWhere(
            (element) => element.toString() == documents[index]['category']),
        location: gp.GeoPoint.fromLatLng(
            point: LatLng(documents[index]['location'].latitude,
                documents[index]['location'].longitude)),
        address: documents[index]['address'],
        POI_postalcode: documents[index]['POI_postalcode'],
        nearbyCarPark: nearbyCarParks,
        POI_description: documents[index]['POI_description'],
        POI_inc_crc: documents[index]['POI_inc_crc'],
        POI_feml_upd_d: documents[index]['POI_feml_upd_d'],
      ));
      counter++;
    }
    return nearbyWastePOI;
  }

//  static readAllWastePOILocations(WasteCategory wasteCategory) async {
//    Map<String, LatLng> WastePOILocations = Map<String, LatLng>();
//    await for (var snapshot in _firestore
//        .collection('WastePOI')
//        .where('category', isEqualTo: wasteCategory.toString())
//        .snapshots()) {
//      for (var wastePOI in snapshot.docs) {
//        Map<String, dynamic> w = wastePOI.data();
//        WastePOILocations[wastePOI.id] =
//            LatLng(w['location'].latitude, w['location'].longitude);
//      }
//    }
//    return WastePOILocations;
//  }
}
