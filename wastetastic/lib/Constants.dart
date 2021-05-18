import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:latlong/latlong.dart';

const List<String> kWasteCategory = [
  'NORMAL WASTE',
  'E WASTE',
  'LIGHTING WASTE',
  'WASTE TREATMENT',
  'CASH FOR TRASH'
];

const kContainerElevation = [
  BoxShadow(
    offset: Offset(0.0, 3.0), //(x,y)
    blurRadius: 5.0,
  ),
];

WastePOI kSample = WastePOI(
  id: "SAMPLE_0",
  name: "WastePOI sample",
  category: WasteCategory.LIGHTING_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample2 = WastePOI(
  id: "SAMPLE_1",
  name: "WastePOI sample2",
  category: WasteCategory.E_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample3 = WastePOI(
  id: "SAMPLE_2",
  name: "WastePOI sample3",
  category: WasteCategory.NORMAL_WASTE,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample4 = WastePOI(
  id: "SAMPLE_3",
  name: "WastePOI sample4",
  category: WasteCategory.WASTE_TREATMENT,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample5 = WastePOI(
  id: "SAMPLE_4",
  name: "WastePOI sample5",
  category: WasteCategory.CASH_FOR_TRASH,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

WastePOI kSample6 = WastePOI(
  id: "SAMPLE_5",
  name: "WastePOI sample6",
  category: WasteCategory.CASH_FOR_TRASH,
  location: GeoPoint.fromLatLng(name: "Position", point: LatLng(51.0, 0.0)),
  POI_postalcode: 827373,
  POI_description: "ajsjs",
  address: "PlaceHolder address",
);

List<WastePOI> kWastePOI_List = [
  kSample,
  kSample2,
  kSample3,
  kSample4,
  kSample5,
  kSample6
];

List<WastePOI> kFav_POI_list = [
  kSample,
  kSample2,
  kSample3,
  kSample4,
  kSample5
];

CarPark cp1 = CarPark(
  carParkNum: '1',
  carParkType: 'Surface Car Park',
  parkingType: 'electronic',
  address: "BLK 215 ANG MO KIO STREET 22",
  freeParking: 'weekend',
);

CarPark cp2 = CarPark(
  carParkNum: '2',
  carParkType: 'Multi Story Car Park',
  parkingType: 'electronic',
  address: "BLK 215 ANG MO KIO STREET 22",
  freeParking: 'weekend',
);

CarPark cp3 = CarPark(
  carParkNum: '3',
  carParkType: 'Surface Car Park',
  parkingType: 'electronic',
  address: "Sample Address 3",
  freeParking: 'weekend',
);

CarPark cp4 = CarPark(
  carParkNum: '4',
  carParkType: 'Surface Car Park',
  parkingType: 'coupon',
  address: "Sample Address 4",
  freeParking: 'weekend',
);

CarPark cp5 = CarPark(
  carParkNum: '5',
  carParkType: 'Surface Car Park',
  parkingType: 'coupon',
  address: "Sample Address 5",
  freeParking: 'weekend',
);

List<CarPark> kcarpark_list = [
  cp1,
  cp2,
  cp3,
  cp4,
  cp5,
];
