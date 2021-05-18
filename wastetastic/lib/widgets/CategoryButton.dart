import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String category;
  final Function redirect;

  CategoryButton({this.icon, this.category, this.redirect});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RawMaterialButton(
          elevation: 10,
          onPressed: redirect,
          child: Icon(
            icon,
            size: 80,
            color: Colors.teal.shade900,
          ),
          shape: CircleBorder(),
          fillColor: Colors.lime,
          padding: EdgeInsets.all(15.0),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          category,
          style: TextStyle(
            fontFamily: "DancingScript",
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
