import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_readonly_field.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';

class ContractDetailsScreen extends StatelessWidget {
  const ContractDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CustomerCubit cubit = CustomerCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'تفاصيل العقد',
            isSigned: true,
            isHomeScreen: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: cubit.installmentByContractIdModel != null &&
                      cubit.contractInfoModel != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Polywin Logo.png'),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      '$kBaseURL${cubit.contractInfoModel.workShopLogo}',
                                    ),
                                    fit: BoxFit.fitWidth),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'عقد تصنيع باب وشباك ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: kDarkBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            RichText(
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                style: TextStyle(
                                    fontFamily: 'GE_SS',
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    height: 1.6,
                                    color: Colors.black,
                                    fontSize: 18),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'انه في يوم ',
                                  ),
                                  TextSpan(
                                      text: cubit.contractInfoModel.invoiceDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: ' اتفق كل من \nالطرف الأول : '),
                                  TextSpan(
                                      text:
                                          '${cubit.contractInfoModel.workShopName}\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(text: 'الطرف الثاني : '),
                                  TextSpan(
                                      text:
                                          '${cubit.contractInfoModel.clientName} ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'على تصنيع التالي :'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.contractInfoModel.itemList.length,
                          itemBuilder: (context, index) => Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                '${index + 1} - ' +
                                    cubit.contractInfoModel.itemList[index]
                                        .productName,
                                style: TextStyle(
                                    letterSpacing: 1,
                                    wordSpacing: 3,
                                    height: 1.6,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'GE_SS',
                                letterSpacing: 1,
                                wordSpacing: 3,
                                height: 1.6,
                                color: Colors.black,
                                fontSize: 18),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    'على ان يتم التسليم والتركيب خلال ايام و اجمالي التكلفة هو:  ',
                              ),
                              TextSpan(
                                  text:
                                      cubit.contractInfoModel.total + ' جنيه ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: 'تدفع على '),
                              TextSpan(
                                  text:
                                      '${cubit.installmentByContractIdModel.length} دفعات ',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'قيمه الدفعة',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'حالة الدفعة',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 49,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black26),
                                          color: Color(0xfffcfcfc)),
                                      child: Center(
                                          child: Text(
                                        cubit
                                            .installmentByContractIdModel[index]
                                            .costPerMonth
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    Container(
                                      height: 49,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black26),
                                          color: Color(0xfffcfcfc)),
                                      child: Center(
                                        child: Text(
                                          cubit
                                              .installmentByContractIdModel[
                                                  index]
                                              .type,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: kDarkBlueColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                cubit.installmentByContractIdModel.length),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  : LinearProgressIndicator(
                      color: kOrangeColor,
                    ),
            ),
          ),
        );
      },
    );
  }
}
