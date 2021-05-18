import 'package:flutter/material.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/entity/WasteCategory.dart';

class WasteRecord_card extends StatelessWidget {
  //final String carParkNum;
  final String date;
  final String time;
  final String category;
  final double weight;

  WasteRecord_card({this.date, this.time, this.category, this.weight});

  @override
  Widget build(BuildContext context) {
    String cat= category.toLowerCase();
    String catt= cat[0].toUpperCase()+cat.substring(1);
    return Container(
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
              '  $catt\n  $date - $time',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 2,
              ),
            ),
          ),
          VerticalDivider(
            width: 10.0,
            thickness: 10.0,
            color: Colors.red,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weight:',
                style: TextStyle(fontSize: 15, color: Colors.teal.shade900),
              ),
              Text(
                weight.toString(),
                style: TextStyle(
                  fontSize: 45,
                    color: Colors.teal.shade900
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
