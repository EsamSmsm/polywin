import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/agent_states.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class AddWorkshopScreen extends StatelessWidget {
  const AddWorkshopScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController governorateController = TextEditingController();
    return BlocConsumer<AgentCubit, AgentStates>(
      listener: (context, state) {
        AgentCubit cubit = AgentCubit.get(context);
        if (state is AddWorkshopSuccessState) {
          if (cubit.addAccountResponse.status == 'success') {
            cubit.getAllWorkshops();
            showAlertDialogWithAction(
                message: 'تمت الاضافة بنجاح',
                buttonText: 'تم',
                context: context,
                imagePath: 'assets/images/deal.png',
                action: () {
                  cubit.imageFile = null;
                  nameController.text = null;
                  addressController.text = null;
                  governorateController.text = null;
                  phoneController.text = null;
                  passwordController.text = null;
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
      builder: (context, state) {
        AgentCubit cubit = AgentCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'اضافة الورشة',
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
                        'بيانات الورشة',
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
                                    image: FileImage(
                                      cubit.imageFile,
                                    ),
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
                    height: 24,
                  ),

                  ///user data form
                  Column(
                    children: [
                      ///name
                      Label(
                        text: 'اسم الورشة',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'اسم الورشة',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Label(
                        text: 'المحافظة',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: governorateController,
                        hintText: 'القاهرة',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///phone
                      Label(
                        text: 'رقم الهاتف المتصل بالواتس',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: phoneController,
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
                        height: 16,
                      ),
                      // ///confirm password
                      // Label(text: 'تأكيد كلمة المرور',),
                      // SizedBox(height: 16,),
                      // CustomTextField(hintText: '******',textDirection: TextDirection.rtl,inputType: TextInputType.text,isPassword: true,),
                      // SizedBox(height: 24,),
                      /// location
                      Label(
                        text: 'عنوان الورشة',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: addressController,
                        hintText: 'عنوان الورشة',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                        inputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      ///save button
                      ConditionalBuilder(
                        condition: state is! AddWorkshopLoadingState,
                        builder: (context) => CustomButton(
                          color: kBlueColor,
                          label: 'اضافة ورشة',
                          onTab: () async {
                            if (cubit.imageFile == null ||
                                nameController.text == '' ||
                                addressController.text == '' ||
                                governorateController.text == '' ||
                                phoneController.text == '' ||
                                passwordController.text == '' ||
                                userNameController.text == '') {
                              showToast(
                                  text: 'تأكد من ملئ البيانات بشكل صحيح',
                                  color: Colors.red);
                              cubit.emit(AddWorkshopErrorState());
                            } else {
                              await cubit.addWorkshopAccount(
                                email: emailController.text,
                                userName: userNameController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                logo: cubit.imageFile,
                                name: nameController.text,
                                address: addressController.text,
                                companyName: nameController.text,
                                governorate: governorateController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => CircularProgressIndicator(
                          color: kBlueColor,
                        ),
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
