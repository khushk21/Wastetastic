import 'package:flutter/material.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/widgets/POICard.dart';
import 'POIDetailsScreen.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WastePOI.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';
import 'package:wastetastic/screens/MapScreen.dart';

/// Boundary Class to display the UI for showing the favorites
///
/// * Implements various input error handling
/// * Makes calls to controller class to retrieve information about the user
class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  /// List of favorite Waste POI of logged in user
  List<WastePOI> Fav_WastePOI_List;

  /// Builds Waste POI cards from the favorites data
  List<Widget> build_fav_cards() {
    Fav_WastePOI_List = UserAccountMgr.userDetails.favorites;
    //List<WastePOI> favorites = retrieveFavoritesFromDatabase(username)
    List<POI_card> fav_card_list = [];
    if (Fav_WastePOI_List.isNotEmpty) {
      for (WastePOI w in Fav_WastePOI_List) {
        String POICategory = w.wasteCategory.toString().split('.').last;
        POICategory = POICategory.replaceAll('_', ' ');
        fav_card_list.add(
          POI_card(
            name: w.POI_name,
            address: w.address.trim(),
            postalcode: w.POI_postalcode,
            description: w.POI_description,
            wasteCategory: POICategory,
            fav: true,
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
      return fav_card_list;
    } else {
      return [
        SizedBox(
          height: 100,
        ),
        Icon(
          Icons.star,
          color: Colors.grey[300],
          size: 80,
        ),
        Text(
          'No Favourites Yet',
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey[300],
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    }
  }

  /// Renders the widgets onto the screen
  ///
  /// Implements various input error handling. Makes use of [Fav_WastePOI_List]
  /// to keep track of the Waste POIs to be displayed.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              header_card(
                title: 'Favourites',
              ),
              Container(
                child: Text('A list of favourite recycling vendors:',
                    style:
                        TextStyle(fontSize: 23.0, fontFamily: 'DancingScript')),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: build_fav_cards(),
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
                            'WastePOI': Fav_WastePOI_List,
                            'title': 'Favorites',
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
