import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class WorkshopsDetailsScreen extends StatelessWidget {
  const WorkshopsDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolywinAdminCubit, PolywinAdminStates>(
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'احصائيات الورش',
          ),
          body: cubit.workshopsDetailsModel == null
              ? LinearProgressIndicator(
                  color: kOrangeColor,
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              cubit.workshopsDetailsModel.result.payload.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: kCustomBoxDecoration,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '$kBaseURL${cubit.workshopsDetailsModel.result.payload[index].agentLogo}'))),
                                    ),
                                    Text(
                                      cubit.workshopsDetailsModel.result
                                              .payload[index].name ??
                                          '',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: kDarkBlueColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
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
                                      'المحافظة :',
                                      textDirection: TextDirection.rtl,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        cubit
                                                .workshopsDetailsModel
                                                .result
                                                .payload[index]
                                                .agentGovernorate ??
                                            '',
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
                                        cubit.workshopsDetailsModel.result
                                                .payload[index].agentAddress ??
                                            '',
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
                                        cubit.workshopsDetailsModel.result
                                            .payload[index].agentPhone,
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
                                        cubit.workshopsDetailsModel.result
                                                .payload[index].email ??
                                            '',
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
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
