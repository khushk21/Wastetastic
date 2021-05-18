import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';

class Carpark_card extends StatelessWidget {
  //final String carParkNum;
  final String address;
  final String carParkType;
  final String parkingType;
  final String freeParking;
  final int avail_slots;

  Carpark_card(
      {this.address,
      this.carParkType,
      this.parkingType,
      this.freeParking,
      this.avail_slots});

  @override
  Widget build(BuildContext context) {
    String cpt= carParkType.toLowerCase();
    String cptt= cpt[0].toUpperCase()+cpt.substring(1);
    String pt= parkingType.toLowerCase();
    String ptt= pt[0].toUpperCase()+pt.substring(1);
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
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
      child: Column(
        children: [
          Text(
            "$address",
            style: TextStyle(
              height: 1.0,
              color: Colors.teal.shade900,
              letterSpacing: 1.25,
              fontSize: 15,
              //fontFamily: "DancingScript",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Car Park Type: $cptt\nParking Type: $ptt"
                  "\nFree Parking: $freeParking",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    height: 1.5,
                  ),
                ),
              ),
              VerticalDivider(
                width: 10.0,
                thickness: 10.0,
                color: Colors.red,
              ),
              Column(
                children: [
                  Text(
                    'Vacant:',
                    style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
                  ),
                  Text(
                    avail_slots.toString(),
                    style: TextStyle(
                      fontSize: 50,color: Colors.teal.shade900
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
