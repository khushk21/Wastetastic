import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'package:wastetastic/control/NetworkMgr.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:geopoint/geopoint.dart' as gp;

/// Controller Class to retrieve info on nearby car parks
///
/// * Interacts with firebase database to retrieve car park data.
/// * Makes use of API to retrieve live car park availability
class CarParkMgr {
  /// A firebase firestore instance to interact with the Car Park database
  static final _firestore = FirebaseFirestore.instance;

  /// Retrieves information on the nearby car parks to a specific Waste POI.
  ///
  /// Makes use of list of keys [nearbyCarParkNum] to retrieve the information from
  /// Car Park database. Also makes API call to retrieve live car park availability.
  /// Returns list of car parks with corresponding availability.
  static Future<List> retrieveNearbyCarParkInfo(
      List<String> nearbyCarParkNum) async {
    List<List> nearbyCarPark = List<List>();
    for (String carParkNum in nearbyCarParkNum) {
      var carParkData =
          (await _firestore.collection('CarPark').doc(carParkNum).get()).data();
      nearbyCarPark.add([
        CarPark(
          carParkNum: carParkNum,
          address: carParkData['address'],
          location: gp.GeoPoint.fromLatLng(
              point: LatLng(carParkData['location'].latitude,
                  carParkData['location'].longitude)),
          carParkType: carParkData['carParkType'],
          freeParking: carParkData['freeParking'],
          parkingType: carParkData['parkingType'],
        )
      ]);
    }
    String jsonResponse = await NetworkMgr.getDataFromURL(
        "https://api.data.gov.sg/v1/transport/carpark-availability");
    Map<String, dynamic> availability = jsonDecode(jsonResponse);
    //print(availability);
    //print(availability['items'][0]['carpark_data'][0]['carpark_info'][0]
    //['lots_available']);
    print(nearbyCarParkNum);
    int index;
    for (var carpark in availability['items'][0]['carpark_data']) {
      //print(carpark);
      index = 0;
      for (String carParkNum in nearbyCarParkNum) {
        if (carpark['carpark_number'] == carParkNum) {
          nearbyCarPark[index]
              .add(carpark['carpark_info'][0]['lots_available']);
        }
        index++;
      }
    }
    index = 0;
    int numRemoved = 0;
    List<List> results = []..addAll(nearbyCarPark);
    for (List item in nearbyCarPark) {
      print(item.length);
      if (item.length == 1) {
        results.removeAt(index - numRemoved);
        numRemoved++;
      }
      index++;
    }
    print(nearbyCarPark);
    print(results);
    return results;
  }
}
