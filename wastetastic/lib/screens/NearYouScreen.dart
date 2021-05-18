import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'package:wastetastic/control/NearYouMgr.dart';
import 'package:geopoint/geopoint.dart' as gp;

import 'package:wastetastic/Constants.dart';
import 'MapScreen.dart';
import 'POIDetailsScreen.dart';

/// Boundary Class to display the UI for showing the nearby Waste POI
///
/// * Implements user input error handling
/// * Makes use of controller classes to display the Waste POI results.
class NearYouScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static const String id = 'Near_You_Screen';
  @override
  _NearYouScreenState createState() => _NearYouScreenState();
}

class _NearYouScreenState extends State<NearYouScreen> {
  /// The list of Waste POIs to be displayed as results
  List<WastePOI> WastePOIs;

  /// The title to displayed in the app bar
  String title;

  /// Builds the Waste POI cards from the nearby Waste POI data
  List<POI_card> build_nearby_cards(List<WastePOI> nearbyWastePOI) {
    List<POI_card> nearbyPOI = [];
    for (WastePOI w in nearbyWastePOI) {
      String POICategory = w.wasteCategory.toString().split('.').last;
      POICategory = POICategory.replaceAll('_', ' ');
      if (POICategory == title.toUpperCase()) //&& w.location <= 20km
        nearbyPOI.add(
          POI_card(
            name: w.POI_name,
            address: w.address.trim(),
            postalcode: w.POI_postalcode,
            description: w.POI_description,
            wasteCategory: POICategory,
            fav: UserAccountMgr.isFav(w),
            TO_POI_page: () async {
              await Navigator.pushNamed(
                context,
                POI_DetialScreen.id,
                arguments: w,
              );
              if (POI_DetialScreen.favChanged) setState(() {});
            },
            FavFunct: () {
              setState(() {
                UserAccountMgr.editFav(w);
              });
            },
          ),
        );
    }
    return nearbyPOI;
  }

  /// Renders the widgets onto the screen
  ///
  /// Makes use of controller classes to determine the Waste POI to be displayed
  /// as results, to determine whether a Waste POI is a favorite of the logged
  /// in user, and to change the favorite status of a Waste POI.
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final gp.GeoPoint location = arguments['location'];
    title = arguments['title'];

    //@todo get user location and filter nearby locations
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
                  ])),
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
        body: Stack(
          children: [
            Column(children: [
              header_card(
                title: title,
              ),
              Text(
                'Nearby vendors for recycling:',
                style: TextStyle(fontSize: 23.0, fontFamily: 'DancingScript'),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: CatalogMgr.getWastePOISnapshotsByCategory(
                      WasteCategory.values.firstWhere((element) =>
                          element.toString() ==
                          ('WasteCategory.' +
                              title.toUpperCase().replaceAll(' ', '_'))),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        print('Inside builder $snapshot');
                        WastePOIs = NearYouMgr.retrieveNearbyWastePOI(
                            documents, location);
                        return Column(
                          children: build_nearby_cards(WastePOIs),
                        );
                      } else {
                        return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.lime),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ]),
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
                              'title': title,
                              'WastePOI': WastePOIs,
                              'location': location,
                              'dispCarPark': false,
                            },
                          );
                          // Add your onPressed code here!
                        },
                        child: const Icon(Icons.map),
                        backgroundColor: Colors.teal.shade700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: build_nearby_cards(), //POI_cards
//),
