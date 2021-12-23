import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/order_status_screens/refused_order.dart';
import 'package:polywin/screens/order_status_screens/underway_order.dart';
import 'package:polywin/screens/polywin_admin_screens/send_order_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'recieve_order_screen.dart';
import 'order_status_screens/received_order.dart';

class SavedOrdersScreen extends StatelessWidget {
  const SavedOrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetAllInvoicesErrorState) {
          showToast(text: 'حدث خطأ في تحميل البيانات', color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'الطلبيات',
            isSigned: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: Column(
              children: [
                DefaultTabController(
                    length: 3,
                    initialIndex: 2,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: false,
                            labelPadding: EdgeInsets.symmetric(vertical: 5),
                            physics: BouncingScrollPhysics(),
                            indicatorColor: kOrangeColor,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.w500),
                            tabs: [
                              Text(
                                'المرفوضة',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'GE_SS'),
                              ),
                              Text(
                                'الواردة',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'GE_SS'),
                              ),
                              Text(
                                'قيد التنفيذ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'GE_SS'),
                              ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  RefusedOrderTabScreen(),
                                  ReceivedOrderTabScreen(),
                                  UnderwayOrderTabScreen(),
                                ]),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
