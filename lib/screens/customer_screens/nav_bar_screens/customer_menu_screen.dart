import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/agents_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/catalogue_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/data_sheet_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/gallery_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/info_screen.dart';
import 'package:polywin/screens/guest_user_screens/home_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_more_menu_screen.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/constants.dart';
import 'package:share/share.dart';

class CustomerMenuScreen extends StatelessWidget {
  const CustomerMenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  ///logo
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Polywin Logo.png"),
                      ),
                    ),
                  ),

                  /// navigate to public screens
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          NavigatorToPublicScreen(
                            title: '????',
                            screen: InfoScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: '????????',
                            screen: GalleryScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: '???????? ??????',
                            screen: DataSheetScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: '????????????????',
                            screen: CatalogueScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: '??????????',
                            screen: AgentsScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.polywin.polywin');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '???????? ??????????????',
                          style: TextStyle(color: kBlueColor, fontSize: 24),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.share,
                          size: 30,
                          color: kBlueColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Text(
                      "???????? ????????  15231",
                      style: TextStyle(fontSize: 24, color: kOrangeColor),
                    ),
                    onPressed: () {
                      launchURL('tel:15231');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SocialRow(),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: Text(
                      '?????????? ????????????',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
