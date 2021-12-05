import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class WorkShopLayout extends StatelessWidget {
  WorkShopLayout({this.selectedIndex});
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopCubit, WorkshopStates>(
        listener: (context, WorkshopStates state) {},
        builder: (context, WorkshopStates state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
          return Scaffold(
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
                          icon: Icon(CustomIcons.more_menu), label: 'المزيد'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.order), label: 'طلبية'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.calculator), label: 'تسعير'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.show_price),
                          label: 'حساب التكلفة'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.home), label: 'الرئيسية'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
