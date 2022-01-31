import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polywin/models/add_account_response.dart';
import 'package:polywin/models/get_workshops_model.dart';
import 'package:polywin/models/store_data_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/agent_screens/bottom_nav_bar_screens/agent_home_screen.dart';
import 'package:polywin/screens/agent_screens/bottom_nav_bar_screens/agent_more_menu_screen.dart';
import 'package:polywin/screens/new_order_pricing_screen.dart';
import 'package:polywin/screens/agent_screens/bottom_nav_bar_screens/agent_orders_screens.dart';
import 'package:polywin/screens/agent_screens/bottom_nav_bar_screens/agent_warehouse_screen.dart';
import 'agent_states.dart';

class AgentCubit extends Cubit<AgentStates> {
  AgentCubit() : super(AgentInitialState());

  static AgentCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    AgentMoreMenuScreen(),
    AgentOrdersScreen(),
    AgentWarehouseScreen(),
    NewOrderPricingScreen(),
    AgentHomeScreen(),
  ];

  int selectedIndex = 4;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(AgentBottomNavState());
  }

  AddAccountResponse addAccountResponse;
  Future addWorkshopAccount(
      {File logo,
      String governorate,
      String address,
      String phone,
      String name,
      String companyName,
      String email,
      String password,
      String userName}) async {
    emit(AddWorkshopLoadingState());
    var formData = FormData.fromMap({
      'userName': userName,
      'Photo': await MultipartFile.fromFile(logo.path,
          filename: logo.path.split('/').last),
      'agentGovernorate': governorate,
      'name': companyName,
      'nameAgent': name,
      'agentAddress': address,
      'agentPhone': phone,
      'email': email,
      'userType': 3,
      'password': password
    });
    DioHelper.postData(
      url: 'api/UserInfo/CreateNewAccount',
      data: formData,
    ).then((value) {
      print(value.data);
      emit(AddWorkshopSuccessState());
      print(value.data);
      addAccountResponse = AddAccountResponse.fromJson(value.data);
    }).catchError((error) {
      emit(AddWorkshopErrorState());
      print(error.toString());
    });
  }

  StoreDataModel getStoreDataModel;
  void getStoreData() async {
    emit(GetAgentStoreDataLoadingState());
    await DioHelper.getData(url: 'api/Store/GetAllStoreByUserId').then((value) {
      getStoreDataModel = StoreDataModel.fromJson(value.data);
      emit(GetAgentStoreDataSuccessState());
    }).catchError((error) {
      emit(GetAgentStoreDataErrorState());
      print(error.toString());
    });
  }

  GetWorkshopsModel workshopsModel;
  void getAllWorkshops() {
    emit(GetWorkshopsLoadingState());
    DioHelper.getData(url: 'api/Agent/GetWorkShopByUserLogin').then((value) {
      workshopsModel = GetWorkshopsModel.fromJson(value.data);
      emit(GetWorkshopsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopsSuccessState());
      print(error.toString());
    });
  }

  void fetchData() {
    getStoreData();
    getAllWorkshops();
    getAllGovernments();
  }

  List<dynamic> governments = [];
  void getAllGovernments() {
    emit(GetWorkshopGovernmentsLoadingState());
    DioHelper.getData(url: 'api/Government/GetAllGovernment').then((value) {
      governments = value.data;
      emit(GetWorkshopGovernmentsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopGovernmentsErrorState());
      print(error);
    });
  }

  File imageFile;
  Future<void> openGallery(BuildContext context) async {
    var picture =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    emit(PickWorkshopImageSuccessState());
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  Future<void> openCamera(BuildContext context) async {
    var picture =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    emit(PickWorkshopImageSuccessState());
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  Future<void> showPhotoDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "هل تريد التقاط الصورة من..؟",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  InkWell(
                    child: Text(
                      "الأستوديو",
                      style: TextStyle(fontSize: 20),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  InkWell(
                    child: Text(
                      "الكاميرا",
                      style: TextStyle(fontSize: 20),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
