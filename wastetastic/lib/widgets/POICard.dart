import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';

class POI_card extends StatelessWidget {
  final String name;
  final int postalcode;
  final String address;
  final String description;
  final String wasteCategory;
  final Function TO_POI_page;
  final bool fav;
  final Function FavFunct;

  POI_card(
      {this.name,
      this.address,
      this.postalcode,
      this.description,
      this.wasteCategory,
      this.TO_POI_page,
      this.fav,
      this.FavFunct});

  @override
  Widget build(BuildContext context) {
    String cat = wasteCategory.toLowerCase();
    String wasteCat = cat[0].toUpperCase() + cat.substring(1);
    return RawMaterialButton(
      onPressed: TO_POI_page,
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          //color: Colors.teal[900],
          gradient: LinearGradient(
            //begin: Alignment.topRight,
            //end: Alignment.bottomLeft,
            colors: [
              Colors.lime.shade400,
              Colors.lightGreen.shade400,
            ],
          ),
          boxShadow: kContainerElevation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "$name\n$address\nPostal Code: $postalcode "
                "\nCategory: $wasteCat",
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  //fontFamily: "Source Sans Pro",
                  color: Colors.teal[900],
                  height: 1.5,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            VerticalDivider(
              width: 10.0,
              thickness: 10.0,
              color: Colors.red,
            ),
            IconButton(
              onPressed: FavFunct,
              iconSize: 35,
              icon: Icon(
                Icons.star,
                color: fav ? Colors.yellow.shade600 : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
