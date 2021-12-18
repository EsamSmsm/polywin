import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/layout/customert_layout.dart';
import 'package:polywin/screens/customer_screens/contract_details_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/search_bar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';
import '../workshop_data_screen.dart';

class CustomerContractsScreen extends StatelessWidget {
  const CustomerContractsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerCubit cubit = CustomerCubit.get(context);
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'العقود',
            isSigned: true,
          ),
          body: cubit.clientContractsModel != null &&
                  state is! GetClientContractsLoadingState
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'العقود',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textDirection: TextDirection.rtl,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                    context,
                                    CustomerLayout(
                                      selectedIndex: cubit.selectedIndex = 1,
                                    ));
                              },
                              child: Text(
                                'بيانات الورشة',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: kOrangeColor,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                      ),

                      ///listview
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.clientContractsModel.payload.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        cubit.clientContractsModel
                                            .payload[index].workShopName,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 15),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        'اسم الورشة',
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
                                        '${cubit.clientContractsModel.payload[index].workShopPhone}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 15),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        'تليفون',
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
                                        '${cubit.clientContractsModel.payload[index].workShopAddress}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 15),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        'العنوان',
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
                                        '${cubit.clientContractsModel.payload[index].totalContract.toString()} ج.م',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 15),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        'قيمة العقد',
                                        style: TextStyle(fontSize: 15),
                                        textDirection: TextDirection.rtl,
                                      )
                                    ],
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
                                    label: 'العقد',
                                    onTab: () {
                                      cubit.getInstallmentByClientId(
                                          contractId: cubit.clientContractsModel
                                              .payload[index].id);
                                      cubit.getContractInfo(
                                          contractId: cubit.clientContractsModel
                                              .payload[index].id);
                                      navigateTo(
                                          context, ContractDetailsScreen());
                                      // showAlertDialog(
                                      //     buttonText: 'تحميل',
                                      //     imagePath: 'assets/images/deal.png',
                                      //     message: 'يمكنك الان تحميل العقد',
                                      //     context: context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : LinearProgressIndicator(
                  color: kOrangeColor,
                ),
        );
      },
    );
  }
}
