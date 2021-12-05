import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/network/local/cache_helper.dart';
import 'package:polywin/screens/login_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/add_agent_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/adjust_discount_value.dart';
import 'package:polywin/screens/prices_list_screen.dart';
import 'package:polywin/screens/work_shop_screens/saved_Price_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_order_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_calculate_pricing_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/home_screen_tile.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

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
          padding: const EdgeInsets.only(
              bottom: 20, left: 16, right: 16, top: 40),
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
                      HomeScreenTile(label: "احصائيات",onTab: (){
                        navigateReplacement(context, PolywinAdminLayout(selectedIndex: PolywinAdminCubit.get(context).selectedIndex=3,));
                      },),
                      SizedBox(height: 15),
                      HomeScreenTile(label: "الطلبيات",
                        onTab: (){
                          navigateReplacement(context, PolywinAdminLayout(selectedIndex: PolywinAdminCubit.get(context).selectedIndex=1,));
                        },),
                      SizedBox(height: 15),
                      HomeScreenTile(label: "انشاء حساب وكيل",
                        onTab: (){
                          navigateTo(context, AddAgentScreen());
                        },),
                      SizedBox(height: 15),
                      HomeScreenTile(label: " نسبة الخصم",
                      onTab: (){
                        navigateTo(context, AdjustDiscountValue());
                      },),
                      SizedBox(height: 15),
                      HomeScreenTile(label: "بيان المخزن الرئيسي",
                        onTab: (){
                          navigateReplacement(context, PolywinAdminLayout(selectedIndex: PolywinAdminCubit.get(context).selectedIndex=2,));
                        },),
                      SizedBox(height: 15),
                      HomeScreenTile(label: "قوائم الأسعار",
                        onTab: (){
                          navigateTo(context, PricesListScreen());
                        },),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: TextButton(onPressed: (){
                  logOut(context);
                  },
                    child: Text('تسجيل الخروج',style: TextStyle(color: Colors.red,fontSize: 20),)),
              ),
              SizedBox(height: 40,),
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
