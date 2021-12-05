import 'package:flutter/material.dart';
import 'package:polywin/shared/constants.dart';
import '../../new_order_pricing_screen.dart';
import '../../saved_orders_screen.dart';

class WorkshopOrderScreen extends StatelessWidget {
  const WorkshopOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SavedOrNewBox(
            title: " polywin  طلبية من ",
            savedTitle: 'طلبية محفوظة',
            newTitle: 'طلبية جديدة',
            savedScreen: SavedOrdersScreen(),
            newScreen: NewOrderPricingScreen(),
          ),
        ),
      ),
    );
  }
}

class SavedOrNewBox extends StatelessWidget {
  const SavedOrNewBox({
    Key key,
    this.title,
    this.savedTitle,
    this.newTitle,
    this.savedScreen,
    this.newScreen,
  }) : super(key: key);

  final String title;
  final String savedTitle;
  final String newTitle;
  final Widget savedScreen;
  final Widget newScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              color: kDarkBlueColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => savedScreen));
                },
                child: Container(
                  height: 150,
                  decoration: kCustomBoxDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/floppy.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        savedTitle,
                        style: TextStyle(color: kBlueColor, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => newScreen));
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black45, blurRadius: 3)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/sticker.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        newTitle,
                        style: TextStyle(color: kBlueColor, fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
