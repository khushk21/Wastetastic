import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/entity/CarPark.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:geopoint/geopoint.dart' as gp;
import 'package:wastetastic/screens/POIDetailsScreen.dart';

/// Boundary Class to display the UI for showing the map on the screen
class MapScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static const String id = 'Map';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// An info window controller for info window displayed on tapping a map marker
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  //bool changed = false;

  /// A list of map markers to be displayed on the map
  List<Marker> markerList = [];

  /// Builds the map markers of the locations of the car parks
  void buildCarParkMarkerList(List<List> carParks, WastePOI w) {
    for (List c in carParks) {
      markerList.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(100),
          markerId: MarkerId(c[0].carParkNum),
          draggable: false,
          onTap: () {
            _customInfoWindowController.addInfoWindow(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "${c[0].address.trim()}. Singapore\nLots available: ${c[1]}\nCar Park Type:${c[0].carParkType} "
                                "\nParking Type: ${c[0].parkingType} \nFree Parking:${c[0].freeParking}",
                                overflow: TextOverflow.fade,
                                softWrap: false,
//                            style:
//                                Theme.of(context).textTheme.headline6.copyWith(
//                                      color: Colors.white,
//                                    ),
                              ),
                            ),
                            /*Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 15,
                            ),*/
//                          SizedBox(
//                            width: 8.0,
//                          ),
                            /*IconButton(
                              onPressed: () {
                                setState(() {
                                  UserAccountMgr.editFav(w);
                                });
                              },
                              iconSize: 20,
                              icon: Icon(
                                Icons.star,
                                color: UserAccountMgr.isFav(w)
                                    ? Colors.yellow.shade600
                                    : Colors.white,
                              ),
                            ),*/
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.lime,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(
                c[0].location.latitude,
                c[0].location.longitude,
              ),
            );
            print("Marker Tap");
          },
          position: LatLng(
            c[0].location.latitude,
            c[0].location.longitude,
          ),
        ),
      );
    }
    String POICategory = w.wasteCategory.toString().split('.').last;
    POICategory = POICategory.replaceAll('_', ' ').toLowerCase();
    POICategory = POICategory[0].toUpperCase() + POICategory.substring(1);
    markerList.add(
      Marker(
        markerId: MarkerId(w.id),
        draggable: false,
        onTap: () {
          _customInfoWindowController.addInfoWindow(
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        POI_DetialScreen.id,
                        arguments: w,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lime,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "${w.POI_name}\n${w.address.trim()}. Singapore ${w.POI_postalcode} "
                                "\nCategory: ${POICategory} \n${w.POI_description}",
                                overflow: TextOverflow.fade,
                                softWrap: false,
//                            style:
//                                Theme.of(context).textTheme.headline6.copyWith(
//                                      color: Colors.white,
//                                    ),
                              ),
                            ),
                            /*Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 15,
                              ),*/
//                          SizedBox(
//                            width: 8.0,
//                          ),
                            /*IconButton(
                                onPressed: () {
                                  setState(() {
                                    UserAccountMgr.editFav(w);
                                  });
                                },
                                iconSize: 20,
                                icon: Icon(
                                  Icons.star,
                                  color: UserAccountMgr.isFav(w)
                                      ? Colors.yellow.shade600
                                      : Colors.white,
                                ),
                              ),*/
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                    ),
                  ),
                ),
                Triangle.isosceles(
                  edge: Edge.BOTTOM,
                  child: Container(
                    color: Colors.lime,
                    width: 20.0,
                    height: 10.0,
                  ),
                ),
              ],
            ),
            LatLng(
              w.location.latitude,
              w.location.longitude,
            ),
          );
          print("Marker Tap");
        },
        position: LatLng(
          w.location.latitude,
          w.location.longitude,
        ),
      ),
    );
  }

  /// Builds the map markers of the locations of the Waste POIs
  void buildWastePOIMarkerList(List<WastePOI> WastePOIs) {
    for (WastePOI w in WastePOIs) {
      String POICategory = w.wasteCategory.toString().split('.').last;
      POICategory = POICategory.replaceAll('_', ' ').toLowerCase();
      POICategory = POICategory[0].toUpperCase() + POICategory.substring(1);
      markerList.add(
        Marker(
          markerId: MarkerId(w.id),
          draggable: false,
          onTap: () {
            _customInfoWindowController.addInfoWindow(
              Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          POI_DetialScreen.id,
                          arguments: w,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.lime,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "${w.POI_name}\n${w.address.trim()}. Singapore ${w.POI_postalcode} "
                                  "\nCategory: ${POICategory} \n${w.POI_description}",
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
//                            style:
//                                Theme.of(context).textTheme.headline6.copyWith(
//                                      color: Colors.white,
//                                    ),
                                ),
                              ),
                              /*Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 15,
                              ),*/
//                          SizedBox(
//                            width: 8.0,
//                          ),
                              /*IconButton(
                                onPressed: () {
                                  setState(() {
                                    UserAccountMgr.editFav(w);
                                  });
                                },
                                iconSize: 20,
                                icon: Icon(
                                  Icons.star,
                                  color: UserAccountMgr.isFav(w)
                                      ? Colors.yellow.shade600
                                      : Colors.white,
                                ),
                              ),*/
                            ],
                            mainAxisSize: MainAxisSize.max,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.lime,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(
                w.location.latitude,
                w.location.longitude,
              ),
            );
            print("Marker Tap");
          },
          position: LatLng(
            w.location.latitude,
            w.location.longitude,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    //UserAccountMgr.userDetails.printUserDetails();
  }

  /// Renders the widgets onto the screen
  ///
  /// Makes use of the device's location to determine where to center the map for
  /// view nearby Waste POI functionality. Makes use of Waste POI's location to
  /// determine where to center the map for viewing car parks near a specific Waste
  /// POI.
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final bool dispCarPark = args['dispCarPark'];
    final String title = args['title'];
    final gp.GeoPoint location = args['location'];
    LatLng targetLocation = LatLng(1.3521, 103.8198);
//    print('Map:' + location.latitude.toString());
//    print('Map:' + location.longitude.toString());
    if (location != null)
      targetLocation = LatLng(location.latitude, location.longitude);
    if (!dispCarPark)
      buildWastePOIMarkerList(args['WastePOI']);
    else
      buildCarParkMarkerList(args['carPark'], args['POI']);
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.square(75),
        //   child: AppBar(
        //     backgroundColor: Colors.teal[800],
        //     title: Text(
        //       title,
        //       style: TextStyle(fontSize: 35.0, fontFamily: "Source Sans Pro"),
        //     ),
        //     centerTitle: true,
        //     leading: IconButton(
        //       icon: Icon(Icons.arrow_back),
        //       onPressed: () {
        //         Navigator.pop(context, changed);
        //       },
        //     ),
        //   ),
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
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "DancingScript",
                        ),
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
          children: <Widget>[
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
                  CameraPosition(target: targetLocation, zoom: 12.0),
              markers: Set.from(markerList),
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 100,
              width: 250,
              offset: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Click on the markers for more info",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Source Sans Pro",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
