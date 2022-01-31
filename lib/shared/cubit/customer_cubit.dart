import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/models/client_models/client_contracts_model.dart';
import 'package:polywin/models/client_models/client_warranties_model.dart';
import 'package:polywin/models/client_models/contract_info_model.dart';
import 'package:polywin/models/client_models/workshop_info_model.dart';
import 'package:polywin/models/customer_warranties_model.dart';
import 'package:polywin/models/get_client_profile_model.dart';
import 'package:polywin/models/installment_by_contact_id_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/customer_screens/nav_bar_screens/customer_contracts_screen.dart';
import 'package:polywin/screens/customer_screens/nav_bar_screens/customer_gurantees_screen.dart';
import 'package:polywin/screens/customer_screens/nav_bar_screens/customer_menu_screen.dart';
import 'package:polywin/screens/customer_screens/nav_bar_screens/customer_profile.dart';
import 'package:polywin/screens/customer_screens/nav_bar_screens/workshop_info_screen.dart';
import 'package:polywin/screens/user_profile_screen.dart';
import 'customer_states.dart';

class CustomerCubit extends Cubit<CustomerStates> {
  CustomerCubit() : super(CustomerInitialState());

  static CustomerCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    CustomerMenuScreen(),
    WorkshopInfoScreen(),
    CustomerProfileScreen(),
    CustomerGuaranteesScreen(),
    CustomerContractsScreen()
  ];

  int selectedIndex = 4;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(CustomerBottomNavState());
  }

  GetWorkShopInfoModel workShopInfoModel;
  void getWorkShopInfo() {
    emit(GetWorkshopInfoLoadingState());
    DioHelper.getData(url: 'api/Agent/GetWorkShopByClient').then((value) {
      workShopInfoModel = GetWorkShopInfoModel.fromJson(value.data);
      print(value.data);
      emit(GetWorkshopInfoSuccessState());
    }).catchError((error) {
      emit(GetWorkshopInfoErrorState());
      print(error);
    });
  }

  GetClientInfoModel clientInfoModel;
  void getClientInfo() {
    emit(GetClientInfoLoadingState());
    DioHelper.getData(url: 'api/Client/GetClientInfoById').then((value) {
      clientInfoModel = GetClientInfoModel.fromJson(value.data);
      emit(GetClientInfoSuccessState());
    }).catchError((error) {
      emit(GetClientInfoErrorState());
      print(error);
    });
  }

  GetClientContractsModel clientContractsModel;
  void getAllClientContracts() {
    emit(GetClientContractsLoadingState());
    DioHelper.getData(url: 'api/Contract/GetAllContractByClient').then((value) {
      clientContractsModel = GetClientContractsModel.fromJson(value.data);
      emit(GetClientContractsSuccessState());
    }).catchError((error) {
      emit(GetClientContractsErrorState());
      print(error);
    });
  }

  List<dynamic> clientWarrantiesModel;
  void getCustomerWarranties() {
    emit(GetWarrantiesLoadingState());
    DioHelper.getData(url: 'api/Warranty/GetAllWarrantyByClientId')
        .then((value) {
      clientWarrantiesModel =
          value.data.map((e) => ClientWarrantiesModel.fromJson(e)).toList();
      print(value.data);
      emit(GetWarrantiesSuccessState());
    }).catchError((error) {
      emit(GetWarrantiesErrorState());
      print(error);
    });
  }

  List<dynamic> installmentByContractIdModel;
  void getInstallmentByClientId({int contractId}) {
    emit(GetInstallmentsLoadingState());
    DioHelper.getData(
        url: 'api/Installment/GetAllInstallmentByContractId',
        query: {'ContractId': contractId}).then((value) {
      installmentByContractIdModel = value.data
          .map((e) => InstallmentByContractIdModel.fromJson(e))
          .toList();
      emit(GetInstallmentsSuccessState());
    }).catchError((error) {
      emit(GetInstallmentsErrorState());
      print(error);
    });
  }

  ContractInfoModel contractInfoModel;
  void getContractInfo({int contractId}) {
    emit(GetContractInfoLoadingState());
    DioHelper.getData(
        url: 'api/Contract/GetContractInfoByContractId',
        query: {'contractId': contractId}).then((value) {
      contractInfoModel = ContractInfoModel.fromJson(value.data);
      emit(GetContractInfoSuccessState());
    }).catchError((error) {
      emit(GetContractInfoErrorState());
    });
  }

  void fetchData() {
    getClientInfo();
    getWorkShopInfo();
    getAllClientContracts();
    getCustomerWarranties();
  }
}
