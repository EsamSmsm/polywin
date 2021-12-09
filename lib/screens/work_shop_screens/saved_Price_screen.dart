import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

import 'choose_workshop_invoice_screen.dart';

class SavedPriceScreen extends StatelessWidget {
  const SavedPriceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopCubit, WorkshopStates>(
      builder: (context, state) {
        WorkshopCubit cubit = WorkshopCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'عروض اسعار محفوظة',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cubit.getAllClientsModel.payload.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: Color(0xffF8F8F8), boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 0.5)
                ]),
                child: Column(
                  children: [
                    ///data column
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  cubit.getAllClientsModel.payload[index].name,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(width: 15),
                                Text('اسم العميل',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(width: 20),
                                Text('تسلسل',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              cubit.getAllClientsModel.payload[index]
                                  .clientPhone,
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: 15),
                            Text('تليفون',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              cubit.getAllClientsModel.payload[index]
                                  .clientAddress,
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(width: 15),
                            Text('العنوان',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis)
                          ],
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        CustomButton2(
                          color: Color(0xffFFA41B),
                          label: 'تقديم عقد للعميل',
                          onTab: () {
                            cubit.costList = [];
                            cubit.getCostsByClient(
                                clientId:
                                    cubit.getAllClientsModel.payload[index].id);
                            print(cubit.getAllClientsModel.payload[index].id);
                            navigateTo(context, ChooseInvoiceScreen());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
