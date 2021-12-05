import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'package:polywin/custom_icons/custom_icons.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({this.selectedIndex});
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, AppStates state) {},
        builder: (context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: cubit.appBarLabels[cubit.selectedIndex],
              isHomeScreen: false,
              isSigned: false,
            ),
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
                    selectedFontSize: 13,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(CustomIcons.agents),
                        label: ' الوكلاء ',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.gallery), label: ' المعرض '),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.data_sheet),
                          label: ' داتا شيت '),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.catalogue),
                          label: ' كتالوجات '),
                      BottomNavigationBarItem(
                        icon: Icon(CustomIcons.info),
                        label: ' عن الشركة ',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
