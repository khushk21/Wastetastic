import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:geopoint/geopoint.dart';
// import 'package:latlong/latlong.dart';
import 'dart:io';
import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/UserAccount.dart';
import 'package:wastetastic/screens/POIDetailsScreen.dart';

// import 'package:latlng/latlng.dart';

/// Boundary Class for testing map functionality
class MapTestingScreen extends StatefulWidget {
  static String id = 'MapTestingScreen';
  @override
  _MapTestingScreenState createState() => _MapTestingScreenState();
}

class _MapTestingScreenState extends State<MapTestingScreen> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  List<Marker> m = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    m.add(Marker(
        markerId: MarkerId("myMarker"),
        draggable: false,
        onTap: () {
          _customInfoWindowController.addInfoWindow(
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 15,
                          ),
//                          SizedBox(
//                            width: 8.0,
//                          ),
                          Flexible(
                            child: Text(
                              "Recycle your old lightbulbs and florescent tubes.Opens Mon 11:30am to 7:30pm, Tue to Sun 11:30am to 8pm. #01-06, Three Cubes, 55 Siglap Road",
                              overflow: TextOverflow.fade,
//                            style:
//                                Theme.of(context).textTheme.headline6.copyWith(
//                                      color: Colors.white,
//                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.blue,
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            LatLng(
              1.3126056503473,
              103.923168090089007,
            ),
          );
          print("Marker Tap");
        },
        position: LatLng(
          1.3126056503473,
          103.923168090089007,
        )));
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Maps"),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove();
            },
            onMapCreated: (GoogleMapController controller) async {
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition:
                CameraPosition(target: LatLng(1.3521, 103.8198), zoom: 12.0),
            markers: Set.from(m),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 75,
            width: 150,
            offset: 50,
          ),
        ]));
  }
}
