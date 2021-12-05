import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/agent_states.dart';

class AgentLayout extends StatelessWidget {
  AgentLayout({Key key, this.selectedIndex}) : super(key: key);
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentCubit, AgentStates>(
        listener: (context, AgentStates state) {},
        builder: (context, AgentStates state) {
          AgentCubit cubit = AgentCubit.get(context);
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
                          icon: Icon(CustomIcons.more_menu), label: 'المزيد'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.order), label: 'الطلبيات'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.warehouse), label: 'المخزن'),
                      BottomNavigationBarItem(
                          icon: Icon(CustomIcons.calculator), label: 'تسعير'),
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
