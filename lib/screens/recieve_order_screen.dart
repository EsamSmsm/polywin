import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class ReceiveOrderScreen extends StatelessWidget {
  const ReceiveOrderScreen({Key key, this.invoiceIndex}) : super(key: key);

  final int invoiceIndex;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تكلفة الطلبية',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              '${cubit.getAllInvoicesModel.payload[invoiceIndex].totalWithInvoices.toString()}   ج م ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))
                        ],
                      ),
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Text('محتويات الطلبية', style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold),),
                      //   ],
                      // ),
                      //SizedBox(height: 16,),
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.getAllInvoicesModel
                            .payload[invoiceIndex].details.length,
                        itemBuilder: (context, index) => Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  cubit
                                          .getAllInvoicesModel
                                          .payload[invoiceIndex]
                                          .details[index]
                                          .productName ??
                                      '',
                                  style: TextStyle(
                                    color: Color(0xff636363),
                                    fontSize: 14,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              Text(
                                cubit.getAllInvoicesModel.payload[invoiceIndex]
                                    .details[index].quantity
                                    .toString(),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'roboto'),
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => Divider(),
                      ),
                      // SizedBox(
                      //   height: 24,
                      // ),
                      // CustomButton(
                      //   color: kBlueColor,
                      //   label: 'استلام الطلبية',
                      //   onTab: () {
                      //     showAlertDialog(
                      //         context: context,
                      //         message: 'تم الاستلام بنجاح',
                      //         imagePath: 'assets/images/vector1.png',
                      //         buttonText: 'شكرا');
                      //   },
                      // ),
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
      },
    );
  }
}
