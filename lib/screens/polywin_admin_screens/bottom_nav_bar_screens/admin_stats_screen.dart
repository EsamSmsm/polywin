import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/screens/polywin_admin_screens/agents_stats_details_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/client_type_details_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

import '../workshops_details_screen.dart';

class AdminStatsScreen extends StatelessWidget {
  const AdminStatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolywinAdminCubit, PolywinAdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
            appBar: CustomAppBar(
              title: 'احصائيات',
              isSigned: true,
            ),
            body: cubit.getWorkshopsCountModel != null &&
                    cubit.getAgentsCountModel != null &&
                    cubit.getClientTypeCountModel != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 26,
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 48,
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                StatsTile(
                                  onTab: () {
                                    navigateTo(
                                        context, WorkshopsDetailsScreen());
                                  },
                                  num: cubit.getWorkshopsCountModel.payload == 0
                                      ? '0'
                                      : cubit.getWorkshopsCountModel.payload
                                          .toString(),
                                  title: 'عدد الورش',
                                  imagePath: 'assets/images/chart1.png',
                                ),
                                StatsTile(
                                  onTab: () {
                                    navigateTo(context, AgentsDetailsScreen());
                                  },
                                  num: cubit.getAgentsCountModel.payload == 0
                                      ? '0'
                                      : cubit.getAgentsCountModel.payload
                                          .toString(),
                                  title: 'عدد الوكلاء',
                                  imagePath: 'assets/images/chart2.png',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 48,
                            child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  cubit.getClientTypeCountModel.payload.length,
                                  (index) => StatsTile(
                                    onTab: () {
                                      cubit.clientTypeDetailsModel = [];
                                      cubit.allClientsDetailsModel.payload
                                          .forEach((element) {
                                        if (element.userType ==
                                            cubit.getClientTypeCountModel
                                                .payload[index].clientType) {
                                          cubit.clientTypeDetailsModel
                                              .add(element);
                                        }
                                      });
                                      navigateTo(
                                          context, ClientTypeDetailsScreen());
                                    },
                                    num: cubit.getClientTypeCountModel
                                        .payload[index].count
                                        .toString(),
                                    title: cubit.getClientTypeCountModel
                                        .payload[index].clientType,
                                    imagePath: 'assets/images/chart4.png',
                                  ),
                                )),
                          ),
                        ),

                        /// workshops stats ///
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                        //   child: Row(
                        //     textDirection: TextDirection.rtl,
                        //     children: [
                        //       Text('احصائيات الوكلاء',style: TextStyle(
                        //           color: kOrangeColor,
                        //           fontSize: 20),
                        //         textDirection: TextDirection.rtl,),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 10,),
                        // ListView.separated(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: cubit.getAgentsStatisticsModel.payload.length,
                        //   itemBuilder: (context, index) =>AgentStatsCard(
                        //     agentName: cubit.getAgentsStatisticsModel.
                        //     payload[index].agentName??'',
                        //     totalInvoices: cubit.getAgentsStatisticsModel.
                        //     payload[index].totalInvoices??'',
                        //     totalPayed: cubit.getAgentsStatisticsModel.
                        //     payload[index].totalPayed??'',
                        //     imageUrl: cubit.getAgentsStatisticsModel.
                        //     payload[index].agentLogo??'',
                        //   ),
                        //   separatorBuilder: (context, index) => SizedBox(height: 16,),
                        // ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                : LinearProgressIndicator(
                    color: kOrangeColor,
                  ));
      },
    );
  }
}

class StatsTile extends StatelessWidget {
  const StatsTile({
    Key key,
    this.num,
    this.title,
    this.imagePath,
    this.onTab,
  }) : super(key: key);

  final String num;
  final String title;
  final String imagePath;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.all(14),
        padding: EdgeInsets.all(20),
        decoration: kCustomBoxDecoration.copyWith(boxShadow: [
          BoxShadow(color: Colors.transparent, blurRadius: 0),
        ], borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  num,
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
            Image(
              image: AssetImage(imagePath),
            )
          ],
        ),
      ),
    );
  }
}
