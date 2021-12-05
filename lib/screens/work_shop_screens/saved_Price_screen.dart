import 'package:flutter/material.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';

class SavedPriceScreen extends StatelessWidget {
  const SavedPriceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'عروض اسعار محفوظة',
        isSigned: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.sort,
                    color: Colors.black,
                    size: 26,
                  ),
                  Text(
                    'عروض اسعار محفوظة',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textDirection: TextDirection.rtl,
                  )
                ],
              ),
            ),

            ///listview
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(color: Color(0xffF8F8F8), boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 0.5)
                ]),
                child: Column(
                  children: [
                    ///data column
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${index + 1}',
                              style: TextStyle(
                                  color: Color(0xff707070), fontSize: 15),
                            ),
                            SizedBox(width: 80),
                            Text(
                              'تسلسل',
                              style: TextStyle(fontSize: 15),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'خالد علي',
                              style: TextStyle(
                                  color: Color(0xff707070), fontSize: 15),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'اسم العميل',
                              style: TextStyle(fontSize: 15),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '8/2/2021',
                              style: TextStyle(
                                  color: Color(0xff707070), fontSize: 15),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'تاريخ الطلب',
                              style: TextStyle(fontSize: 15),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CustomButton2(
                          color: Color(0xffFFA41B),
                          label: 'ارسال عرض السعر',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
