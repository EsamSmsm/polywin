import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/polywin_admin_screens/send_order_screen.dart';
import 'package:polywin/screens/resend_rejected_invoice_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class RejectedInvoicesScreen extends StatefulWidget {
  const RejectedInvoicesScreen({Key key}) : super(key: key);

  @override
  State<RejectedInvoicesScreen> createState() => _RejectedInvoicesScreenState();
}

class _RejectedInvoicesScreenState extends State<RejectedInvoicesScreen> {
  @override
  void initState() {
    AppCubit.get(context).getPolywinRejInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetPolywinRejInvoicesErrorState) {
          showToast(text: 'حدث خطأفي تحميل البيانات', color: Colors.redAccent);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'الطلبيات المرفوضة',
            isSigned: true,
          ),
          body: RefreshIndicator(
            color: kOrangeColor,
            onRefresh: () {
              AppCubit.get(context).getPolywinRejInvoices();
              setState(() {});
              return Future.delayed(Duration(seconds: 0));
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ///listview
                  ConditionalBuilder(
                    condition: cubit.getPolywinRejInvoicesModel != null,
                    fallback: (context) => LinearProgressIndicator(
                      backgroundColor: kOrangeColor,
                    ),
                    builder: (context) => ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          cubit.getPolywinRejInvoicesModel.payload.length,
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
                                          color: Color(0xff707070),
                                          fontSize: 17),
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
                                      cubit.getPolywinRejInvoicesModel
                                          .payload[index].agent,
                                      style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: 17),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      'الاسم ',
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
                                      cubit.getPolywinRejInvoicesModel
                                          .payload[index].invoicesDate
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: 17),
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
                                      cubit.getPolywinRejInvoicesModel
                                              .payload[index].totalWithInvoices
                                              .toString() +
                                          '  ج.م',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: 17),
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
                                        ResendRejectedInvoiceScreen(
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
          ),
        );
      },
    );
  }
}
