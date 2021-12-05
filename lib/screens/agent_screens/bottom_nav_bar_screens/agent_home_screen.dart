import 'package:flutter/material.dart';
import 'package:polywin/layout/agent_layout.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/screens/agent_screens/add_workshop_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/add_agent_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/adjust_discount_value.dart';
import 'package:polywin/screens/saved_orders_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_order_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/home_screen_tile.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';

import '../../prices_list_screen.dart';

class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomeScreen: true,
        title: 'الرئيسية',
        isSigned: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, left: 16, right: 16, top: 40),
          child: Column(
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
                height: 40,
              ),

              ///list view
              SizedBox(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // HomeScreenTile(
                      //   label: "طلبية من polywin",
                      //   onTab: () => showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       insetPadding: EdgeInsets.zero,
                      //       //contentPadding: EdgeInsets.zero,
                      //       clipBehavior: Clip.antiAliasWithSaveLayer,
                      //       content: Container(
                      //         width: MediaQuery.of(context).size.width * 0.8,
                      //         height: MediaQuery.of(context).size.height * 0.30,
                      //         child: SavedOrNewBox(
                      //           title: 'طلبية من polywin',
                      //           savedTitle: 'محفوظ',
                      //           savedScreen: SavedOrdersScreen(),
                      //           newTitle: 'جديد',
                      //           newScreen: AgentLayout(
                      //             selectedIndex:
                      //                 AgentCubit.get(context).selectedIndex = 3,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //SizedBox(height: 15),
                      HomeScreenTile(
                        label: "تسعير طلبية",
                        onTab: () {
                          navigateReplacement(
                              context,
                              AgentLayout(
                                selectedIndex:
                                    AgentCubit.get(context).selectedIndex = 3,
                              ));
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: "الطلبيات المستلمة",
                        onTab: () {
                          navigateReplacement(
                              context,
                              AgentLayout(
                                selectedIndex:
                                    AgentCubit.get(context).selectedIndex = 1,
                              ));
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: 'طلبياتي',
                        onTab: () {
                         navigateTo(context, SavedOrdersScreen());
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: "انشاء حساب ورشة",
                        onTab: () {
                          navigateTo(context, AddWorkshopScreen());
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: "جرد المخزن",
                        onTab: () {
                          navigateReplacement(
                              context,
                              AgentLayout(
                                selectedIndex:
                                    AgentCubit.get(context).selectedIndex = 2,
                              ));
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: "قوائم الأسعار",
                        onTab: () {
                          navigateTo(context, PricesListScreen());
                        },
                      ),
                      SizedBox(height: 15),
                      HomeScreenTile(
                        label: "المزيد",
                        onTab: () {
                          navigateReplacement(
                              context,
                              AgentLayout(
                                selectedIndex:
                                    AgentCubit.get(context).selectedIndex = 0,
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              ///social row
              SocialRow(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
