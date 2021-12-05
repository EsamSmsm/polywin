import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/agents_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_stats_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

import '../add_agent_screen.dart';

class AdminAgentsScreen extends StatelessWidget {
  const AdminAgentsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      bloc: AppCubit()..getAgentsData(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'الوكلاء',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomButton2(color: Color(0xffFFA41B),label: 'اضافة وكيل',
                        onTab:(){
                          navigateTo(context,AddAgentScreen());
                        },),
                      Text('قائمة الوكلاء',style: TextStyle(color: kOrangeColor,
                          fontSize: 20),),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ConditionalBuilder(
                  condition: cubit.agentsModel != null,
                  fallback:(context) =>  Center(
                    child: LinearProgressIndicator(
                      color: kOrangeColor,
                    ),
                  ),
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.agentsModel.payload.length,
                    itemBuilder: (context, index) => AgentDataCard(
                      name: cubit.agentsModel.payload[index].name,
                      logo: '$kBaseURL${cubit.agentsModel.payload[index].agentLogo}',
                      address:cubit.agentsModel.payload[index].agentAddress,
                      governorate: cubit.agentsModel.payload[index].agentGovernorate,
                      phone: cubit.agentsModel.payload[index].agentPhone,
                      index: index,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        );
      },
    );
  }
}
