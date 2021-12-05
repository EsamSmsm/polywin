import 'package:flutter/material.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';

class DisplayOrderScreen extends StatelessWidget {
  const DisplayOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        isSigned: true,
        title: 'تفاصيل الطلبية',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.grey.shade100,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'تكلفة الطلبية',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(' 50,000  جنيه',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('محتويات الطلبية', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الصنف',
                        style: TextStyle(
                            fontSize: 17,
                            color: kDarkBlueColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'العدد',
                        style: TextStyle(
                            fontSize: 17,
                            color: kDarkBlueColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: [
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                width: 70,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/accessoires.png'),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'سيبليونة 30 سم مفصلي ',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            '40',
                            style:
                            TextStyle(fontSize: 18, fontFamily: 'roboto'),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    color: kBlueColor,
                    label: 'استلام الطلبية',
                    onTab: () {
                      showAlertDialog(
                          context: context,
                          message: 'تم الاستلام بنجاح',
                          imagePath: 'assets/images/vector1.png',
                          buttonText: 'شكرا');
                    },
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
