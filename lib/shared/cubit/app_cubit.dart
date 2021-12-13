import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polywin/models/add_ivoice_response.dart';
import 'package:polywin/models/agents_data_model.dart';
import 'package:polywin/models/data_sheet_model.dart';
import 'package:polywin/models/gallery_model.dart';
import 'package:polywin/models/get_all_invoices_from_polywin_model.dart';
import 'package:polywin/models/get_all_invoices_model.dart';
import 'package:polywin/models/get_catalogue_model.dart';
import 'package:polywin/models/get_colors_model.dart';
import 'package:polywin/models/get_company_info_model.dart';
import 'package:polywin/models/get_invoices_number.dart';
import 'package:polywin/models/get_parent_category.dart';
import 'package:polywin/models/get_products_list_model.dart';
import 'package:polywin/models/get_user_info.dart';
import 'package:polywin/models/search_product_model.dart';
import 'package:polywin/models/update_invoice_response_model.dart';
import 'package:polywin/models/update_profile_response_model.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/agents_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/catalogue_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/data_sheet_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/gallery_screen.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/info_screen.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    AgentsScreen(),
    GalleryScreen(),
    DataSheetScreen(),
    CatalogueScreen(),
    InfoScreen(),
  ];

  File imageFile;

  List<String> appBarLabels = [
    "الوكلاء و الموزعين",
    "المعرض",
    "داتا شيت",
    "كتالوجات",
    "عن الشركة"
  ];

  int selectedIndex = 4;
  void changeNavBar(int value) {
    selectedIndex = value;
    emit(ChangeNavBarState());
  }

  GetAgentsModel agentsModel;
  void getAgentsData() {
    emit(AgentsDataLoadingState());
    DioHelper.getData(
      url: 'PolyWinLogIn/GetAllAgents',
    ).then((value) {
      //print(value.data);
      agentsModel = GetAgentsModel.fromJson(value.data);
      if (agentsModel != null) emit(AgentsDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AgentsDataErrorState());
    });
  }

  GalleryModel galleryModel;
  void getGalleryData() {
    emit(GalleryDataLoadingState());
    DioHelper.getData(
      url: 'PolyWinLogIn/GetAllCategoryGallery',
    ).then((value) {
      galleryModel = GalleryModel.fromJson(value.data);
      // print(value.data);
      emit(GalleryDataSuccessState());
    }).catchError((error) {
      emit(GalleryDataErrorState());
      print(error.toString());
    });
  }

  CatalogueModel catalogueModel;
  void getCatalogues() {
    emit(GetCataloguesLoadingState());
    DioHelper.getData(url: 'PolyWinLogIn/GetAllCatalogue').then((value) {
      catalogueModel = CatalogueModel.fromJson(value.data);
      emit(GetCataloguesSuccessState());
      //print(value.data);
    }).catchError((error) {
      emit(GetCataloguesErrorState());
      print(error.toString());
    });
  }

  GetCompanyInfoModel getCompanyInfoModel;
  void getCompanyInfo() {
    emit(GetInfoLoadingState());
    DioHelper.getData(url: 'PolyWinLogIn/GetCompanyInfo').then((value) {
      getCompanyInfoModel = GetCompanyInfoModel.fromJson(value.data);
      emit(GetInfoSuccessState());
    }).catchError((error) {
      emit(GetInfoErrorState());
      print(error.toString());
    });
  }

  ProductsListModel productsListModel;
  void getProductsData() {
    emit(ProductsDataLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllProductPerCategory')
        .then((value) {
      productsListModel = ProductsListModel.fromJson(value.data);
      emit(ProductsDataSuccessState());
    }).catchError((error) {
      emit(ProductsDataErrorState());
      print(error.toString());
    });
  }

  GetParentCategoryModel getParentCategory;
  void getParentCategoryWithProducts() {
    emit(GetParentCategoryLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetParenrCategorywithProduct')
        .then((value) {
      getParentCategory = GetParentCategoryModel.fromJson(value.data);
      emit(GetParentCategorySuccessState());
    }).catchError((error) {
      emit(GetParentCategoryErrorState());
      print(error.toString());
    });
  }

  GetInvoicesNumber invoicesNumberModel;
  void getMaxInvoicesNumber() {
    emit(GetInvoicesNumberLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetMaxNumberIncoices').then((value) {
      invoicesNumberModel = GetInvoicesNumber.fromJson(value.data);
      emit(GetInvoicesNumberSuccessState());
    }).catchError((error) {
      emit(GetInvoicesNumberErrorState());
      print(error.toString());
    });
  }

  GetAllInvoicesModel getAllInvoicesModel;
  void getAllInvoices({int invoiceStatus}) {
    emit(GetAllInvoicesLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/GetAllInvoicesFromAgentOrWorkShop',
        query: {'isRecived': invoiceStatus}).then((value) {
      getAllInvoicesModel = GetAllInvoicesModel.fromJson(value.data);
      print(value.data);
      emit(GetAllInvoicesSuccessState());
    }).catchError((error) {
      emit(GetAllInvoicesErrorState());
      print(error.toString());
    });
  }

  GetAllInvoicesFromPolyWinModel getPolywinInvoicesModel;
  void getPolywinInvoices() {
    emit(GetPolywinInvoicesLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/GetAllInvoicesFromPolyWin',
        query: {'isRecived': 1}).then((value) {
      getPolywinInvoicesModel =
          GetAllInvoicesFromPolyWinModel.fromJson(value.data);
      emit(GetPolywinInvoicesSuccessState());
    }).catchError((error) {
      emit(GetPolywinInvoicesErrorState());
      print(error.toString());
    });
  }

  GetColorsModel colorsModel;
  void getColors() {
    emit(GetColorsLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAllColors').then((value) {
      colorsModel = GetColorsModel.fromJson(value.data);
      emit(GetColorsSuccessState());
    }).catchError((error) {
      emit(GetCataloguesErrorState());
      print(error.toString());
    });
  }

  GetUserInfoModel getUserInfoModel;
  void getUserInfo() {
    emit(GetUserInfoLoadingState());
    DioHelper.getData(url: 'api/UserInfo/GetAgentInfo').then((value) {
      getUserInfoModel = GetUserInfoModel.fromJson(value.data);
      print(value.data);
      emit(GetUserInfoSuccessState());
    }).catchError((error) {
      emit(GetUserInfoErrorState());
      print(error.toString());
    });
  }

  DataSheetModel dataSheetModel;
  void getDataSheet() {
    emit(GetDataSheetLoadingState());
    DioHelper.getData(url: 'PolyWinLogIn/GetAllDataSheet').then((value) {
      dataSheetModel = DataSheetModel.fromJson(value.data);
      emit(GetDataSheetSuccessState());
    }).catchError((error) {
      emit(GetDataSheetErrorState());
      print(error.toString());
    });
  }

  void fetchData() {
    getDataSheet();
    getAgentsData();
    getGalleryData();
    getProductsData();
    getParentCategoryWithProducts();
    getMaxInvoicesNumber();
    getPolywinInvoices();
    getCompanyInfo();
    getUserInfo();
    getCatalogues();
    getColors();
  }

  List<Map<String, dynamic>> order = [];
  void addProduct(
      {int id,
      String name,
      int numberIron,
      int categoryId,
      int quantity,
      double discount,
      double pricePerOne,
      double priceWithDiscount,
      String imgURL,
      double pricePerMeter,
      double totalOrder}) {
    bool isItemFound = false;
    if (order != null) {
      order.forEach((element) {
        if (element['productId'] == id) {
          element['quantity'] += quantity;
          element['totalOrder'] += totalOrder;
          isItemFound = true;
        }
      });
    }
    if (!isItemFound) {
      order.add({
        "productId": id,
        "productName": name,
        "numberIron": numberIron,
        "typeOfProduct": categoryId,
        "imgURL": imgURL,
        "quantity": quantity,
        "descount": discount,
        "pricePerOne": pricePerOne,
        "priceWithDescount": priceWithDiscount,
        "pricePerMeter": pricePerMeter,
        "totalOrder": totalOrder
      });
    }
  }

  SearchProductModel searchProductModel;
  Future searchProduct({String search}) {
    emit(GetSearchResultLoadingState());
    DioHelper.getData(
        url: 'api/UserInfo/SearchProduct',
        query: {'search': search}).then((value) {
      searchProductModel = SearchProductModel.fromJson(value.data);
      emit(GetSearchResultSuccessState());
      print(value.data);
    }).catchError((error) {
      emit(GetSearchResultErrorState());
      print(error.toString());
    });
  }

  AddInvoiceResponse invoiceResponse;
  Future addNewInvoice({
    //String description,
    double totalInvoices,
    double discountInvoices,
    double totalWithInvoices,
  }) async {
    print('totalInvoices: $totalInvoices,'
        'discountInvoices: $discountInvoices, totalWithInvoices: $totalWithInvoices');
    emit(AddInvoiceLoadingState());
    DioHelper.postData(url: 'api/UserInfo/AddNewInvoices', data: {
      "id": 0,
      "invoicesNumber": invoicesNumberModel.payload,
      "isRecived": true,
      "isRecivedText": "string",
      "describtion": "string",
      "totalInvoices": totalInvoices,
      "descountInvoices": discountInvoices,
      "totalWithInvoices": totalWithInvoices,
      "totalPayed": 0,
      "totalAmount": 0,
      "details": [
        {
          "id": 0,
          "productId": 0,
          "productName": "string",
          "numberIron": 0,
          "typeOfProduct": 0,
          "typeOfProductText": "string",
          "quantity": 0,
          "descount": 0,
          "pricePerOne": 0,
          "priceWithDescount": 0,
          "pricePerMeter": 0,
          "isRecived": true,
          "imgURL": "string",
          "totalOrder": 0
        }
      ],
      "fromUserId": "string",
      "toUserId": "string"
    }).then((value) {
      invoiceResponse = AddInvoiceResponse.fromJson(value.data);
      emit(AddInvoiceSuccessState());
      print(value.data);
      addInvoiceDetails();
    }).catchError((error) {
      emit(AddInvoiceErrorState());
      print(error.toString());
    });
  }

  bool addInvoiceDetailsResponse;
  void addInvoiceDetails() {
    emit(AddInvoiceDetailsLoadingState());
    DioHelper.postData(
      query: {'invoiceId': invoiceResponse.payload},
      url: '/api/UserInfo/AddInvoicesDetails',
      data: order,
    ).then((value) {
      emit(AddInvoiceDetailsSuccessState());
      addInvoiceDetailsResponse = value.data;
      print(value.data);
    }).catchError((error) {
      emit(AddInvoiceDetailsErrorState());
      print(error.toString());
    });
  }

  List<Map<String, dynamic>> invoiceDetails = [];
  void insertInvoice({int id, String description, bool isReceived}) {
    invoiceDetails
        .add({"id": id, "description": description, "isRescived": isReceived});
    //print(invoiceDetails);
  }

  void updateInvoice({int index, int id, String description, bool isReceived}) {
    invoiceDetails.insert(index,
        {"id": id, "description": description, "isRescived": isReceived});
    invoiceDetails.removeAt(index + 1);
    print('$invoiceDetails\n');
  }

  bool sendInvoiceResponse;
  Future updateInvoiceDetails({int invoiceId}) {
    emit(UpdateInvoiceDetailsLoadingState());
    DioHelper.postData(
      url: 'api/UserInfo/UpdateInvoicesDetails',
      query: {'invoiceId': invoiceId},
      data: invoiceDetails,
    ).then((value) {
      sendInvoiceResponse = value.data;
      emit(UpdateInvoiceDetailsSuccessState());
      print(value.data);
    }).catchError((error) {
      emit(UpdateInvoiceDetailsErrorState());
      print(error);
    });
  }

  UpdateInvoiceResponseModel updateInvoiceResponseModel;
  void sendInvoice({
    int invoiceId,
    String description,
  }) {
    emit(SendInvoiceLoadingState());
    DioHelper.getData(url: 'api/UserInfo/UpdateInvoices', query: {
      'invoiceId': invoiceId,
      'description': description,
      'isRecived': true,
    }).then((value) {
      updateInvoiceResponseModel =
          UpdateInvoiceResponseModel.fromJson(value.data);
      updateInvoiceDetails(invoiceId: invoiceId);
      emit(SendInvoiceSuccessState());
    }).catchError((error) {
      emit(SendInvoiceErrorState());
      print(error.toString());
    });
  }

  UpdateProfileResponseModel updateProfileResponseModel;
  Future<void> updateProfile({
    String name,
    String email,
    String phone,
    File logo,
  }) async {
    var formData = FormData.fromMap({
      "userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "id": getUserInfoModel.payload.id,
      "email": email,
      "userType": 0,
      "name": name,
      "nameAgent": getUserInfoModel.payload.nameAgent,
      "agentLogo": logo != null
          ? await MultipartFile.fromFile(logo.path,
              filename: logo.path.split('/').last)
          : null,
      "agentGovernorate": getUserInfoModel.payload.agentGovernorate,
      "agentAddress": getUserInfoModel.payload.agentAddress,
      "agentPhone": phone,
      "photo": logo != null
          ? await MultipartFile.fromFile(logo.path,
              filename: logo.path.split('/').last)
          : null,
      "long": lang.toString(),
      "late": lat.toString()
    });
    emit(UpdateProfileLoadingState());
    DioHelper.postData(url: 'api/UserInfo/UpdateAgentInfo', data: formData)
        .then((value) {
      updateProfileResponseModel =
          UpdateProfileResponseModel.fromJson(value.data);
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      emit(UpdateProfileErrorState());
      print(error);
    });
  }

  bool isPasswordChanged;
  void changePassword({String oldPass, newPass}) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
            url: 'api/UserInfo/ChangePassword',
            data: {"currentPassword": oldPass, "newPassword": newPass})
        .then((value) {
      isPasswordChanged = value.data;
      isPasswordChanged
          ? emit(ChangePasswordSuccessState())
          : emit(ChangePasswordErrorState());
    }).catchError((error) {
      emit(ChangePasswordErrorState());
      print(error);
    });
  }

  void refuseInvoice({
    int invoiceId,
    String description,
  }) {
    emit(RefuseInvoiceLoadingState());
    DioHelper.getData(url: 'api/UserInfo/UpdateInvoices', query: {
      'invoiceId': invoiceId,
      'description': description,
      'isRecived': false,
    }).then((value) {
      updateInvoiceResponseModel =
          UpdateInvoiceResponseModel.fromJson(value.data);
      //updateInvoiceDetails(invoiceId: invoiceId);
      emit(RefuseInvoiceSuccessState());
    }).catchError((error) {
      emit(RefuseInvoiceErrorState());
      print(error.toString());
    });
  }

  var lat = 0.0;
  var lang = 0.0;
  var address;
  // Future setLocation(BuildContext context) async {
  //   final result = await showLocationPicker(
  //     context,
  //     "AIzaSyCrsTVja4leOLfOxV6EfP1oSyQv_bpj7yg",
  //     myLocationButtonEnabled: true,
  //     layersButtonEnabled: true,
  //   );
  //   lat = result.latLng.latitude;
  //   lang = result.latLng.longitude;
  // }

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
              textAlign: TextAlign.right,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  InkWell(
                    child: Text(
                      "الأستوديو",
                      style: TextStyle(fontSize: 20),
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
