import 'package:wastetastic/entity/WasteCategory.dart';

/// Entity Class describing a Waste Record of a user
class WasteRecord {
  /// The date and time when the user disposed the waste
  DateTime _dateTime;

  /// The category of waste the user disposed
  WasteCategory _category;

  /// The weight of waste the user disposed
  double _weight;

  /// Named constructor to initialize the fields of a Waste Record
  WasteRecord({
    DateTime dateTime,
    WasteCategory category,
    double weight,
  })  : _dateTime = dateTime,
        _category = category,
        _weight = weight;

  /// The date and time when the user disposed the waste
  DateTime get dateTime => _dateTime;

  /// The category of waste the user disposed
  WasteCategory get category => _category;

  /// The weight of waste the user disposed
  double get weight => _weight;

  set dateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }

  set category(WasteCategory category) {
    _category = category;
  }

  set weight(double weight) {
    _weight = weight;
  }

  /// Prints details of a Waste Record (for debug)
  void printDetails() {
    print('Date and Time: ' + _dateTime.toString());
    print('Waste Category: ' + _category.toString());
    print('Weight: ' + _weight.toString());
  }
}
