import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/entity/WasteRecord.dart';

/// Entity Class describing a User Account
class UserAccount {
  /// The username of the user
  String _username;

  /// The email of the user
  String _email;

  /// The name of the user
  String _name;

  /// The list of favorites of the user
  List<WastePOI> _favorites = List<WastePOI>(5);

  /// The list of waste records of the user
  List<WasteRecord> _waste_records;

  /// The points earned by the user
  int _points;

  /// Named constructor to initialize the fields of the User Account
  UserAccount({
    String username,
    String email,
    String name,
  })  : _username = username,
        _email = email,
        _name = name;

  /// The username of the user
  String get username => _username;

  /// The email of the user
  String get email => _email;

  /// The name of the user
  String get name => _name;

  /// The favorites of the user
  List<WastePOI> get favorites => _favorites;

  /// The waste records of the user
  List<WasteRecord> get waste_records => _waste_records;

  /// The points earned by the user
  int get points => _points;

  set username(String username) {
    _username = username;
  }

  set email(String email) {
    _email = email;
  }

  set name(String name) {
    _name = name;
  }

  set favorites(List<WastePOI> favorites) {
    _favorites = favorites;
  }

  set waste_records(List<WasteRecord> waste_records) {
    _waste_records = waste_records;
  }

  set points(int points) {
    _points = points;
  }

  /// Prints details of the user account (for debug)
  void printUserDetails() {
    print('Reached printUserDetails');
    print("Username: " + _username);
    print("Email: " + _email);
    print("Name: " + _name);
    print("Favorites: ");
    for (WastePOI fav in _favorites) {
      fav.printDetails();
    }
    print("Waste Records: ");
    for (WasteRecord wr in _waste_records) {
      wr.printDetails();
    }
  }
}
