import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/CarParkMgr.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/CarparkCard.dart';
import 'MapScreen.dart';

/// Boundary Class to display the UI for showing the nearby car park information
///
/// Implements various input error handling. Makes calls to controller class
/// to retrieve the necessary data from databases.
class CarParkScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static const String id = 'Car_park_screen';
  @override
  _CarParkScreenState createState() => _CarParkScreenState();
}

class _CarParkScreenState extends State<CarParkScreen> {
  /// The Waste POI nearby to which car park results mustbe displayed
  WastePOI POI;

  /// The nearby car park information
  List<List> carParkInfo;

  /// Builds the Car Park card widgets from the data
  List<Widget> build_carpark_cards(List<List> carParkList) {
    //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
    List<Widget> carpark_card_list = [
      Center(
        child: Text(('Near ' + POI.POI_name + ':'),
            style: TextStyle(fontSize: 20.0, fontFamily: 'DancingScript')),
      ),
      //child: Text('Near ' + POI.POI_name)),
      SizedBox(
        height: 5,
      )
    ];
    for (List cp in carParkList) {
      carpark_card_list.add(Carpark_card(
        address: cp[0].address,
        freeParking: cp[0].freeParking,
        carParkType: cp[0].carParkType,
        parkingType: cp[0].parkingType,
        avail_slots: int.parse(cp[1]),
      ));
    }
    return carpark_card_list;
  }

  /// Renders the widgets onto the screen
  ///
  /// * Contains various input validations
  /// * Makes use of [POI] to keep track of required Waste POI
  /// * Makes use of [carParkInfo] to keep track of nearby car park to [POI]
  @override
  Widget build(BuildContext context) {
    POI = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Wastetastic'),
        //   centerTitle: true,
        // ),
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
        body: Stack(children: [
          Container(
            child: Column(children: [
              header_card(
                title: 'Car Parking Facilities',
              ),
              Expanded(
                  child: FutureBuilder(
                      future: CarParkMgr.retrieveNearbyCarParkInfo(
                          POI.nearbyCarPark),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          carParkInfo = snapshot.data;
                          return SingleChildScrollView(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: build_carpark_cards(
                                  snapshot.data), //POI_cards
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.lime),
                            ),
                          );
                        }
                      })),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          MapScreen.id,
                          arguments: {
                            'title': 'Car Park near ' + POI.POI_name,
                            'carPark': carParkInfo,
                            'location': POI.location,
                            'POI': POI,
                            'dispCarPark': true,
                          },
                        );
                        // Add your onPressed code here!
                      },
                      child: const Icon(Icons.map),
                      backgroundColor: Colors.teal.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
