import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_location_picker.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'package:polywin/shared/location_screen.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    TextEditingController nameController =
        TextEditingController(text: cubit.getUserInfoModel.payload.name);
    TextEditingController phoneController =
        TextEditingController(text: cubit.getUserInfoModel.payload.agentPhone);
    TextEditingController emailController = TextEditingController(
      text: cubit.getUserInfoModel.payload.email != null
          ? cubit.getUserInfoModel.payload.email
          : '',
    );
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          AppCubit.get(context).getUserInfo();
          showAlertDialogWithAction(
              buttonText: 'شكرا',
              context: context,
              imagePath: 'assets/images/vector1.png',
              message: 'تم تعديل البيانات بنجاح',
              messageColor: kBlueColor,
              action: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              });
        } else if (state is UpdateProfileErrorState) {
          showToast(text: 'فشل تعديل البيانات', color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'بيانات المستخدم',
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
                                    fit: BoxFit.cover)
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
                    height: 20,
                  ),

                  ///user data form
                  Column(
                    children: [
                      ///name
                      Label(
                        text: 'الاسم',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: cubit.getUserInfoModel.payload.nameAgent,
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///phone
                      Label(
                        text: 'رقم الهاتف',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        hintText: cubit.getUserInfoModel.payload.agentPhone,
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
                        hintText: cubit.getUserInfoModel.payload.email != null
                            ? cubit.getUserInfoModel.payload.email
                            : '',
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
                        onTap: () async {
                          navigateTo(context, LocationPickerScreen());
                          // cubit.setLocation(context).then((value) {
                          //   print('lat:${cubit.lat},lang:${cubit.lang}');
                          // });
                          // final result = await
                          //     navigateTo(context, LocationScreen());
                          // print(result);
                          // lat = result['lat'];
                          // lang = result['long'];
                          // address = result['address'];
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: kBlueColor,
                            ),
                            Text(
                              'تحديد الموقع',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: kBlueColor,
                                  fontSize: 15,
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      ///save button
                      state is UpdateProfileLoadingState
                          ? CircularProgressIndicator(
                              color: kBlueColor,
                            )
                          : CustomButton(
                              color: kBlueColor,
                              label: 'حفظ',
                              onTab: () {
                                cubit.updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    logo: cubit.imageFile);
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
          ),
        );
      },
    );
  }
}
