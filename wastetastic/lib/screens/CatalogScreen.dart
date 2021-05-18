import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/screens/MapTestingScreen.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'POIDetailsScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/MapScreen.dart';

/// Boundary Class to display the UI for showing the catalog of Waste POI
///
/// * Implements various input error handling
/// * Makes calls to controller classes to retrieve necessary data from databases
class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  /// The user selected waste category
  String selectedCategory = 'LIGHTING WASTE';

  /// Whether a loading animation must be displayed
  bool loading = true;

  /// The catalog of Waste POIs to be displayed
  List<WastePOI> WastePOIs;

  /// Builds the Waste POI cards from the data
  List<POI_card> build_cat_cards(List<WastePOI> POIs) {
    List<POI_card> catalog_Cat = [];
    for (WastePOI wPOI in POIs) {
      catalog_Cat.add(
        POI_card(
          name: wPOI.POI_name,
          address: wPOI.address.trim(),
          postalcode: wPOI.POI_postalcode,
          description: wPOI.POI_description,
          wasteCategory: selectedCategory,
          fav: UserAccountMgr.isFav(wPOI),
          TO_POI_page: () async {
            await Navigator.pushNamed(
              context,
              POI_DetialScreen.id,
              arguments: wPOI,
            );
            if (POI_DetialScreen.favChanged) setState(() {});
          },
          FavFunct: () {
            setState(() {
              UserAccountMgr.editFav(wPOI);
            });
          },
        ),
      );
    }
    return catalog_Cat;
  }

  /// Renders the widgets onto the screen
  ///
  /// Implements various input error handling. Makes use of [WastePOIs] to keep
  /// track of the catalog of Waste POIs to be displayed. Makes use of [loading]
  /// to track whether a loading animation needs to be displayed while data is
  /// retrieved from the database.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header_card(
                title: 'Catalog',
              ),
              Container(
                child: Text('Choose by Waste Category:',
                    style:
                        TextStyle(fontSize: 23.0, fontFamily: 'DancingScript')),
              ),
              SizedBox(
                height: 8,
              ),
              SafeArea(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  decoration: BoxDecoration(
                    color: Colors.lime,
                    border: Border.all(
                      color: Colors.teal.shade900,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  //color: Colors.lime,
                  /*margin: EdgeInsets.symmetric(
                    horizontal: 100,
                  ),*/
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    value: selectedCategory,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.teal.shade900,
                    ),
                    // decoration: InputDecoration(
                    //
                    //   //icon: Icon(Icons.receipt_long),
                    //   prefix: Text("Filter by waste category: "),
                    // ),
                    iconSize: 24,
                    elevation: 20,
                    style: TextStyle(color: Colors.teal.shade900),
                    onChanged: (String newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        loading = true;
                      });
                    },
                    dropdownColor: Colors.lime.shade400,
                    items: kWasteCategory
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: StreamBuilder(
                    stream: CatalogMgr.getWastePOISnapshotsByCategory(
                      WasteCategory.values.firstWhere((element) =>
                          element.toString() ==
                          ('WasteCategory.' +
                              selectedCategory.replaceAll(' ', '_'))),
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !loading) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data.docs;
                        print('Inside builder $snapshot');
                        WastePOIs =
                            CatalogMgr.getWastePOIFromSnapshots(documents);
                        return Column(
                          children: build_cat_cards(WastePOIs),
                        );
                      } else {
                        loading = false;
                        return Center(
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
            ],
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
                            'title': selectedCategory[0] +
                                selectedCategory.toLowerCase().substring(1),
                            'WastePOI': WastePOIs,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
