import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/control/WasteRecordMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/screens/MainScreen.dart' as ms;

/// Unique Key for the form displayed on the screen
final _formKey = GlobalKey<FormState>();

/// Boundary Class to display the UI for adding a Waste Record
///
/// * Implements various input error handling
/// * Makes calls to controller class to perform the necessary database updates.
class AddWasteScreen extends StatefulWidget {
  /// Callback function used to notify the MainScreen of change in user's points
  final Function() notifyMainScreen;

  /// Named Constructor to initialize the callback function [notifyMainScreen]
  AddWasteScreen({Key key, @required this.notifyMainScreen}) : super(key: key);
  @override
  _AddWasteScreenState createState() => _AddWasteScreenState();
}

class _AddWasteScreenState extends State<AddWasteScreen> {
  /// The logged in user
  static UserAccount _loggedInUser;

  /// The user selected time
  String selectedTime = '12:00';

  /// The user selected date
  String selectedDate = DateTime.now().toString();

  /// The user entered weight
  String enteredWeight = '7';

  /// The user selected waste category
  String selectedCategory = 'NORMAL WASTE';

  /// Overridden initState function to read user details into local variable
  @override
  void initState() {
    super.initState();
    _loggedInUser = UserAccountMgr.userDetails;
  }

  /// Renders the widgets onto the screen
  ///
  /// Contains various input validations. Makes use of [widget.notifyMainScreen]
  /// to make necessary UI updates.
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.light(primary: Colors.green),
      ),
      child: Column(
        children: [
          header_card(
            title: "Add Waste",
          ),
          Container(
            child: Text('Record details of recent waste disposal:',
                style: TextStyle(fontSize: 23.0, fontFamily: 'DancingScript')),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 35.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DateTimePicker(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          icon: Icon(Icons.event),
                        ),
                        initialValue: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Date';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          selectedDate = val;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.time,
                        initialValue: selectedTime,
                        timeLabelText: "Time",
                        icon: Icon(Icons.access_time),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter Time';
                          }
                          if (DateTime.parse(
                                  selectedDate.substring(0, 10) + " " + val)
                              .isAfter(DateTime.now()))
                            return "Please enter a time before current time";
                          return null;
                        },
                        onChanged: (val) {
                          selectedTime = val;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Weight',
                          suffixText: 'Kg',
                          icon: Icon(Icons.shopping_cart_rounded),
                        ),
                        initialValue: enteredWeight,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter weight';
                          }
                          if (double.parse(value) == 0)
                            return "Weight cannot be zero";

                          return null;
                        },
                        onChanged: (value) {
                          enteredWeight = value;
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        icon: Icon(Icons.arrow_drop_down),
                        decoration: InputDecoration(
                            labelText: 'Waste Category',
                            icon: Icon(Icons.receipt_long)),
                        iconSize: 24,
                        elevation: 20,
                        style: TextStyle(color: Colors.black),
                        onChanged: (String newValue) {
                          setState(
                            () {
                              selectedCategory = newValue;
                            },
                          );
                        },
                        dropdownColor: Colors.lime,
                        items: kWasteCategory
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              primary: Colors.lime,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false
                              // otherwise.

                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                DateTime dt = DateTime.parse(
                                    selectedDate.substring(0, 10) +
                                        " " +
                                        selectedTime);
                                /*if (DateTime.now().isBefore(dt)) {
                                  print("Wrong time entered!");
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Please enter a time before the current time.",
                                    ),
                                  );
                                  return;
                                }*/
                                print(
                                    'date: ${selectedDate.substring(0, 10)} \n time: $selectedTime \n'
                                    'weight: $enteredWeight \n category: $selectedCategory');

                                print(selectedCategory.replaceAll(' ', '_'));
                                await WasteRecordMgr.addNewRecord(
                                  _loggedInUser.username,
                                  dt,
                                  double.parse(enteredWeight),
                                  WasteCategory.values.firstWhere((element) =>
                                      element.toString() ==
                                      ('WasteCategory.' +
                                          selectedCategory.replaceAll(
                                              ' ', '_'))),
                                );
                                widget.notifyMainScreen();
                                //Dialog box
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AlertDialog(
                                      title: Center(
                                          child: Text('New Record Added')),
                                      content: Text(
                                        "Yipee! You have added a new Waste Record to "
                                        "your account",
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          textColor: Colors.grey,
                                          child: const Text('Continue'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Text('Add Record',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal.shade900,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
