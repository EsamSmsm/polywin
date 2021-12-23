import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/models/add_account_response.dart';
import 'package:polywin/models/admin_models/client_type_details_model.dart';
import 'package:polywin/models/admin_models/get_agents_count_model.dart';
import 'package:polywin/models/admin_models/get_agents_stats.dart';
import 'package:polywin/models/admin_models/get_discounts_model.dart';
import 'package:polywin/models/admin_models/get_workshops_count_model.dart';
import 'package:polywin/models/admin_models/edit_discounts_values.dart';
import 'package:polywin/models/admin_models/workshop_details_model.dart';
import 'package:polywin/models/get_client_type_count.dart';
import 'package:polywin/models/store_data_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_agents_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_home_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_orders_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_stats_screen.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_warehouse_screen.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';
import 'package:image_picker/image_picker.dart';

class PolywinAdminCubit extends Cubit<PolywinAdminStates> {
  PolywinAdminCubit() : super(PolywinAdminInitialState());

  static PolywinAdminCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    AdminAgentsScreen(),
    AdminOrdersScreen(),
    AdminWarehouseScreen(),
    AdminStatsScreen(),
    AdminHomeScreen(),
  ];

  int selectedIndex = 4;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(ChangePolywinAdminNavBarState());
  }

  List<dynamic> agentsDiscounts = [];
  List<dynamic> workshopsDiscounts = [];
  GetAllDiscountsModel getAllDiscountsModel;
  void getAllDiscounts() {
    emit(GetDiscountsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllDescount').then((value) {
      getAllDiscountsModel = GetAllDiscountsModel.fromJson(value.data);
      getAllDiscountsModel.payload.forEach((element) {
        if (element.typeOfDescount == 2) {
          agentsDiscounts.add(element);
        } else if (element.typeOfDescount == 3) {
          workshopsDiscounts.add(element);
        }
      });
      emit(GetDiscountsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDiscountsErrorState());
    });
  }

  GetWorkshopsCountModel getWorkshopsCountModel;
  void getWorkshopsCount() {
    emit(GetWorkshopsCountLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllUserTypeWorkShopCount')
        .then((value) {
      getWorkshopsCountModel = GetWorkshopsCountModel.fromJson(value.data);
      emit(GetWorkshopsCountSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWorkshopsCountErrorState());
    });
  }

  GetAgentsCountModel getAgentsCountModel;
  void getAgentsCount() {
    emit(GetAgentsCountLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllUserTypeAgentCount')
        .then((value) {
      getAgentsCountModel = GetAgentsCountModel.fromJson(value.data);
      emit(GetAgentsCountSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAgentsCountErrorState());
    });
  }

  StoreDataModel getStoreDataModel;
  void getStoreData() {
    emit(GetStoreDataLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllStoreByUserId').then((value) {
      getStoreDataModel = StoreDataModel.fromJson(value.data);
      emit(GetStoreDataSuccessState());
    }).catchError((error) {
      emit(GetStoreDataErrorState());
      print(error.toString());
    });
  }

  GetClientTypeCountModel getClientTypeCountModel;
  void getClientTypeCount() {
    emit(GetClientTypeCountLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetClientTypeCount').then((value) {
      getClientTypeCountModel = GetClientTypeCountModel.fromJson(value.data);
      emit(GetClientTypeCountSuccessState());
    }).catchError((error) {
      emit(GetClientTypeCountErrorState());
      print(error.toString());
    });
  }

  List<dynamic> clientTypeDetailsModel = [];
  ClientTypeDetailsModel allClientsDetailsModel;
  void getClientTypeDetails() {
    emit(GetClientTypeDetailsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetClientTypeDetails').then((value) {
      allClientsDetailsModel = ClientTypeDetailsModel.fromJson(value.data);
      emit(GetClientTypeDetailsSuccessState());
    }).catchError((error) {
      emit(GetClientTypeDetailsErrorState());
      print(error);
    });
  }

  GetAgentsStatisticsModel getAgentsStatisticsModel;
  void getAgentsStatistics() {
    emit(GetAgentsStatsLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/GetStatisticsForAgent',
        query: {'userType': 2}).then((value) {
      getAgentsStatisticsModel = GetAgentsStatisticsModel.fromJson(value.data);
      emit(GetAgentsStatsSuccessState());
    }).catchError((error) {
      emit(GetAgentsStatsErrorState());
      print(error.toString());
    });
  }

  WorkshopsDetailsModel workshopsDetailsModel;
  void getWorkshopsDetails() {
    emit(GetWorkshopsDetailsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllUserTypeWorkShopDetails')
        .then((value) {
      workshopsDetailsModel = WorkshopsDetailsModel.fromJson(value.data);
      emit(GetWorkshopsDetailsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopsDetailsErrorState());
      print(error);
    });
  }

  void fetchData() {
    getAllDiscounts();
    getAgentsCount();
    getWorkshopsCount();
    getStoreData();
    getClientTypeCount();
    getAgentsStatistics();
    getAllGovernments();
    getClientTypeDetails();
    getWorkshopsDetails();
  }

  String longitude, latitude;
  AddAccountResponse addAccountResponse;
  void addAgentAccount(
      {File logo,
      String agentGovernorate,
      String agentAddress,
      String agentPhone,
      String name,
      String companyName,
      String userName,
      String email,
      String password}) async {
    emit(AddAgentLoadingState());
    var formData = FormData.fromMap({
      'userName': userName,
      'Photo': await MultipartFile.fromFile(logo.path,
          filename: logo.path.split('/').last),
      'agentGovernorate': agentGovernorate,
      'name': companyName,
      'nameAgent': name,
      'agentAddress': agentAddress,
      'agentPhone': agentPhone,
      'email': email,
      'userType': 2,
      'password': password,
      'Long': longitude,
      'Late': latitude,
    });
    DioHelper.postData(
      url: 'api/UserInfo/CreateNewAccount',
      data: formData,
    ).then((value) {
      addAccountResponse = AddAccountResponse.fromJson(value.data);
      emit(AddAgentSuccessState());
      print(value.data);
    }).catchError((error) {
      emit(AddAgentErrorState());
      print(error.toString());
    });
  }

  EditDiscountsResponse editDiscountsResponse;
  void adjustDiscountValues({int id, int typeOfDiscount, double discount}) {
    emit(AdjustDiscountsLoadingState());
    DioHelper.postData(url: 'api/UserInfo/EditDescount', data: {
      "id": id,
      "typeOfDescount": typeOfDiscount,
      "descount": discount
    }).then((value) {
      editDiscountsResponse = EditDiscountsResponse.fromJson(value.data);
      print(value.data);
      emit(AdjustDiscountsSuccessState());
    }).catchError((error) {
      emit(AdjustDiscountsErrorState());
      print(error.toString());
    });
  }

  List<dynamic> governments = [];
  void getAllGovernments() {
    emit(GetGovernmentsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllGovernment').then((value) {
      governments = value.data;
      emit(GetGovernmentsSuccessState());
    }).catchError((error) {
      emit(GetGovernmentsErrorState());
      print(error);
    });
  }

  File imageFile;
  Future<void> openGallary(BuildContext context) async {
    var picture =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    emit(PickImageSuccessState());
    imageFile = File(picture.path);
    Navigator.of(context).pop();
  }

  Future<void> openCamera(BuildContext context) async {
    var picture =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    emit(PickImageSuccessState());
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
                      openGallary(context);
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
