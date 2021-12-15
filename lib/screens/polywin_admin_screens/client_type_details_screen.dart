import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

import 'bottom_nav_bar_screens/admin_stats_screen.dart';

class ClientTypeDetailsScreen extends StatelessWidget {
  const ClientTypeDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolywinAdminCubit, PolywinAdminStates>(
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'احصائيات العملاء',
          ),
          body: cubit.clientTypeDetailsModel == null
              ? LinearProgressIndicator(
                  color: kOrangeColor,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.clientTypeDetailsModel.payload.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: kCustomBoxDecoration,
                            child: Column(
                              children: [
                                Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cubit.clientTypeDetailsModel
                                          .payload[index].name,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: kDarkBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      cubit.clientTypeDetailsModel
                                          .payload[index].userType,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: kBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 1.5,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'الورشة :',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        cubit.clientTypeDetailsModel
                                            .payload[index].parentName,
                                        style:
                                            TextStyle(color: Color(0xff707070)),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'العنوان :',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        cubit.clientTypeDetailsModel
                                            .payload[index].clientAddress,
                                        style:
                                            TextStyle(color: Color(0xff707070)),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'التليفون :',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        cubit.clientTypeDetailsModel
                                            .payload[index].clientPhone,
                                        style:
                                            TextStyle(color: Color(0xff707070)),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'الايميل :',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        cubit.clientTypeDetailsModel
                                            .payload[index].email,
                                        style:
                                            TextStyle(color: Color(0xff707070)),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 16,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
