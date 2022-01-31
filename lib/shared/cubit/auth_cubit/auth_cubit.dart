import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/models/login_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';

import 'auth_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;
  void userLogin({@required String userName, @required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'api/UserInfo/login', data: {
      "userName": userName,
      "password": password,
    }).then((value) {
      //print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool showPassword = true;
  IconData passwordIcon = Icons.visibility_outlined;
  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordIcon = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }
}
