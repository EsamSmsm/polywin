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
                Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Text('محتويات الطلبية', style: TextStyle(
                    //         fontSize: 18, fontWeight: FontWeight.bold),),
                    //   ],
                    // ),
                    //SizedBox(height: 16,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cubit.getAllInvoicesModel.payload[invoiceIndex]
                          .details.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: Text(
                          cubit.getAllInvoicesModel.payload[invoiceIndex]
                              .details[index].quantity
                              .toString(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18, fontFamily: 'roboto'),
                        ),
                        trailing: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                  image: NetworkImage(cubit
                                          .getAllInvoicesModel
                                          .payload[invoiceIndex]
                                          .details[index]
                                          .imgUrl ??
                                      ''))),
                        ),
                        title: Text(
                          cubit.getAllInvoicesModel.payload[invoiceIndex]
                                      .details[index].productName +
                                  "- " +
                                  cubit
                                      .getAllInvoicesModel
                                      .payload[invoiceIndex]
                                      .details[index]
                                      .color ??
                              '',
                          style: TextStyle(
                            color: Color(0xff636363),
                            fontSize: 14,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        subtitle: Text(cubit.getAllInvoicesModel
                            .payload[invoiceIndex].details[index].totalOrder
                            .toString()),
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
