import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class AgentsDetailsScreen extends StatelessWidget {
  const AgentsDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolywinAdminCubit, PolywinAdminStates>(
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'احصائيات الوكلاء',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.getAgentsStatisticsModel.payload.length,
                    itemBuilder: (context, index) => AgentStatsCard(
                      agentName: cubit.getAgentsStatisticsModel.payload[index]
                              .agentName ??
                          '',
                      totalInvoices: cubit.getAgentsStatisticsModel
                              .payload[index].totalInvoices ??
                          '',
                      totalPayed: cubit.getAgentsStatisticsModel.payload[index]
                              .totalPayed ??
                          '',
                      imageUrl: cubit.getAgentsStatisticsModel.payload[index]
                              .agentLogo ??
                          '',
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AgentStatsCard extends StatelessWidget {
  const AgentStatsCard({
    Key key,
    this.agentName,
    this.totalInvoices,
    this.totalPayed,
    this.imageUrl,
  }) : super(key: key);

  final String agentName;
  final double totalInvoices;
  final double totalPayed;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                'الوكيل : ',
                                style:
                                    TextStyle(color: kBlueColor, fontSize: 18),
                              ),
                              SizedBox(width: 10),
                              Text(
                                agentName,
                                style:
                                    TextStyle(color: kBlueColor, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image(
                      image: NetworkImage('$kBaseURL$imageUrl'),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/Polywin Logo.png');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'البيع : ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          totalPayed.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey,
                ),
                Expanded(
                    child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المسحوبات : ',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          totalInvoices.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
