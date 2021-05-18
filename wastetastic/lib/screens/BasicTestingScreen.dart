import 'package:flutter/material.dart';
import 'package:wastetastic/control/CarParkMgr.dart';
import 'package:wastetastic/control/DatabaseCreator.dart';
import 'package:wastetastic/control/CatalogMgr.dart';
import 'package:wastetastic/control/WasteRecordMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/screens/MapTestingScreen.dart';

/// Debug Boundary Class used for initial testing and database creation
class BasicTestingScreen extends StatefulWidget {
  static const String id = 'basic_testing_screen';
  @override
  _BasicTestingScreenState createState() => _BasicTestingScreenState();
}

class _BasicTestingScreenState extends State<BasicTestingScreen> {
  /// Renders the widgets onto the screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            //DatabaseCreator.createDatabaseForEWaste();
            //DatabaseCreator.createDatabaseForLightingWaste();
            //DatabaseCreator.createDatabaseForWasteTreatment();
            //DatabaseCreator.createDatabaseForCashForTrash();
            //DatabaseCreator.createDatabaseForGeneralWasteCollectors();
            //DatabaseCreator.createDatabaseForCarPark();
            //CatalogMgr.readWastePOIByCategory(WasteCategory.LIGHTING_WASTE);
            //CarParkMgr.retrieveNearbyCarParkInfo(
            //['T7', 'T8', 'T1', 'T7A', 'T3']);
            //WasteRecordMgr.addNewRecord(
            //'rachel', DateTime.now(), 15, WasteCategory.E_WASTE);
            Navigator.pushNamed(context, MapTestingScreen.id);
          },
        ),
      ),
    );
  }
}
