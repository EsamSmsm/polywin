import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polywin/screens/work_shop_screens/add_customer_screen.dart';
import 'package:polywin/screens/work_shop_screens/discounts_calculation_screen.dart';
import 'package:polywin/screens/work_shop_screens/contracts_and_guarantees_screen.dart';
import 'package:polywin/screens/prices_list_screen.dart';
import 'package:polywin/screens/work_shop_screens/installments_screen.dart';
import 'package:polywin/screens/work_shop_screens/saved_Price_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_order_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_calculate_pricing_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/home_screen_tile.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/constants.dart';

import '../../new_order_pricing_screen.dart';

class WorkshopHomeScreen extends StatelessWidget {
  const WorkshopHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomeScreen: true,
        title: 'الرئيسية',
        isSigned: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                          HomeScreenTile(
                            label: "حساب التكلفة",
                            onTab: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WorkshopCalculatePricingScreen()),
                              );
                            },
                          ),
                          SizedBox(height: 12),
                          HomeScreenTile(
                            label: "تقديم عقد / ضمان  للعميل",
                            onTab: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ContractsAndGuaranteesScreen()),
                              );
                            },
                          ),
                          SizedBox(height: 12),
                          HomeScreenTile(
                              label: "حساب التخصيمات",
                              onTab: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DiscountsCalculationScreen()),
                                );
                              }),
                          SizedBox(height: 12),
                          HomeScreenTile(
                              label: "تسعير طلبية",
                              onTab: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewOrderPricingScreen()),
                                );
                              }),
                          SizedBox(height: 12),
                          HomeScreenTile(
                              label: 'طلبية جديدة',
                              onTab: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WorkshopOrderScreen()),
                                );
                              }),
                          SizedBox(height: 12),
                          HomeScreenTile(
                              label: 'متابعة الاقساط',
                              onTab: () {
                                navigateTo(context, InstallmentsScreen());
                              }),
                          SizedBox(height: 12),
                          HomeScreenTile(
                              label: 'قوائم الاسعار',
                              onTab: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PricesListScreen()),
                                );
                              }),
                          SizedBox(height: 12),
                          HomeScreenTile(
                            label: 'اضافة عميل',
                            onTab: () {
                              navigateTo(context, AddClientScreen());
                            },
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),

                  ///contact us
                  Text(
                    "اتصل الان  15231",
                    style: TextStyle(fontSize: 24, color: kOrangeColor),
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  ///social row
                  SocialRow(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            ///gradient line
            Container(
              width: MediaQuery.of(context).size.width,
              height: 12,
              decoration: BoxDecoration(gradient: kAppGradient),
            ),
          ],
        ),
      ),
    );
  }
}
