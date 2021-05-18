import 'package:flutter/material.dart';
import 'package:wastetastic/control/NearYouMgr.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:geopoint/geopoint.dart' as gp;

/// Boundary Class to display a loading animation
class LoadingScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static String id = "Loading Page";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /// The title to be displayed in the next screen
  String title;

  /// Overridden initState function to retrieve the device's current location
  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  /// Retrieves device's current location
  ///
  /// Makes call to controller function to retrieve device's current location.
  /// Transfers to the next screen once location is retrieved. Returns void.
  void retrieveLocation() async {
    //@todo add code for near by POI logic
    gp.GeoPoint location = await NearYouMgr.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
    Navigator.pushReplacementNamed(
      context,
      NearYouScreen.id,
      arguments: {
        'title': title,
        'location': location,
      },
    );
  }

  /// Renders the widgets onto the screen
  ///
  /// Displays a cricular progress indicator on the screen.
  @override
  Widget build(BuildContext context) {
    title = ModalRoute.of(context).settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lime),
            ),
            height: 125.0,
            width: 125.0,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
