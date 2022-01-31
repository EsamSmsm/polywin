import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/new_order_pricing_screen.dart';
import 'package:polywin/screens/order_details_screen.dart';
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
                              '${cubit.getAllInvoicesModel.payload[invoiceIndex].totalWithInvoices.toString()}   جنيه ',
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
                    Divider(),
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
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(kBaseURL +
                                          cubit
                                              .getAllInvoicesModel
                                              .payload[invoiceIndex]
                                              .details[index]
                                              .productPath ??
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
                        subtitle: Text(
                          (cubit.getAllInvoicesModel.payload[invoiceIndex]
                                          .details[index].totalOrder -
                                      (cubit
                                              .getAllInvoicesModel
                                              .payload[invoiceIndex]
                                              .details[index]
                                              .totalOrder *
                                          (cubit
                                                  .getAllInvoicesModel
                                                  .payload[invoiceIndex]
                                                  .details[index]
                                                  .descount /
                                              100)))
                                  .toStringAsFixed(2) +
                              ' جنيه',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      separatorBuilder: (context, index) => Divider(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        color: kBlueColor,
                        label: 'تعديل و اعادة ارسال ',
                        onTab: () {
                          cubit.order = [];
                          cubit
                              .getAllInvoicesModel.payload[invoiceIndex].details
                              .forEach((element) {
                            cubit.addProduct(
                                id: element.productId,
                                quantity: element.quantity,
                                color: element.color,
                                name: element.productName,
                                imgURL: element.productPath,
                                discount: element.descount,
                                numberIron: element.numberIron,
                                pricePerMeter: element.pricePerMeter,
                                pricePerOne: element.pricePerOne,
                                priceWithDiscount: element.priceWithDescount,
                                totalOrder: element.totalOrder -
                                    (element.totalOrder *
                                        (element.descount / 100)));
                          });
                          navigateTo(context, NewOrderPricingScreen());
                          navigateTo(context, OrderDetailsScreen());
                        },
                      ),
                    ),
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
