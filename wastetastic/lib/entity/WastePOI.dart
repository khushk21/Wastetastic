import 'package:flutter/cupertino.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:geopoint/geopoint.dart';

/// Entity class describing a Waste Point of Interest (POI)
class WastePOI {
  /// A Unique ID identifying a specific Waste POI
  String _id;

  /// The name of the Waste POI
  String _POI_name;

  /// The category of the Waste POI
  WasteCategory _wasteCategory;

  /// The location of the Waste POI
  GeoPoint _location;

  /// The list of IDs of 5 nearest HDB car parks
  List<String> _nearbyCarPark = List<String>(5);

  /// The postal code of the Waste POI
  int _POI_postalcode;

  /// The address of the Waste POI
  String _address;

  /// The description of the Waste POI
  String _POI_description;

  /// Additional metadata
  String _POI_inc_crc;

  /// Additional metadata
  String _POI_feml_upd_d;

  /// Named constructor to initialize fields of a Waste POI
  WastePOI({
    String id,
    String name,
    WasteCategory category,
    GeoPoint location,
    int POI_postalcode,
    String address,
    List<String> nearbyCarPark,
    String POI_description: 'Normal Waste Disposal',
    String POI_inc_crc: 'No inc_crc',
    String POI_feml_upd_d: 'No feml_upd_d',
  })  : _id = id,
        _POI_name = name,
        _wasteCategory = category,
        _location = location,
        _address = address,
        _POI_postalcode = POI_postalcode,
        _nearbyCarPark = nearbyCarPark,
        _POI_description = POI_description,
        _POI_inc_crc = POI_inc_crc,
        _POI_feml_upd_d = POI_feml_upd_d;

  /// The ID of the Waste POI
  String get id => _id;

  /// The category of the Waste POI
  WasteCategory get wasteCategory => _wasteCategory;

  /// The location of the Waste POI
  GeoPoint get location => _location;

  /// The 5 nearest car parks to a Waste POI
  List<String> get nearbyCarPark => _nearbyCarPark;

  /// The name of the Waste POI
  String get POI_name => _POI_name;

  /// The address of the Waste POI
  String get address => _address;

  /// The postal code of the Waste POI
  int get POI_postalcode => _POI_postalcode;

  /// The description of the Waste POI
  String get POI_description => _POI_description;

  /// Additional metadata
  String get POI_inc_crc => _POI_inc_crc;

  /// Additional metadata
  String get POI_feml_upd_d => _POI_feml_upd_d;

  /// Prints details of Waste POI (for debug)
  void printDetails() {
    print("Name: $_POI_name");
    print("Address: $_address");
    print("Location: ${location.latitude}, ${location.longitude}");
    print("Postal Code: $_POI_postalcode");
    print("Description: $_POI_description");
    print("Inc crc: $_POI_inc_crc");
    print("Feml Upd d: $_POI_feml_upd_d");
    print("Nearby Car Parks: ");
    for (String carParkNum in _nearbyCarPark) {
      print(carParkNum);
    }
  }
}
