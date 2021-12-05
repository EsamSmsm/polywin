import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class AdminStatsScreen extends StatelessWidget {
  const AdminStatsScreen({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolywinAdminCubit,PolywinAdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(title: 'احصائيات',isSigned: true,),
          body: cubit.getWorkshopsCountModel!=null
              && cubit.getAgentsCountModel!=null
              &&cubit.getClientTypeCountModel!=null
              ?SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 26,),
                Center(
                  child: SizedBox(

                    width: MediaQuery.of(context).size.width - 48,
                    child: GridView.count(crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        StatsTile(
                          num: cubit.getWorkshopsCountModel.payload==0?'0':cubit.getWorkshopsCountModel.payload.toString(),
                          title: 'عدد الورش',imagePath: 'assets/images/chart1.png',),
                        StatsTile(
                          num: cubit.getAgentsCountModel.payload==0?'0':cubit.getAgentsCountModel.payload.toString(),
                          title: 'عدد الوكلاء',imagePath: 'assets/images/chart2.png',),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 48,
                    child: GridView.count(crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          cubit.getClientTypeCountModel.payload.length,
                              (index) =>  StatsTile(
                            num: cubit.getClientTypeCountModel.payload[index].count.toString(),
                            title: cubit.getClientTypeCountModel.payload[index].clientType,
                            imagePath: 'assets/images/chart4.png',),)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text('احصائيات الوكلاء',style: TextStyle(
                          color: kOrangeColor,
                          fontSize: 20),
                        textDirection: TextDirection.rtl,),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.getAgentsStatisticsModel.payload.length,
                  itemBuilder: (context, index) =>AgentStatsCard(
                    agentName: cubit.getAgentsStatisticsModel.
                    payload[index].agentName??'',
                    totalInvoices: cubit.getAgentsStatisticsModel.
                    payload[index].totalInvoices??'',
                    totalPayed: cubit.getAgentsStatisticsModel.
                    payload[index].totalPayed??'',
                    imageUrl: cubit.getAgentsStatisticsModel.
                    payload[index].agentLogo??'',
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16,),
                ),
                SizedBox(height: 20,)
              ],
            ),
          )
              :LinearProgressIndicator(
            color: kOrangeColor,
          )
        );
      },
    );
  }
}

class AgentStatsCard extends StatelessWidget {
  const AgentStatsCard({
    Key key, this.agentName, this.totalInvoices, this.totalPayed, this.imageUrl,
  }) : super(key: key);

  final String agentName;
  final double totalInvoices;
  final double totalPayed;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
    color: Colors.white,
      child: Column(
        children: [
          Expanded(flex:2,child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Text('الوكيل : ',style: TextStyle(color: kBlueColor,fontSize: 18),),
                            SizedBox(width: 10),
                            Text(agentName,style: TextStyle(color: kBlueColor,fontSize: 18),)
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
                    errorBuilder:(context, error, stackTrace) {
                      return Image.asset('assets/images/Polywin Logo.png');
                    },
                  ),
                ),
              ),
            ],
            ),
          ),
          Divider(thickness: 1.5,),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('البيع : ',style: TextStyle(
                          fontSize: 13,fontWeight: FontWeight.w600
                        ),
                        ),
                        Text(totalPayed.toString(),style: TextStyle(
                            fontSize: 15,
                        ),
                        ),
                      ],
                    ),
                  ),
                )),
                Container(width: 1,height:35,color: Colors.grey,),
                Expanded(child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('المسحوبات : ',style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.w600
                        ),
                        ),
                        Text(totalInvoices.toString(),style: TextStyle(
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

class StatsTile extends StatelessWidget {
  const StatsTile({
    Key key, this.num, this.title, this.imagePath,
  }) : super(key: key);

  final String num;
  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.all(20),
      decoration: kCustomBoxDecoration.copyWith(
          boxShadow: [BoxShadow(
        color: Colors.transparent,
        blurRadius: 0
      ),],
      borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(num,style: TextStyle(
                  fontSize: 24,fontFamily: 'roboto',
                  fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              Text(title,style: TextStyle(
                  fontSize: 12,color: Colors.black54,),)
            ],
          ),
          Image(image: AssetImage(imagePath),)
        ],
      ),
    );
  }
}
