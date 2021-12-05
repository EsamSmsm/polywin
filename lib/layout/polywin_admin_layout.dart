import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class PolywinAdminLayout extends StatelessWidget {
  PolywinAdminLayout({this.selectedIndex});
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
    builder: (context, appState) {
    return BlocBuilder<PolywinAdminCubit, PolywinAdminStates>(
        builder: (context, PolywinAdminStates state) {
          PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
          return Scaffold(
            // appBar: CustomAppBar(
            //   title: cubit.navBarItemsLabel[cubit.selectedIndex],
            //   isHomeScreen: true,
            // ),
            body: IndexedStack(
              children: cubit.screens,
              index: cubit.selectedIndex,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Container(
                  height: 70,
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    currentIndex: cubit.selectedIndex,
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      cubit.changeNavBar(value);
                    },
                    elevation: 30,
                    unselectedFontSize: 13,
                    unselectedItemColor: Colors.grey,
                    selectedFontSize: 13,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.customers), label: 'الوكلاء'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.order), label: 'الطلبيات'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.warehouse), label: 'المخزن'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.chart), label: 'احصائيات'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.home), label: 'الرئيسية'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  },
);
  }
}
