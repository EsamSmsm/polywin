import 'package:flutter/material.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/custom_text_field.dart';
import 'package:polywin/shared/constants.dart';

import '../update_profile_screen.dart';

class WorkshopDataScreen extends StatelessWidget {
  const WorkshopDataScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'بيانات الورشة',
        isSigned: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'بيانات الورشة',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 20,
                        color: kOrangeColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              ///user data form
              Column(
                children: [
                  ///name
                  Label(
                    text: 'اسم الورشة',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'اسم الورشة',
                    isPassword: false,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  ///phone
                  Label(
                    text: 'رقم الهاتف المتصل بالواتس',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'رقم الهاتف',
                    isPassword: false,
                    textDirection: TextDirection.rtl,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  ///email
                  Label(
                    text: 'البريد الالكتروني',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'info@gmail.com',
                    isPassword: false,
                    textDirection: TextDirection.rtl,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  /// location
                  Label(
                    text: 'الموقع',
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'تحديد الموقع',
                        style: TextStyle(
                            color: kBlueColor,
                            fontSize: 15,
                            decoration: TextDecoration.underline),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
