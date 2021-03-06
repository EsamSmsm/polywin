import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/agents_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/catalogue_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/data_sheet_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/gallery_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/info_screen.dart';
import 'package:polywin/screens/guest_user_screens/home_screen.dart';
import 'package:polywin/screens/work_shop_screens/customers_screen.dart';
import 'package:polywin/screens/work_shop_screens/saved_Price_screen.dart';
import 'package:polywin/screens/saved_orders_screen.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';

import '../../user_profile_screen.dart';

class WorkshopMoreMenuScreen extends StatelessWidget {
  const WorkshopMoreMenuScreen({Key key}) : super(key: key);

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
                  SizedBox(
                    height: 20,
                  ),

                  ///list view
                  SizedBox(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SavedPriceScreen()));
                            },
                            title: Text(
                              '???????? ?????????? ????????????',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                            ),
                            trailing: Icon(
                              Icons.save_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SavedOrdersScreen()));
                            },
                            title: Text(
                              '???????????? ????????????',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                            ),
                            trailing: Icon(
                              CustomIcons.order,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CustomersScreen()));
                            },
                            title: Text(
                              '?????????? ??????????????',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                            ),
                            trailing: Icon(
                              CustomIcons.customers,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            title: Text(
                              '?????????? ???????????? ',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black54),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UserProfileScreen()));
                            },
                            trailing: Icon(
                              CustomIcons.avatar,
                              color: Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
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

class NavigatorToPublicScreen extends StatelessWidget {
  const NavigatorToPublicScreen({
    Key key,
    this.title,
    this.screen,
  }) : super(key: key);
  final String title;
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'polywin',
              style: TextStyle(fontSize: 17, color: kOrangeColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
              textDirection: TextDirection.rtl,
            )
          ],
        ),
      ),
    );
  }
}
