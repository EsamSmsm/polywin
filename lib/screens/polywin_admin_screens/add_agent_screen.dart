import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_dropdown_field.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_location_picker.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class AddAgentScreen extends StatelessWidget {
  const AddAgentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController agentNameController = TextEditingController();
    final TextEditingController agentIDController = TextEditingController();
    String governorate;
    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController agentPhoneController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    // final File image = PolywinAdminCubit.get(context).imageFile;

    return BlocConsumer<PolywinAdminCubit, PolywinAdminStates>(
      listener: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        if (state is AddAgentSuccessState) {
          if (cubit.addAccountResponse.status == 'success') {
            cubit.getAgentsCount();
            cubit.getAgentsStatistics();
            AppCubit.get(context).getAgentsData();
            showAlertDialogWithAction(
                message: 'تمت الاضافة بنجاح',
                buttonText: 'تم',
                context: context,
                imagePath: 'assets/images/deal.png',
                action: () {
                  cubit.imageFile = null;
                  agentNameController.text = null;
                  addressController.text = null;
                  agentPhoneController.text = null;
                  passwordController.text = null;
                  companyNameController.text = null;
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
          } else {
            showToast(
                text: cubit.addAccountResponse.message,
                color: Colors.redAccent);
          }
        }
      },
      // bloc: PolywinAdminCubit()..getAllGovernments(),
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'اضافة وكيل',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'بيانات الوكيل',
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
                      /// logo / image ///
                      GestureDetector(
                        onTap: () {
                          cubit.showPhotoDialog(context);
                        },
                        child: SizedBox(
                          height: 120,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                                image: cubit.imageFile != null
                                    ? DecorationImage(
                                        image: FileImage(cubit.imageFile),
                                        fit: BoxFit.contain)
                                    : null,
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey)),
                            child: cubit.imageFile == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'رفع صورة / لوجو',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.grey,
                                      )
                                    ],
                                  )
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///name
                      Label(
                        text: 'الاسم رباعي',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        hintText: 'محمد احمد حسين التابعي',
                        controller: agentNameController,
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///الرقم القومي للوكيل ///
                      Label(
                        text: 'الرقم القومي مكون من 14 رقم',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: agentIDController,
                        hintText: 'الرقم القومي',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                        inputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      /// المحافظة ///
                      Label(
                        text: 'المحافظة',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => CustomDropdownField(
                          hint: 'المحافظة',
                          itemsList: cubit.governments.map((e) {
                            return DropdownMenuItem(
                              child: Text(
                                e,
                              ),
                              value: e,
                              alignment: Alignment.centerRight,
                            );
                          }).toList(),
                          value: governorate,
                          onChanged: (value) {
                            setState(() {
                              governorate = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///COMPANY name
                      Label(
                        text: 'اسم الشركة',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: companyNameController,
                        hintText: 'اسم الشركة',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///COMPANY ADDRESS
                      Label(
                        text: 'العنوان ',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: addressController,
                        hintText: 'العنوان ',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///phone
                      Label(
                        text: 'رقم الهاتف ',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: agentPhoneController,
                        hintText: 'رقم الهاتف',
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
                      CustomTextField(
                        controller: emailController,
                        hintText: 'info@gmail.com',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                        inputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///userName
                      Label(
                        text: 'اسم المستخدم',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: userNameController,
                        hintText: 'example',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                        inputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///password
                      Label(
                        text: 'كلمة المرور',
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: '******',
                        textDirection: TextDirection.rtl,
                        inputType: TextInputType.text,
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     navigateTo(context, LocationPickerScreen());
                      //   },
                      //   child: Row(
                      //     textDirection: TextDirection.rtl,
                      //     children: [
                      //       Icon(
                      //         Icons.location_on_outlined,
                      //         color: kBlueColor,
                      //       ),
                      //       Text(
                      //         'تحديد الموقع',
                      //         textDirection: TextDirection.rtl,
                      //         style: TextStyle(
                      //             color: kBlueColor,
                      //             fontSize: 15,
                      //             decoration: TextDecoration.underline),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      ///save button
                      state is! AddAgentLoadingState
                          ? CustomButton(
                              color: kBlueColor,
                              label: 'اضافة وكيل',
                              onTab: () async {
                                //print('${cubit.latitude},${cubit.longitude}');
                                if (cubit.imageFile == null ||
                                    agentNameController.text == null ||
                                    addressController.text == null ||
                                    agentPhoneController.text == null ||
                                    passwordController.text == null ||
                                    companyNameController.text == null ||
                                    governorate == null ||
                                    userNameController.text == null) {
                                  showToast(
                                      text: 'تأكد من ملئ البيانات بشكل صحيح',
                                      color: Colors.red);
                                  cubit.emit(AddAgentErrorState());
                                } else {
                                  cubit.addAgentAccount(
                                    name: agentNameController.text,
                                    agentAddress: addressController.text,
                                    agentGovernorate: governorate,
                                    agentPhone: agentPhoneController.text,
                                    companyName: companyNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    userName: userNameController.text,
                                    logo: cubit.imageFile,
                                  );
                                }
                              },
                            )
                          : CircularProgressIndicator(
                              color: kBlueColor,
                            ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
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
