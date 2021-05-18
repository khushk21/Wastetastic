import 'package:flutter/cupertino.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/boundary/CarParkScreen.dart';
import 'package:wastetastic/screens/FavouritesScreen.dart';
import 'package:wastetastic/screens/CatalogScreen.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

/// Boundary Class to display the UI for showing the details of a specific Waste POI
///
/// Makes use of controller classes to display favorite button appropriately
class POI_DetialScreen extends StatefulWidget {
  /// Whether the favorite status of the Waste POI has been changed
  static bool favChanged = false;

  /// Unique ID to identify the screen and set routing
  static const String id = 'POI_detail_screen';
  @override
  _POI_DetialScreenState createState() => _POI_DetialScreenState();
}

class _POI_DetialScreenState extends State<POI_DetialScreen> {
  /// Overridden initState function to initialize the [widget.favChanged] variable
  @override
  void initState() {
    POI_DetialScreen.favChanged = false;
    super.initState();
  }

  /// Renders the widgets onto the screen
  ///
  /// Makes use of controller classes to display favorite button appropriately.
  /// Displays the Waste POI details in a formatted manner.
  @override
  Widget build(BuildContext context) {
    final WastePOI POI = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(70), //fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.green.shade700,
                    Colors.teal.shade700,
                  ],
                ),
              ),
            ),
            title: Column(
              children: [
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Wastetastic',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "DancingScript",
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              ],
            ),
            centerTitle: true,
          ),
        ),
        body: Column(
          children: [
            header_card(
              title: 'POI Info',
            ),
            Container(
              child: Text('More details of the waste vendor:',
                  style:
                      TextStyle(fontSize: 23.0, fontFamily: 'DancingScript')),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.teal.shade700,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Name:      \t',
                            style: TextStyle(
                                color: Colors.teal.shade900,
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DancingScript'),
                          ),
                          Flexible(
                            child: Text(
                              POI.POI_name,
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Category:  \t',
                            style: TextStyle(
                                color: Colors.teal.shade900,
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DancingScript'),
                          ),
                          Flexible(
                            child: Text(
                              POI.wasteCategory
                                      .toString()
                                      .split('.')
                                      .last
                                      .replaceAll('_', ' ')[0]
                                      .toUpperCase() +
                                  POI.wasteCategory
                                      .toString()
                                      .split('.')
                                      .last
                                      .replaceAll('_', ' ')
                                      .toLowerCase()
                                      .substring(1),
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'About:     \t',
                            style: TextStyle(
                                color: Colors.teal.shade900,
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DancingScript'),
                          ),
                          Flexible(
                            child: Text(
                              POI.POI_description.trim(),
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Address:  \t',
                            style: TextStyle(
                                color: Colors.teal.shade900,
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DancingScript'),
                          ),
                          Flexible(
                            child: Text(
                              POI.address.trim() +
                                  '. Postal code: ' +
                                  POI.POI_postalcode.toString(),
                              style: TextStyle(
                                letterSpacing: 1,
                                height: 1.2,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    UserAccountMgr.editFav(POI);
                    POI_DetialScreen.favChanged = !POI_DetialScreen.favChanged;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Colors.lime,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                label: Text('Favourite',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal.shade900,
                      fontWeight: FontWeight.bold,
                    )),
                icon: Icon(
                  Icons.star,
                  color:
                      UserAccountMgr.isFav(POI) ? Colors.yellow : Colors.white,
                ),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    CarParkScreen.id,
                    arguments: POI,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: Colors.lime,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                label: Text('Nearby Car Park',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal.shade900,
                      fontWeight: FontWeight.bold,
                    )),
                icon: Icon(Icons.directions_car_rounded),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
