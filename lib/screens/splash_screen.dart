import 'package:flutter/material.dart';
import 'package:polywin/screens/guest_user_screens/home_screen.dart';
import 'package:polywin/shared/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration
                (
                  image: DecorationImage(image: AssetImage("assets/images/Mask Group 1.png"), fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 200),
            Container(
                height: 79,
                decoration: BoxDecoration
                  (
                    image: DecorationImage(image: AssetImage("assets/images/Polywin Logo.png"), )
                ),
            ),
            SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              height: 7,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [kBlueColor,kOrangeColor])
              ),
            )
          ],
        ),
      ),
    );
  }
}
