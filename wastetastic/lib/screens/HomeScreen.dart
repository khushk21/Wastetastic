import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/LoadingScreen.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/widgets/CategoryButton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart' as lp;

/// Boundary Class to display the UI for showing the home screen
///
/// Implements various input error handling
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    UserAccountMgr.userDetails.printUserDetails();
  }

  /// Renders the widgets onto the screen
  ///
  /// Implements various input error handling.
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          header_card(
            title: 'Recycle Nearby',
          ),
          Container(
            child: Text('Choose waste category for nearby vendors:',
                style: TextStyle(fontSize: 23.0, fontFamily: 'DancingScript')),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryButton(
                          icon: Icons.delete,
                          category: 'Normal Waste',
                          redirect: () async {
                            ServiceStatus serviceStatus =
                                await PermissionHandler().checkServiceStatus(
                                    PermissionGroup.location);
                            if (serviceStatus != ServiceStatus.enabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please enable location services for this feature.",
                                ),
                              );
                              return;
                            }
                            lp.PermissionStatus permission =
                                await lp.LocationPermissions()
                                    .checkPermissionStatus();
                            if (permission == lp.PermissionStatus.denied) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please grant location permission for this feature.",
                                ),
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoadingScreen.id,
                              arguments: 'Normal Waste',
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width: ),
                        //Container(width: 1),
                        CategoryButton(
                          icon: Icons.phone_android,
                          category: 'E Waste',
                          redirect: () async {
                            ServiceStatus serviceStatus =
                                await PermissionHandler().checkServiceStatus(
                                    PermissionGroup.location);
                            if (serviceStatus != ServiceStatus.enabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please enable location services for this feature.",
                                ),
                              );
                              return;
                            }
                            lp.PermissionStatus permission =
                                await lp.LocationPermissions()
                                    .checkPermissionStatus();
                            if (permission == lp.PermissionStatus.denied) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please grant location permission for this feature.",
                                ),
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoadingScreen.id,
                              arguments: 'E Waste',
                            );
                          },
                        ),
                        CategoryButton(
                          icon:
                              Icons.emoji_objects_outlined, //lightbulb_outline,
                          category: 'Lighting Waste',
                          redirect: () async {
                            ServiceStatus serviceStatus =
                                await PermissionHandler().checkServiceStatus(
                                    PermissionGroup.location);
                            if (serviceStatus != ServiceStatus.enabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please enable location services for this feature.",
                                ),
                              );
                              return;
                            }
                            lp.PermissionStatus permission =
                                await lp.LocationPermissions()
                                    .checkPermissionStatus();
                            if (permission == lp.PermissionStatus.denied) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please grant location permission for this feature.",
                                ),
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoadingScreen.id,
                              arguments: 'Lighting Waste',
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryButton(
                          icon: Icons
                              .local_fire_department, //flare,//fireplace_outlined,//bubble_chart,//warning_rounded,
                          category: 'Waste Treatment',
                          redirect: () async {
                            ServiceStatus serviceStatus =
                                await PermissionHandler().checkServiceStatus(
                                    PermissionGroup.location);
                            if (serviceStatus != ServiceStatus.enabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please enable location services for this feature.",
                                ),
                              );
                              return;
                            }
                            lp.PermissionStatus permission =
                                await lp.LocationPermissions()
                                    .checkPermissionStatus();
                            if (permission == lp.PermissionStatus.denied) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please grant location permission for this feature.",
                                ),
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoadingScreen.id,
                              arguments: 'Waste Treatment',
                            );
                          },
                        ),
                        CategoryButton(
                          icon: Icons.attach_money_rounded,
                          category: 'Cash For Trash',
                          redirect: () async {
                            ServiceStatus serviceStatus =
                                await PermissionHandler().checkServiceStatus(
                                    PermissionGroup.location);
                            if (serviceStatus != ServiceStatus.enabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please enable location services for this feature.",
                                ),
                              );
                              return;
                            }
                            lp.PermissionStatus permission =
                                await lp.LocationPermissions()
                                    .checkPermissionStatus();
                            if (permission == lp.PermissionStatus.denied) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      "Please grant location permission for this feature.",
                                ),
                              );
                              return;
                            }
                            Navigator.pushNamed(
                              context,
                              LoadingScreen.id,
                              arguments: 'Cash For Trash',
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
