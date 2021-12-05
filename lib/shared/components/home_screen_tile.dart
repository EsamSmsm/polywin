import 'package:flutter/material.dart';

import '../constants.dart';

class HomeScreenTile extends StatelessWidget {
  const HomeScreenTile({
    this.label,
    this.onTab,
  });
  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
              ),
            ],
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: TextStyle(
                color: kBlueColor,
                fontSize: 18,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(width: 20),

            ///vertical gradient
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [kOrangeColor, kBlueColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            )
          ],
        ),
      ),
    );
  }
}
