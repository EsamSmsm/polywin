import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polywin/screens/guest_user_screens/bottom_nav_bar_screens/media_screen.dart';
import 'package:polywin/screens/work_shop_screens/choose_client_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class WorkshopDisplayPriceScreen extends StatelessWidget {
  const WorkshopDisplayPriceScreen({
    Key key,
    this.width,
    this.height,
    this.profits,
  }) : super(key: key);

  final String width, height, profits;

  @override
  Widget build(BuildContext context) {
    {
      ScreenshotController screenshotController = ScreenshotController();

      void shareScreenShot() async {
        final directory = (await getExternalStorageDirectory()).path;
        String fileName = 'screenshot.png';
        final imageFile = await screenshotController.captureAndSave(directory,
            fileName: fileName);
        Share.shareFiles(['$directory/$fileName']);
      }

      return Scaffold(
        appBar: CustomAppBar(
          title: 'عرض السعر',
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<WorkshopCubit, WorkshopStates>(
            listener: (context, state) {
              WorkshopCubit cubit = WorkshopCubit.get(context);
              if (state is SendTotalCostLoadingState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SpinKitFadingCircle(
                        color: kOrangeColor,
                      ),
                    ),
                  ),
                );
              }
              if (state is SendTotalCostSuccessState) {
                if (cubit.getCostByClientResponse) {
                  showAlertDialogWithAction(
                      message: 'تم الارسال بنجاح',
                      buttonText: 'تم',
                      context: context,
                      imagePath: 'assets/images/deal.png',
                      action: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                } else {
                  showToast(
                      text: cubit.addClientResponse.message,
                      color: Colors.redAccent);
                }
              }
            },
            builder: (context, state) {
              WorkshopCubit cubit = WorkshopCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Screenshot(
                    controller: screenshotController,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.grey)]),
                          child: Column(
                            children: [
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage('$kBaseURL'
                                          '${cubit.subCategoryId.filePath}'),
                                    )),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      cubit.subCategoryId.subCategory,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: kOrangeColor, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'اللون : ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        cubit.colorId.colorName,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'الطول : ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '$height  متر ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'العرض : ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '$width  متر ',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              cubit.totalPriceModel.items[index]
                                                  .productName,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          Text(
                                            '${cubit.totalPriceModel.items[index].totalByDescount} '
                                            ' ج.م ',
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(),
                                          SizedBox(),
                                        ],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 16,
                                      ),
                                  itemCount:
                                      cubit.totalPriceModel.items.length),
                              SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment
                              //       .spaceBetween,
                              //   textDirection: TextDirection.rtl,
                              //   children: [
                              //     Text('الهادر',
                              //       textDirection: TextDirection.rtl,
                              //       style: TextStyle(
                              //           fontSize: 17
                              //       ),),
                              //     Text('${cubit.totalPriceModel.totalMortal} '
                              //         ' ج.م ',
                              //       textDirection: TextDirection.rtl,
                              //       style: TextStyle(
                              //           fontSize: 17,
                              //           color: Colors.black54
                              //       ),),
                              //     SizedBox(),
                              //     SizedBox(),
                              //   ],
                              // ),
                              // SizedBox(height: 20,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment
                              //       .spaceBetween,
                              //   textDirection: TextDirection.rtl,
                              //   children: [
                              //     Text('مصروفات',
                              //       textDirection: TextDirection.rtl,
                              //       style: TextStyle(
                              //           fontSize: 17
                              //       ),),
                              //     Text('${cubit.totalPriceModel.totalExpenses} '
                              //         ' ج.م ',
                              //       textDirection: TextDirection.rtl,
                              //       style: TextStyle(
                              //           fontSize: 17,
                              //           color: Colors.black54
                              //       ),),
                              //     SizedBox(),
                              //     SizedBox(),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height * 0.065,
                          color: kOrangeColor,
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'اجمالي السعر',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                '${cubit.totalPriceModel.totalCost.toStringAsFixed(2)}   ج.م  ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CustomButton(
                        color: kDarkBlueColor,
                        label: 'ارسال عرض سعر للعميل',
                        onTab: () {
                          showCustomBottomSheet(
                              context: context,
                              content: Column(
                                children: [
                                  Text('قائمة العملاء',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textDirection: TextDirection.rtl),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: ListTile(
                                              title: Text(
                                                cubit.getAllClientsModel
                                                    .payload[index].name,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              subtitle: Text(
                                                cubit.getAllClientsModel
                                                    .payload[index].clientPhone,
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                              selectedTileColor: kOrangeColor,
                                              onTap: () {
                                                cubit.sendTotalCostToUser(
                                                    clientId: cubit
                                                        .getAllClientsModel
                                                        .payload[index]
                                                        .id,
                                                    costId: cubit
                                                        .totalPriceModel
                                                        .costCalcId);
                                                print(cubit.getAllClientsModel
                                                    .payload[index].id);
                                                print(cubit.totalPriceModel
                                                    .costCalcId);
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 16,
                                            ),
                                        itemCount: cubit
                                            .getAllClientsModel.payload.length),
                                  )
                                ],
                              ));
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: CustomButton(
                        color: kDarkBlueColor,
                        label: 'مشاركة عرض السعر',
                        onTab: () {
                          shareScreenShot();
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
