import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

import '../order_details_screen.dart';
import '../recieve_order_screen.dart';

class UnderwayOrderTabScreen extends StatefulWidget {
  const UnderwayOrderTabScreen({Key key}) : super(key: key);

  @override
  _UnderwayOrderTabScreenState createState() => _UnderwayOrderTabScreenState();
}

class _UnderwayOrderTabScreenState extends State<UnderwayOrderTabScreen> {
  @override
  void initState() {
    AppCubit.get(context).getAllInvoices(invoiceStatus: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is DeleteInvoicesLoadingState) {
          showLoadingDialogue(context);
        } else if (state is DeleteInvoicesSuccessState) {
          showAlertDialogWithAction(
              buttonText: "تم",
              message: 'تم حذف الطلبية بنجاح',
              context: context,
              messageColor: Colors.red,
              imagePath: 'assets/images/delete vector.png',
              action: () {
                AppCubit.get(context).getAllInvoices(invoiceStatus: 1);
                Navigator.pop(context);
                Navigator.pop(context);
                setState(() {});
              });
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return cubit.getAllInvoicesModel != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ///listview
                    cubit.getAllInvoicesModel.payload.length != 0
                        ? ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cubit.getAllInvoicesModel.payload.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF8F8F8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, blurRadius: 0.5)
                                  ]),
                              child: Column(
                                children: [
                                  ///data column
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${index + 1}',
                                            style: TextStyle(
                                                color: Color(0xff707070),
                                                fontSize: 15),
                                          ),
                                          SizedBox(width: 40),
                                          Text(
                                            'تسلسل :',
                                            style: TextStyle(fontSize: 15),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            cubit
                                                    .getAllInvoicesModel
                                                    .payload[index]
                                                    .totalWithInvoices
                                                    .toString() +
                                                " ج.م",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                fontFamily: 'roboto',
                                                color: Color(0xff707070),
                                                fontSize: 15),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'الاجمالي :',
                                            style: TextStyle(fontSize: 15),
                                            textDirection: TextDirection.rtl,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            cubit.getAllInvoicesModel
                                                .payload[index].invoicesDate
                                                .toString()
                                                .substring(0, 10),
                                            style: TextStyle(
                                                fontFamily: 'roboto',
                                                color: Color(0xff707070),
                                                fontSize: 15),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'تاريخ الطلب :',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton2(
                                        color: Color(0xffFFA41B),
                                        label: 'عرض الطلبية',
                                        onTab: () {
                                          navigateTo(
                                              context,
                                              ReceiveOrderScreen(
                                                invoiceIndex: index,
                                              ));
                                        },
                                      ),
                                      CustomButton2(
                                        color: Colors.red,
                                        onTab: () {
                                          print(cubit.getAllInvoicesModel
                                              .payload[index].id
                                              .toString());
                                          ensureDeleteMessage(
                                              context, cubit, index);
                                        },
                                        label: 'حذف الطلبية',
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 200),
                            child: Text(
                              'لا يوجد طلبيات',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black38),
                            ),
                          ),
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                color: kOrangeColor,
              )));
      },
    );
  }

  void ensureDeleteMessage(BuildContext context, AppCubit cubit, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Color(0xffF8F8F8),
              title: Center(
                  child: Text(
                'هل تريدحذف الطلبية ؟',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: kBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              )),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  child: Text(
                    'تراجع',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kDarkBlueColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    'حذف',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    cubit.deleteInvoice(
                        id: cubit.getAllInvoicesModel.payload[index].id
                            .toString());
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
