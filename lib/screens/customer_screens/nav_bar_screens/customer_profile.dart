import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_readonly_field.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';

import '../../update_profile_screen.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CustomerCubit cubit = CustomerCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'الملف الشخصي',
            isSigned: true,
          ),
          body: cubit.clientInfoModel != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'بيانات المستخدم',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: kOrangeColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        ///user data form
                        Column(
                          children: [
                            ///name
                            Label(
                              text: 'الاسم ',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomReadOnlyField(
                              hintText: cubit.clientInfoModel.name,
                              isPassword: false,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            ///phone
                            Label(
                              text: 'رقم الهاتف ',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomReadOnlyField(
                              hintText: cubit.clientInfoModel.clientPhone,
                              isPassword: false,
                              textDirection: TextDirection.rtl,
                              inputType: TextInputType.phone,
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            ///email
                            Label(
                              text: 'البريد الالكتروني',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomReadOnlyField(
                              hintText: cubit.clientInfoModel.email == null
                                  ? ''
                                  : cubit.clientInfoModel.email,
                              isPassword: false,
                              textDirection: TextDirection.rtl,
                              inputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            ///password
                            // Label(
                            //   text: 'كلمة المرور',
                            // ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            // CustomReadOnlyField(
                            //   hintText: '******',
                            //   textDirection: TextDirection.rtl,
                            //   inputType: TextInputType.text,
                            //   isPassword: true,
                            // ),
                            // SizedBox(
                            //   height: 24,
                            // ),

                            // /// location
                            // Label(
                            //   text: 'الموقع',
                            // ),
                            // SizedBox(
                            //   height: 16,
                            // ),
                            // GestureDetector(
                            //   onTap: (){
                            //     MapsLauncher.launchCoordinates(
                            //       cubit.lat, cubit.lang,);
                            //   },
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         'عرض الموقع',
                            //         style: TextStyle(
                            //             color: kBlueColor,
                            //             fontSize: 16,
                            //             decoration: TextDecoration.underline),
                            //       ),
                            //       SizedBox(width: 5,),
                            //       Icon(
                            //         Icons.location_on_outlined,
                            //         color: kBlueColor,
                            //       )
                            //     ],
                            //   ),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            //
                            // ///save button
                            // CustomButton(
                            //   color: kBlueColor,
                            //   label: 'تعديل البيانات',
                            //   onTab: (){
                            //     navigateTo(context, UpdateProfileScreen());
                            //   },
                            // ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : LinearProgressIndicator(
                  color: kOrangeColor,
                ),
        );
      },
    );
  }
}
