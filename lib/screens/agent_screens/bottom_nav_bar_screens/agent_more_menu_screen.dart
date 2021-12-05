import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/screens/agent_screens/workshops_list_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/agents_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/catalogue_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/data_sheet_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/gallery_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/info_screen.dart';
import 'package:polywin/screens/saved_orders_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_more_menu_screen.dart';
import 'package:polywin/shared/components/defaults.dart';

import '../../user_profile_screen.dart';

class AgentMoreMenuScreen extends StatelessWidget {
  const AgentMoreMenuScreen({Key key}) : super(key: key);

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
                                          SavedOrdersScreen()));
                            },
                            title: Text(
                              'طلبيات محفوظة',
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
                                          WorkshopsListScreen()));
                            },
                            title: Text(
                              'قائمة الورش',
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
                              'الملف الشخصي ',
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
                            title: 'عن',
                            screen: InfoScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: 'معرض',
                            screen: GalleryScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: 'داتا شيت',
                            screen: DataSheetScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: 'كتالوجات',
                            screen: CatalogueScreen(),
                          ),
                          NavigatorToPublicScreen(
                            title: 'وكلاء',
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
                      'تسجيل الخروج',
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
