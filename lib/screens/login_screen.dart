import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:polywin/layout/agent_layout.dart';
import 'package:polywin/layout/customert_layout.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/layout/workshop_layout.dart';
import 'package:polywin/network/local/cache_helper.dart';
import 'package:polywin/screens/guest_user_screens/home_screen.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:polywin/shared/cubit/auth_cubit/auth_states.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          if (state is LoginSuccessState) {
            if (state.loginModel.status == 'success') {
              print(state.loginModel.message);
              CacheHelper.setData(
                      key: 'token', value: state.loginModel.payload.token)
                  .then((value) {
                switch (LoginCubit.get(context).loginModel.payload.userType) {
                  case 1:
                    {
                      navigateAndFinish(context, PolywinAdminLayout());
                      CacheHelper.setData(key: 'userType', value: 1);
                    }
                    break;
                  case 2:
                    {
                      navigateAndFinish(context, AgentLayout());
                      CacheHelper.setData(key: 'userType', value: 2);
                    }
                    break;
                  case 3:
                    {
                      navigateAndFinish(context, WorkShopLayout());
                      CacheHelper.setData(key: 'userType', value: 3);
                    }
                    break;
                  case 4:
                    {
                      navigateAndFinish(context, CustomerLayout());
                      CacheHelper.setData(key: 'userType', value: 4);
                    }
                    break;
                  default:
                    {
                      navigateAndFinish(context, HomeScreen());
                    }
                }
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  text: state.loginModel.message, color: Colors.redAccent);
            }
          } else if (state is LoginErrorState) {
            showToast(text: 'تأكد من صحة البيانات', color: Colors.redAccent);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Mask Group 1.png"),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 79,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateReplacement(context, HomeScreen());
                        },
                        child: Container(
                            height: 79,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/images/Polywin Logo.png"),
                            ))),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            color: Color(0xffF26F21),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'اسم المستخدم ',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: userNameController,
                              keyboardType: TextInputType.text,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontFamily: 'roboto'),
                              cursorColor: Colors.grey,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "اسم المستخدم غير صالح";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  CustomIcons.avatar,
                                  color: Color(0xffA1A1A19E),
                                ),
                                fillColor: Color(0xfffcfcfc),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'اسم المستخدم',
                                hintStyle:
                                    TextStyle(color: Color(0xffA1A1A19E)),
                                contentPadding: EdgeInsets.all(10),
                                hintTextDirection: TextDirection.rtl,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'كلمة المرور ',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // CustomTextField(
                            //   hintText: 'كلمة المرور',
                            //   isPassword: true,
                            //   icon:Icons.visibility,
                            // ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: cubit.showPassword,
                              style: TextStyle(fontFamily: 'roboto'),
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "كلمة المرور غير صحيحة";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Color(0xfffcfcfc),
                                filled: true,
                                prefixIcon: GestureDetector(
                                  child: Icon(
                                    cubit.passwordIcon,
                                    color: Color(0xffA1A1A19E),
                                  ),
                                  onTap: () {
                                    cubit.changePasswordVisibility();
                                  },
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xfffcfcfc)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'كلمة المرور',
                                hintStyle:
                                    TextStyle(color: Color(0xffA1A1A19E)),
                                contentPadding: EdgeInsets.all(10),
                                hintTextDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),

                      ///login button
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => GestureDetector(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              cubit.userLogin(
                                  userName: userNameController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: Container(
                            height: 49,
                            margin: EdgeInsets.symmetric(horizontal: 36),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: kAppGradient),
                            child: Center(
                                child: Text(
                              'دخول',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                        fallback: (context) => CircularProgressIndicator(
                          color: kOrangeColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
