import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polywin/layout/workshop_layout.dart';
import 'package:polywin/screens/work_shop_screens/choose_workshop_invoice_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

import '../update_profile_screen.dart';

class UploadWarrantyImagesScreen extends StatefulWidget {
  const UploadWarrantyImagesScreen(
      {Key key,
      this.contractIndex,
      this.costCalcId,
      this.client,
      this.productIndex})
      : super(key: key);
  final int contractIndex;
  final client;
  final int costCalcId;
  final productIndex;
  @override
  _UploadWarrantyImagesScreenState createState() =>
      _UploadWarrantyImagesScreenState();
}

class _UploadWarrantyImagesScreenState
    extends State<UploadWarrantyImagesScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'انشاء ضمان',
        ),
        body: BlocConsumer<WorkshopCubit, WorkshopStates>(
          listener: (context, state) {
            WorkshopCubit cubit = WorkshopCubit.get(context);
            if (state is AddWarrantyGalleryLoadingState ||
                state is AddWarrantyLoadingState) {
              showLoadingDialogue(context);
            } else if (state is AddWarrantyGallerySuccessState) {
              if (state is AddWarrantySuccessState) {
                showAlertDialogWithAction(
                    buttonText: 'تم',
                    messageColor: kBlueColor,
                    message: 'تم انشاء الضمان بنجاح',
                    context: context,
                    imagePath: 'assets/images/warranty.png',
                    action: () {
                      cubit.getWorkshopContracts();
                      navigateAndFinish(
                          context,
                          WorkShopLayout(
                            selectedIndex:
                                WorkshopCubit.get(context).selectedIndex = 4,
                          ));
                    });
              }
            } else if (state is AddWarrantyGalleryErrorState) {
              showToast(text: 'فشل ارفاق الصور', color: Colors.red);
            } else if (state is AddWarrantyErrorState) {
              showToast(text: 'فشل تفعيل الضمان ', color: Colors.red);
            }
          },
          builder: (context, state) {
            WorkshopCubit cubit = WorkshopCubit.get(context);
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(color: Color(0xffF8F8F8)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.client.clientName,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('اسم العميل',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.client.phone,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('تليفون',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.client.address,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('العنوان',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit
                                    .workshopContractsModel
                                    .payload[widget.contractIndex]
                                    .listItem[widget.productIndex]
                                    .productName,
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('المنتج',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '20 عام',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('مدة ضمان القطاعات',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '5 اعوام',
                                style: TextStyle(
                                  color: Color(0xff707070),
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text('مدة ضمان الاكسسوار',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textDirection: TextDirection.rtl,
                                  overflow: TextOverflow.ellipsis)
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Label(
                      text: 'رفع صور',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImages();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'رفع الصور بعد التركيب',
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
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: imageFileList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(imageFileList[index].path),
                            fit: BoxFit.cover,
                          );
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    state is AddWarrantyGalleryLoadingState &&
                            state is! AddWarrantyGallerySuccessState
                        ? CircularProgressIndicator(
                            color: kBlueColor,
                          )
                        : CustomButton(
                            color: kBlueColor,
                            label: 'انشاء الضمان',
                            onTab: () {
                              cubit.addNewWarranty(
                                  contractId: cubit.workshopContractsModel
                                      .payload[widget.contractIndex].id,
                                  costCalcId: widget.costCalcId);
                              print(cubit.workshopContractsModel
                                  .payload[widget.contractIndex].id);
                              print(widget.costCalcId);

                              cubit.addWarrantyGallery(
                                contractItemId: widget.costCalcId,
                                selectedImages: List.generate(
                                    imageFileList.length,
                                    (index) => File(imageFileList[index].path)),
                              );
                            },
                          )
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
