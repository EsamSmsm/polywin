import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/agent_screens/add_workshop_screen.dart';
import 'package:polywin/screens/work_shop_screens/add_customer_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/search_bar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/agent_states.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class WorkshopsListScreen extends StatelessWidget {
  const WorkshopsListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentCubit,AgentStates>(
      listener: (context, state) {

      },
      bloc: AgentCubit()..getAllWorkshops(),
      builder: (context, state) {
        AgentCubit cubit = AgentCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'قائمة الورش',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton2(label: 'اضافة ورشة',color: Color(0xffFFA41B),onTab: (){navigateTo(context, AddWorkshopScreen());},),
                      Text('قائمة الورش',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),textDirection: TextDirection.rtl,)
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.workshopsModel != null,
                  fallback: (context) => LinearProgressIndicator(
                    color: kOrangeColor,
                  ),
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.workshopsModel.result.payload.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: Text(cubit.workshopsModel
                            .result.payload[index].name==null?''
                        :cubit.workshopsModel.result.payload[index].name),
                        subtitle: Text(cubit.workshopsModel.result
                            .payload[index].agentPhone??'',
                          style: TextStyle(fontSize: 22,),),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
