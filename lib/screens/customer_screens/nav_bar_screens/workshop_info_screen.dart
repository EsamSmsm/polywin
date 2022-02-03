import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';
import 'package:polywin/models/client_models/workshop_info_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class WorkshopInfoScreen extends StatelessWidget {
  WorkshopInfoScreen({Key key}) : super(key: key);

  ScreenshotController screenshotController = ScreenshotController();

  void shareScreenShot() async {
    final directory = (await getExternalStorageDirectory()).path;
    String fileName = 'screenshot.png';
    final imageFile = await screenshotController.captureAndSave(directory,
        fileName: fileName);
    Share.shareFiles(['$directory/$fileName']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'بيانات الورشة',
      ),
      body: BlocBuilder<CustomerCubit, CustomerStates>(
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return SingleChildScrollView(
            child: cubit.workShopInfoModel == null
                ? LinearProgressIndicator(
                    color: kOrangeColor,
                  )
                : Column(
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff8f8f8),
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                padding: EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        kBaseURL +
                                            cubit.workShopInfoModel.result
                                                .payload[0].agentLogo,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    cubit.workShopInfoModel.result.payload[0]
                                        .name,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: kOrangeColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(CupertinoIcons.phone_fill),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      launchURL(
                                          'tel:${cubit.workShopInfoModel.result.payload[0].agentPhone}');
                                    },
                                    child: Text(
                                      cubit.workShopInfoModel.result.payload[0]
                                          .agentPhone,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'roboto',
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(Icons.mail_rounded),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    child: Text(
                                      cubit.workShopInfoModel.result.payload[0]
                                              .email ??
                                          '',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'roboto',
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Icon(CupertinoIcons.location_solid),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      MapsLauncher.launchCoordinates(
                                        double.parse(cubit.workShopInfoModel
                                            .result.payload[0].late),
                                        double.parse(cubit.workShopInfoModel
                                            .result.payload[0].long),
                                      );
                                    },
                                    child: Text(
                                      cubit.workShopInfoModel.result.payload[0]
                                              .agentAddress ??
                                          'عرض الموقع علي الخريطة',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.black54),
                                    ),
                                    style: ButtonStyle(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: CustomButton(
                            color: kDarkBlueColor,
                            label: 'مشاركة بيانات الورشة',
                            onTab: () {
                              shareScreenShot();
                            }),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
