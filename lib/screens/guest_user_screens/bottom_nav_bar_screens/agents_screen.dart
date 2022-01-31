import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class AgentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, AppStates state) {},
        builder: (context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'قائمة الوكلاء و الموزعين',
                          style: TextStyle(
                              color: kDarkBlueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ConditionalBuilder(
                    condition: cubit.agentsModel != null,
                    fallback: (context) => Center(
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
                        logo:
                            '$kBaseURL${cubit.agentsModel.payload[index].agentLogo}',
                        address: cubit.agentsModel.payload[index].agentAddress,
                        governorate:
                            cubit.agentsModel.payload[index].agentGovernorate,
                        phone: cubit.agentsModel.payload[index].agentPhone,
                        index: index,
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class AgentDataCard extends StatelessWidget {
  const AgentDataCard({
    Key key,
    this.name,
    this.logo,
    this.governorate,
    this.address,
    this.phone,
    this.index,
  }) : super(key: key);

  final String name;
  final String logo;
  final String governorate;
  final String address;
  final String phone;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        name,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: kOrangeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/home (2)@2x.png'),
                          )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'المحافظة',
                          style: TextStyle(fontSize: 13),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          governorate != null ? governorate : '',
                          style:
                              TextStyle(fontSize: 13, color: Color(0xff707070)),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/images/pin@2x.png'),
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'العنوان',
                          style: TextStyle(fontSize: 13),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 160,
                          child: Text(
                            address,
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff707070)),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'assets/images/phone-call (1)@2x.png'),
                          )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'الهاتف',
                          style: TextStyle(fontSize: 13),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 170,
                          child: Text(
                            AppCubit.get(context)
                                        .agentsModel
                                        .payload[index]
                                        .agentPhone ==
                                    null
                                ? '-'
                                : phone,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff707070),
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(logo), fit: BoxFit.contain)),
            ),
          ),
        ],
      ),
    );
  }
}
