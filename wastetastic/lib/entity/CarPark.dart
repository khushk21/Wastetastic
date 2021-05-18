import 'package:geopoint/geopoint.dart';

/// Entity Class describing a Car Park
class CarPark {
  /// The unique car park number of a specific car park
  String _carParkNum;

  /// The address of the car park
  String _address;

  /// The location of the car park
  GeoPoint _location;

  /// The type of the car park
  String _carParkType;

  /// The parking type of the car park
  String _parkingType;

  /// A description of when free parking is available
  String _freeParking;

  /// Named constructor to initialize the fields of the Car Park
  CarPark({
    String carParkNum,
    String address,
    GeoPoint location,
    String carParkType,
    String parkingType,
    String freeParking,
  })  : _carParkNum = carParkNum,
        _address = address,
        _location = location,
        _carParkType = carParkType,
        _parkingType = parkingType,
        _freeParking = freeParking;

  /// The unique car park number of a specific car park
  String get carParkNum => _carParkNum;

  /// The address of the car park
  String get address => _address;

  /// The location of the car park
  GeoPoint get location => _location;

  /// The type of the car park
  String get carParkType => _carParkType;

  /// The parking type of the car park
  String get parkingType => _parkingType;

  /// A description of when free parking is available
  String get freeParking => _freeParking;

  /// Prints details of the Car Park (for debug)
  void printDetails() {
    print('Car Park Number: $_carParkNum');
    print('Address: $_address');
    print('Location: ${location.latitude}, ${location.longitude}');
    print('Car Park Type: $_carParkType');
    print('Parking Type: $_parkingType');
    print('Free Parking: $_freeParking');
  }
}
