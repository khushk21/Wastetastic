import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:wastetastic/screens/ResetPaswordScreen.dart';
import 'package:wastetastic/screens/WelcomeScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/entity/WasteRecord.dart';
import 'package:wastetastic/widgets/WasteRecordCard.dart';
import 'package:pie_chart/pie_chart.dart';

/// Boundary Class to display the UI for showing the profile details of the user
///
/// Makes use of controller classes to obtain the logged in user
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// The logged in user
  static UserAccount _loggedInUser;
  // variables for the toggle functionality //new
  /// Whether the list/pie chart mode is selected to display user's waste records.
  int selectIndex = 0;

  /// Boolean variable to display which sub-heading must be highlighted
  List<bool> isSelected = [true, false];

  /// Mapping required to render the pie chart
  Map<String, double> dataMap = {
    'NORMAL WASTE': 0,
    'E WASTE': 0,
    'LIGHTING WASTE': 0,
    'WASTE TREATMENT': 0,
    'CASH FOR TRASH': 0
  };

  /// Overridden initState method to obtain the logged in user details
  @override
  void initState() {
    super.initState();
    _loggedInUser = UserAccountMgr.userDetails;
  }

  /// Builds waste record cards from data
  ///
  /// Makes use of [_loggedInUser.waste_records] to display the user's waste
  /// records in a formatted manner. Returns the list of widgets to be rendered
  /// on screen
  List<Widget> buildWasteRecordCards() {
    List<WasteRecord_card> wasteRecordCards = [];
    List<WasteRecord> userRecord = _loggedInUser.waste_records;
    if (userRecord.isNotEmpty) {
      for (WasteRecord WR in userRecord) {
        String date = WR.dateTime.toString().substring(0, 10);
        String time = WR.dateTime.toString().substring(11, 19);
        String category = WR.category.toString().split('.').last;
        category = category.replaceAll('_', ' ');
        dataMap[category] += WR.weight; // for the pie chart
        wasteRecordCards.add(
          WasteRecord_card(
            time: time,
            date: date,
            category: category,
            weight: WR.weight,
          ),
        );
      }
      return wasteRecordCards;
    } else {
      return [
        SizedBox(
          height: 30,
        ),
        Icon(
          Icons.delete,
          color: Colors.grey[300],
          size: 80,
        ),
        Text(
          'No Waste Disposal Records Yet',
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ];
    }
  }

  /// Builds the pie chart.
  ///
  /// Makes use of [_loggedInUser.waste_records] in order to display the pie chart
  /// appropriately. Also implements checks for existence of waste records. Returns
  /// the pie chart widget.
  Widget buildPieChart() {
    // change the colors in this list to change PieChart colors
    List<Color> colorList = [
      Colors.red.shade700,
      Colors.blueGrey.shade700,
      Colors.blueAccent.shade200,
      Colors.yellow.shade900,
      Colors.teal.shade700,
    ];
    if (_loggedInUser.waste_records.isEmpty)
      return Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Icon(
            Icons.delete,
            color: Colors.grey[300],
            size: 80,
          ),
          Text(
            'No Waste Disposal Records Yet',
            style: TextStyle(
              fontSize: 25,
              color: Colors.grey[300],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    else
      return PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: 325,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.disc,
        legendOptions: LegendOptions(
          showLegendsInRow: true,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          chartValueStyle: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          showChartValueBackground: false,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: false,
        ),
        ringStrokeWidth: 200,
        //emptyColor: Colors.grey,
      );
  }

  /// Toggles the mode of viewing waste records
  ///
  /// Refreshes the UI based on changes in the mode of viewing, that is, list mode
  /// or pie chart mode.
  void toggle(int value) {
    setState(() {
      selectIndex = value;

      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        if (buttonIndex == selectIndex) {
          isSelected[buttonIndex] = true;
        } else {
          isSelected[buttonIndex] = false;
        }
      }
    });
  }

  /// Renders the widgets onto the screen
  ///
  /// Makes use of [_loggedInUser] to display the user's username and email address.
  /// Also displays the waste records of the user.
  Widget build(BuildContext context) {
    // variables used to detect swipe //new
    double initial = 0.0;
    double distance;
    // Widget list to select from when toggling //new
    List<Widget> WasteRecordStats = [
      GestureDetector(
          child: Column(
            children: buildWasteRecordCards(),
          ),
          onHorizontalDragStart: (DragStartDetails details) {
            initial = details.globalPosition.dx;
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            distance = details.globalPosition.dx - initial;
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            initial = 0.0;
            if (distance < 0) toggle(1);
            //+ve distance signifies a drag from left to right(start to end)
            //-ve distance signifies a drag from right to left(end to start)
          }),
      GestureDetector(
          child: buildPieChart(),
          onHorizontalDragStart: (DragStartDetails details) {
            initial = details.globalPosition.dx;
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            distance = details.globalPosition.dx - initial;
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            initial = 0.0;
            if (distance > 0) toggle(0);
            //+ve distance signifies a drag from left to right(start to end)
            //-ve distance signifies a drag from right to left(end to start)
          }),
    ];
    return SafeArea(
      child: Column(
        children: [
          header_card(
            title: 'My Profile',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Personal details: ',
                        style: TextStyle(
                          fontSize: 23.0,
                          fontFamily: 'DancingScript',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.lime,
                        boxShadow: kContainerElevation),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 75.0,
                              color: Colors.teal.shade900,
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8.0,
                                ),
                                child: Text(
                                  '${_loggedInUser.username}\n'
                                  '${_loggedInUser.email}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    height: 1.75,
                                    color: Colors.teal.shade900,
                                  ),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ResetPasswordScreen.id,
                                    arguments: {
                                      'email': _loggedInUser.email,
                                    });
                              },
                              child: Text(' Reset Password ',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.teal.shade900)),
                            ),
                            RaisedButton.icon(
                              icon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.logout),
                              ),
                              color: Colors.red.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () async {
                                try {
                                  await FirebaseAuth.instance.signOut();
                                  print("Successful sign out!");
                                } catch (e) {
                                  print("Error signing out!");
                                }
                                Navigator.popUntil(context,
                                    ModalRoute.withName(WelcomeScreen.id));
                              },
                              label: Text(
                                'Logout  ',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  //color: Colors.teal.shade900
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), //profile info
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.green,
                        colorScheme: ColorScheme.light(primary: Colors.green),
                      ),
                      child: ToggleButtons(
                        //borderRadius: BorderRadius.circular(20.0),
                        disabledColor: Colors.transparent,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        renderBorder: false,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Records",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pie Chart",
                            ),
                          ),
                        ],
                        onPressed: (int value) => toggle(value),
                        isSelected: isSelected,
                      ),
                    ),
                  ),
                  WasteRecordStats[selectIndex],
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
