import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  var icon, size, color, borderColor;
  CardButton({this.icon, this.size, this.color, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113,
      width: 131,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: borderColor,
              blurRadius: 10.0,
              offset: Offset(0, 8.0),
            ),
          ]),
      margin: EdgeInsets.all(10.0),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
