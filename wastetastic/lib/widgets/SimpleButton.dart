import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final Function onPress;
  final String content;

  SimpleButton({this.onPress, this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      height: 60,
      child: RaisedButton(
        highlightColor: Colors.grey[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        onPressed: onPress,
        color: Colors.lime[50],
        padding: EdgeInsets.all(15.0),
        child: Text(
          content,
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 25.0,
            color: Colors.teal[900],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
