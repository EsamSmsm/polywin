import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/polywin_admin_screens/send_order_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({Key key}) : super(key: key);

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  @override
  void initState() {
    AppCubit.get(context).getPolywinInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetPolywinInvoicesErrorState) {
          showToast(text: 'حدث خطأفي تحميل البيانات', color: Colors.redAccent);
        }
      },
      bloc: AppCubit()..getPolywinInvoices(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'الطلبيات المستلمة',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'الطلبيات',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                ),

                ///listview
                ConditionalBuilder(
                  condition: cubit.getPolywinInvoicesModel != null,
                  fallback: (context) => LinearProgressIndicator(
                    backgroundColor: kOrangeColor,
                  ),
                  builder: (context) => ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.getPolywinInvoicesModel.payload.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 0.5)
                          ]),
                      child: Column(
                        children: [
                          ///data column
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                        color: Color(0xff707070), fontSize: 17),
                                  ),
                                  SizedBox(width: 80),
                                  Text(
                                    'تسلسل',
                                    style: TextStyle(fontSize: 17),
                                    textDirection: TextDirection.rtl,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.getPolywinInvoicesModel.payload[index]
                                        .agent,
                                    style: TextStyle(
                                        color: Color(0xff707070), fontSize: 17),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    'اسم الوكيل',
                                    style: TextStyle(fontSize: 17),
                                    textDirection: TextDirection.rtl,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.getPolywinInvoicesModel.payload[index]
                                        .invoicesDate
                                        .toString()
                                        .substring(0, 10),
                                    style: TextStyle(
                                        color: Color(0xff707070), fontSize: 17),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    'تاريخ الطلب',
                                    style: TextStyle(fontSize: 17),
                                    textDirection: TextDirection.rtl,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.getPolywinInvoicesModel.payload[index]
                                            .totalWithInvoices
                                            .toString() +
                                        '  ج.م',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Color(0xff707070), fontSize: 17),
                                  ),
                                  SizedBox(width: 50),
                                  Text(
                                    'الاجمالي ',
                                    style: TextStyle(fontSize: 17),
                                    textDirection: TextDirection.rtl,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomButton2(
                                color: Color(0xffFFA41B),
                                label: 'عرض الطلبية',
                                onTab: () {
                                  navigateTo(
                                      context,
                                      SendOrderScreen(
                                        invoiceIndex: index,
                                      ));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
