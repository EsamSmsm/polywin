import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/change_password_screen.dart';
import 'package:polywin/shared/components/custom_dropdown_field.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_readonly_field.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      bloc: AppCubit()..getUserInfo(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'الملف الشخصي',
            isSigned: true,
          ),
          body: cubit.getUserInfoModel != null
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
                            SizedBox(
                              height: 120,
                              child: Container(
                                padding: EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '$kBaseURL${cubit.getUserInfoModel.payload.agentLogo}',
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            ///name
                            Label(
                              text: 'الاسم ',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomReadOnlyField(
                              hintText: cubit.getUserInfoModel.payload.name,
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
                              hintText:
                                  cubit.getUserInfoModel.payload.agentPhone,
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
                              hintText:
                                  cubit.getUserInfoModel.payload.email == null
                                      ? ''
                                      : cubit.getUserInfoModel.payload.email,
                              isPassword: false,
                              textDirection: TextDirection.rtl,
                              inputType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 24,
                            ),

                            /// location
                            Label(
                              text: 'الموقع',
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                MapsLauncher.launchCoordinates(
                                  double.parse(
                                      cubit.getUserInfoModel.payload.late),
                                  double.parse(
                                      cubit.getUserInfoModel.payload.long),
                                );
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    'عرض الموقع',
                                    style: TextStyle(
                                        color: kBlueColor,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: kBlueColor,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              color: kBlueColor,
                              label: 'تعديل البيانات',
                              onTab: () {
                                navigateTo(context, UpdateProfileScreen());
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              color: kBlueColor,
                              label: 'تغيير كلمة المرور',
                              onTab: () {
                                navigateTo(context, ChangePasswordScreen());
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
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
