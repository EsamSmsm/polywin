import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polywin/models/add_account_response.dart';
import 'package:polywin/models/add_client_account_response.dart';
import 'package:polywin/models/add_new_contract_response_model.dart';
import 'package:polywin/models/get_colors_model.dart' as colors;
import 'package:polywin/models/get_client_type.dart';
import 'package:polywin/models/get_cost_by_client_model.dart';
import 'package:polywin/models/installment_by_contact_id_model.dart';
import 'package:polywin/models/installments_model.dart';
import 'package:polywin/models/workshop_contracts_model.dart';
import 'package:polywin/models/workshop_models/get_all_clients.dart';
import 'package:polywin/models/workshop_models/get_contract_number_model.dart';
import 'package:polywin/models/workshop_models/get_total_price_model.dart';
import 'package:polywin/models/workshop_models/get_workshop_products.dart';
import 'package:polywin/models/workshop_models/workshop_factors_file_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/new_order_pricing_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_more_menu_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_home_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_order_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_nav_bar_screens/workshop_calculate_pricing_screen.dart';
import 'workshop_states.dart';

class WorkshopCubit extends Cubit<WorkshopStates> {
  WorkshopCubit() : super(WorkshopInitialState());
  static WorkshopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    WorkshopMoreMenuScreen(),
    WorkshopOrderScreen(),
    NewOrderPricingScreen(),
    WorkshopCalculatePricingScreen(),
    WorkshopHomeScreen(),
  ];

  List<String> navBarItemsLabel = [
    "المزيد",
    "طلبية",
    "تسعير",
    "عرض سعر",
    "الرئيسية",
  ];

  int selectedIndex = 4;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(ChangeWorkshopNavBarState());
  }

  int selectedItem = 4;
  List<Map<String, dynamic>> products = [
    {
      'title': 'شيش بليسيه',
      'icon': 'assets/images/شيش بليسيه.png',
      'isSelected': false,
      'id': 7
    },
    {
      'title': 'شيش حصيرة',
      'icon': 'assets/images/شيش حصيرة.png',
      'isSelected': false,
      'id': 6
    },
    {
      'title': 'باب',
      'icon': 'assets/images/door_icon.png',
      'isSelected': false,
      'id': 4
    },
    {
      'title': 'بلكونة',
      'icon': 'assets/images/balcony_icon.png',
      'isSelected': false,
      'id': 5
    },
    {
      'title': 'شباك',
      'icon': 'assets/images/شباك.png',
      'isSelected': false,
      'id': 1
    },
  ];

  void changeSelectedProduct(int index) {
    products[selectedItem]['isSelected'] = false;
    selectedItem = index;
    products[selectedItem]['isSelected'] = true;
    emit(ChangeProductSelection());
  }

  int productCount = 1;
  void addProduct() {
    productCount++;
    emit(AddProduct());
  }

  void removeProduct() {
    if (productCount > 0) productCount--;
    emit(RemoveProduct());
  }

  GetClientType getClientType;
  void getClientTypeList() {
    emit(GetClientTypeLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllClientType').then((value) {
      getClientType = GetClientType.fromJson(value.data);
      emit(GetClientTypeSuccessState());
    }).catchError((error) {
      emit(GetClientTypeErrorState());
    });
  }

  colors.Payload colorId;
  ListSub subCategoryId;

  List<dynamic> subCategories = [];
  GetWorkShopProductsModel workShopProductsModel;
  void getWorkShopProducts() {
    emit(GetWorkshopProductsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllParentSubCategory')
        .then((value) {
      workShopProductsModel = GetWorkShopProductsModel.fromJson(value.data);
      emit(GetWorkshopProductsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopProductsErrorState());
      print(error.toString());
    });
  }

  List<String> getUserTypes() {
    List<String> userTypes = [];
    getClientType.payload.forEach((element) {
      userTypes.add(element.name);
    });
    return userTypes;
  }

  GetAllClientsModel getAllClientsModel;
  void getAllClients() {
    emit(GetAllClientsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllClientByUserLogIn')
        .then((value) {
      getAllClientsModel = GetAllClientsModel.fromJson(value.data);
      print(value.data);
      emit(GetAllClientsSuccessState());
    }).catchError((error) {
      emit(GetAllClientsErrorState());
      print(error);
    });
  }

  List<dynamic> costList = [];

  String getCostsId() {
    List<String> calcCostsId = [];
    costList.forEach((element) {
      calcCostsId.add(element.id.toString());
    });
    String result = calcCostsId.map((val) => val.trim()).join(',');
    return result;
  }

  double getTotalCost() {
    double totalCost = 0;
    costList.forEach((element) {
      totalCost += element.totalCalc;
    });
    return totalCost;
  }

  AddNewContractResponseModel addNewContractResponseModel;
  void addNewContract(
      {int clientId,
      String description,
      dynamic totalCost,
      dynamic discount,
      dynamic totalWithDiscount,
      String costsIds}) {
    emit(AddContractLoadingState());
    DioHelper.postData(url: '/api/UserInfo/AddNewContract', data: {
      "invoicesNumber": contractNumberModel.payload,
      "clientId": clientId,
      "describtion": description,
      "totalInvoices": totalCost,
      "descountInvoices": discount,
      "totalWithInvoices": totalWithDiscount,
      "numberOfCostCalc": costsIds
    }).then((value) {
      addNewContractResponseModel =
          AddNewContractResponseModel.fromJson(value.data);
      print(value.data);
      emit(AddContractSuccessState());
    }).catchError((error) {
      emit(AddContractErrorState());
      print(error);
    });
  }

  GetTotalPriceModel totalPriceModel;
  void requestTotalPrice(
      {int subCategoryId,
      int colorId,
      String width,
      String height,
      var mortal,
      var expenses,
      var net}) {
    emit(RequestPriceLoadingState());
    DioHelper.postData(url: 'api/UserInfo/GetTotalPriceWithItems', data: {
      "subCategoryId": subCategoryId,
      "colorId": colorId,
      "width": width,
      "height": height,
      "mortal": mortal,
      "expenses": expenses,
      "net": net
    }).then((value) {
      totalPriceModel = GetTotalPriceModel.fromJson(value.data);
      emit(RequestPriceSuccessState());
      print(value.data);
    }).catchError((error) {
      emit(RequestPriceErrorState());
      debugPrint(error.toString());
    });
  }

  CreateClintAccountResponse addClientResponse;
  Future addClientAccount(
      {File logo,
      String userName,
      String address,
      String phone,
      String name,
      String email,
      String password,
      int clientTypeId}) async {
    var formData = FormData.fromMap({
      'password': password,
      'userName': userName,
      'Name': name,
      'ClientAddress': address,
      'ClientPhone': phone,
      'email': email,
      'userType': 4,
      'ClientTypeId': clientTypeId,
    });
    emit(AddClientLoadingState());
    DioHelper.postData(
      url: 'api/UserInfo/CreateNewClient',
      data: formData,
    ).then((value) {
      print(value.data);
      addClientResponse = CreateClintAccountResponse.fromJson(value.data);
      emit(AddClientSuccessState());
    }).catchError((error) {
      emit(AddClientErrorState());
      print(error.toString());
    });
  }

  GetContractNumberModel contractNumberModel;
  void getContractNumber() {
    emit(GetContractNumberLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetContractNumber').then((value) {
      contractNumberModel = GetContractNumberModel.fromJson(value.data);
      emit(GetContractNumberSuccessState());
    }).catchError((error) {
      emit(GetContractNumberErrorState());
      print(error);
    });
  }

  List<GetCostByClientIdModel> costsByClientModel;
  List<dynamic> costs;
  void getCostsByClient({int clientId}) {
    emit(GetCostByClientLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/GetCostCalcAssignClientId',
        query: {'ClientId': clientId}).then((value) {
      costs = value.data;
      print(value.data);
      costsByClientModel =
          costs.map((e) => GetCostByClientIdModel.fromJson(e)).toList();
      emit(GetCostByClientSuccessState());
    }).catchError((error) {
      emit(GetCostByClientErrorState());
      print(error);
    });
  }

  WorkshopContractsModel workshopContractsModel;
  void getWorkshopContracts() {
    emit(GetWorkshopContractsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllContractByWorkShop')
        .then((value) {
      workshopContractsModel = WorkshopContractsModel.fromJson(value.data);
      print(value.data);
      emit(GetWorkshopContractsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopContractsErrorState());
      print(error);
    });
  }

  List<dynamic> installmentByContractIdModel;
  void getInstallmentByClientId({int contractId}) {
    emit(GetWorkshopInstallmentsLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/GetAllInstallmentByContractId',
        query: {'ContractId': contractId}).then((value) {
      installmentByContractIdModel = value.data
          .map((e) => InstallmentByContractIdModel.fromJson(e))
          .toList();
      emit(GetWorkshopInstallmentsSuccessState());
    }).catchError((error) {
      emit(GetWorkshopInstallmentsErrorState());
      print(error);
    });
  }

  bool isInstallmentUpdated;
  void updateInstallment({int id}) {
    emit(UpdateInstallmentLoadingState());
    DioHelper.getData(url: 'api/UserInfo/UpdateInstallment', query: {'id': id})
        .then((value) {
      isInstallmentUpdated = value.data;
      print(value.data);
      isInstallmentUpdated
          ? emit(UpdateInstallmentSuccessState())
          : emit(UpdateInstallmentErrorState());
    }).catchError((error) {
      emit(UpdateInstallmentErrorState());
      print(error);
    });
  }

  bool isWarrantySuccess;
  void addNewWarranty({
    int contractId,
    int costCalcId,
  }) {
    emit(AddWarrantyLoadingState());
    DioHelper.postData(url: 'api/UserInfo/AddNewWarranty', data: {
      "contractId": contractId,
      "contractItemId": costCalcId,
    }).then((value) {
      isWarrantySuccess = value.data;
      print(value.data);
      emit(AddWarrantySuccessState());
    }).catchError((error) {
      emit(AddWarrantyErrorState());
      print(error);
    });
  }

  bool isInstallmentAddSuccess;
  void addInstallment(
      {int contractId,
      dynamic totalContract,
      int installmentNumber,
      int clientId}) {
    emit(CheckInstallmentLoadingState());
    DioHelper.postData(url: 'api/UserInfo/CheckInstallment', data: {
      "contractId": contractId,
      "totalContract": totalContract,
      "numberInstallment": installmentNumber,
    }).then((value) {
      DioHelper.postData(
              url: 'api/UserInfo/AddNewInstallment',
              query: {'clientId': clientId, 'ContractId': contractId},
              data: value.data)
          .then((value) {
        isInstallmentAddSuccess = value.data;
        emit(CheckInstallmentSuccessState());
      }).catchError((error) {
        emit(CheckInstallmentErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(CheckInstallmentErrorState());
      print(error);
    });
  }

  bool isImagesAdded;
  void addWarrantyGallery({
    int contractItemId,
    List<File> selectedImages,
  }) async {
    var formData = FormData();
    for (var file in selectedImages) {
      formData.files.addAll([
        MapEntry(
            "files",
            await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last)),
      ]);
    }
    emit(AddWarrantyGalleryLoadingState());
    DioHelper.postData(
            url: 'api/UserInfo/AddGalleryUser',
            query: {'contractItemId': contractItemId},
            data: formData)
        .then((value) {
      print(selectedImages.length);
      print(value.data);
      isImagesAdded = value.data;
      isImagesAdded
          ? emit(AddWarrantyGallerySuccessState())
          : emit(AddWarrantyGalleryErrorState());
    }).catchError((error) {
      emit(AddWarrantyGalleryErrorState());
      print(error);
    });
  }

  bool getCostByClientResponse;
  void sendTotalCostToUser({int costId, clientId}) {
    emit(SendTotalCostLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/UpdateCostCalcToClient',
        query: {'CostCalcId': costId, 'ClientId': clientId}).then((value) {
      getCostByClientResponse = value.data;
      emit(SendTotalCostSuccessState());
    }).catchError((error) {
      emit(SendTotalCostErrorState());
      print(error);
    });
  }

  WorkshopFactorsFileModel workshopFactorsFileModel;
  void getFactorsFile() {
    emit(GetFactorsFileLoadingState());
    DioHelper.getData(url: 'PolyWinLogIn/GetAllFactor').then((value) {
      workshopFactorsFileModel = WorkshopFactorsFileModel.fromJson(value.data);
      emit(GetFactorsFileSuccessState());
    }).catchError((error) {
      emit(GetFactorsFileErrorState());
      print(error);
    });
  }

  void fetchData() {
    getClientTypeList();
    getFactorsFile();
    getAllClients();
    getWorkShopProducts();
    getContractNumber();
    getWorkshopContracts();
  }
}
