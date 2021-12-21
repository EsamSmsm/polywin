import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polywin/screens/login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isHomeScreen;
  final bool isSigned;
  const CustomAppBar({this.title, this.isHomeScreen, this.isSigned = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(title),
      actions: [
        !isSigned
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 80,
                    child: Image(
                      image: AssetImage('assets/images/Polywin Logo.png'),
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
      centerTitle: true,
      flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26)),
          child: Image(
            image: AssetImage(
              "assets/images/HEADER.png",
            ),
            fit: BoxFit.fill,
          )),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90);
}
