import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController oldPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
          title: "تغيير كلمة المرور"
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if(state is ChangePasswordSuccessState){
              showAlertDialogWithAction(
                buttonText: 'شكرا',
                context: context,
                imagePath: 'assets/images/vector1.png',
                message: 'تم تغيير كلمة المرور بنجاح',
                messageColor: kBlueColor,
                action: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              );
            }else if(state is ChangePasswordErrorState){
              showToast(text: 'فشل تغيير كلمة المرور', color: Colors.redAccent);
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Column(
              children: [
                SizedBox(height: 30,),
                Label(text: 'ادخل كلمة المرور السابقة'),
                SizedBox(height: 20,),
                CustomTextField(
                  controller: oldPassController,
                  isPassword: true,
                  hintText: 'كلمة المرور السابقة ',
                ),
                SizedBox(height: 30,),
                Label(text: 'ادخل كلمة المرور الجديدة'),
                SizedBox(height: 20,),
                CustomTextField(
                  controller: newPassController,
                  isPassword: true,
                  hintText: 'كلمة المرور الجديدة ',
                ),
                SizedBox(height: 30,),
                state is ChangePasswordLoadingState?
                CircularProgressIndicator(
                  color: kDarkBlueColor,
                )
                :CustomButton(
                  color: kDarkBlueColor,
                  label: 'حفظ كلمة المرور',
                  onTab: (){
                    if(
                    oldPassController != null&&
                    newPassController != null
                    ){
                      cubit.changePassword(
                        oldPass: oldPassController.text,
                        newPass: newPassController.text
                      );
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
