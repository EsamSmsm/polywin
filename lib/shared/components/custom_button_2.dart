import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({
    Key key, this.color = kYellowColor, this.label, this.onTab,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: MediaQuery.of(context).size.width*0.4,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(label,
            style: TextStyle(color: Colors.white,),
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}