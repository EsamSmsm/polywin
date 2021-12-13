import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/models/get_client_type.dart';
import 'package:polywin/shared/components/custom_dropdown_field.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();

    return BlocConsumer<WorkshopCubit, WorkshopStates>(
      listener: (context, state) {
        WorkshopCubit cubit = WorkshopCubit.get(context);
        if (state is AddClientSuccessState) {
          if (cubit.addClientResponse.status == 'success') {
            cubit.getAllClients();
            showAlertDialogWithAction(
                message: 'تمت الاضافة بنجاح',
                buttonText: 'تم',
                context: context,
                imagePath: 'assets/images/deal.png',
                action: () {
                  nameController.text = null;
                  addressController.text = null;
                  phoneController.text = null;
                  passwordController.text = null;
                  userNameController.text = null;
                  emailController.text = null;
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
          } else {
            showToast(
                text: cubit.addClientResponse.message, color: Colors.redAccent);
          }
        } else if (state is AddClientErrorState) {
          showToast(text: 'حدث خطأ', color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        WorkshopCubit cubit = WorkshopCubit.get(context);
        Payload typeId;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'اضافة عميل',
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
                        'بيانات العميل',
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
                        text: 'اسم العميل',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'محمد احمد',
                        isPassword: false,
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///UserType
                      Label(
                        text: 'نوع العميل',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) => CustomDropdownField(
                          hint: 'نوع العميل',
                          itemsList: cubit.getClientType.payload.map((e) {
                            return DropdownMenuItem(
                              child: Text(
                                e.name,
                              ),
                              alignment: Alignment.centerRight,
                              value: e,
                            );
                          }).toList(),
                          value: typeId,
                          onChanged: (value) {
                            setState(() {
                              typeId = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      ///address
                      Label(
                        text: 'العنوان',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: addressController,
                        hintText: 'القاهرة-مدينةنصر',
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
                        hintText: 'example@gmail.com',
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
                        hintText: 'ahmed',
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
                        isPassword: false,
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      ///save button
                      ConditionalBuilder(
                        condition: state is! AddClientLoadingState,
                        builder: (context) => CustomButton(
                          color: kBlueColor,
                          label: 'اضافة عميل',
                          onTab: () {
                            if (nameController.text == '' ||
                                addressController.text == '' ||
                                phoneController.text == '' ||
                                passwordController.text == '') {
                              showToast(
                                  text: 'تأكد من ملئ البيانات بشكل صحيح',
                                  color: Colors.red);
                              cubit.emit((AddClientErrorState()));
                            } else {
                              cubit.addClientAccount(
                                email: emailController.text,
                                userName: userNameController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                                name: nameController.text,
                                address: addressController.text,
                                clientTypeId: typeId.id,
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
