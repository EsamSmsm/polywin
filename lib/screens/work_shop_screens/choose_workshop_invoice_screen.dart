import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class ChooseInvoiceScreen extends StatelessWidget {
  final client;

  ChooseInvoiceScreen({Key key, @required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController installmentController = TextEditingController();
    return BlocConsumer<WorkshopCubit, WorkshopStates>(
      listener: (context, state) {
        WorkshopCubit cubit = WorkshopCubit.get(context);
        if (state is AddContractSuccessState) {
          cubit.getWorkshopContracts();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الاجمالي',
                    style: TextStyle(
                        color: kOrangeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    '  ${cubit.getTotalCost().toStringAsFixed(2)} ج.م ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'عدد الدفعات',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xffc8c8c8)),
                          color: Color(0xfffcfcfc),
                        ),
                        child: TextFormField(
                          controller: installmentController,
                          keyboardType: TextInputType.numberWithOptions(),
                          cursorColor: Colors.grey,
                          style: TextStyle(fontFamily: 'roboto'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "عدد الدفعات",
                            hintStyle: TextStyle(color: Colors.black54),
                            contentPadding: EdgeInsets.all(10),
                            hintTextDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                state is CheckInstallmentLoadingState
                    ? CircularProgressIndicator(
                        color: kDarkBlueColor,
                      )
                    : CustomButton(
                        color: kDarkBlueColor,
                        label: "تأكيد",
                        onTab: () {
                          cubit.addInstallment(
                              installmentNumber:
                                  int.parse(installmentController.text),
                              totalContract: cubit.getTotalCost(),
                              contractId:
                                  cubit.addNewContractResponseModel.payload,
                              clientId: cubit.costsByClientModel[0].clientId);
                          Navigator.pop(context);
                        },
                      )
              ],
            ),
          );
        } else if (state is CheckInstallmentSuccessState) {
          showAlertDialogWithAction(
              context: context,
              imagePath: 'assets/images/sent.png',
              message: 'تم الارسال بنجاح',
              buttonText: 'شكراً',
              action: () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
        }
      },
      builder: (context, state) {
        WorkshopCubit cubit = WorkshopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'الفواتير',
            isHomeScreen: false,
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: cubit.costsByClientModel != null &&
                    state is! GetCostByClientLoadingState
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Label(text: 'انشاء العقد'),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Color(0xffF8F8F8)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  client.name,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text('اسم العميل',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  client.clientPhone,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text('تليفون',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  client.clientAddress,
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text('العنوان',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  client.email ?? '',
                                  style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textDirection: TextDirection.rtl,
                                ),
                                Text('الايميل',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis)
                              ],
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          20,
                        ),
                        child: Label(
                          text: 'بيانات الطلب',
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cubit.costsByClientModel.length,
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              ),
                          itemBuilder: (context, index) => CostCard(
                                index: index,
                                productName: cubit
                                    .costsByClientModel[index].subCategoryName,
                                color:
                                    cubit.costsByClientModel[index].colorName,
                                width: cubit.costsByClientModel[index].width,
                                height: cubit.costsByClientModel[index].height,
                                mortal: cubit.costsByClientModel[index].mortal
                                    .toString(),
                                expenses: cubit
                                    .costsByClientModel[index].expenses
                                    .toString(),
                                totalCost: cubit
                                    .costsByClientModel[index].totalCalc
                                    .toStringAsFixed(2),
                              )),
                      SizedBox(
                        height: 20,
                      ),
                      cubit.costsByClientModel.length > 0
                          ? state is AddContractLoadingState
                              ? CircularProgressIndicator(
                                  color: kDarkBlueColor,
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: CustomButton(
                                    color: kDarkBlueColor,
                                    label: 'انشاء العقد',
                                    onTab: () {
                                      cubit.getCostsId();
                                      cubit.getTotalCost();
                                      print('${cubit.getCostsId()}');
                                      print(cubit.getTotalCost());
                                      cubit.addNewContract(
                                        clientId: cubit
                                            .costsByClientModel[0].clientId,
                                        totalCost: cubit.getTotalCost(),
                                        costsIds: cubit.getCostsId().toString(),
                                      );
                                    },
                                  ),
                                )
                          : Text(
                              'لا يوجد فواتير بعد',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  )
                : LinearProgressIndicator(
                    color: kOrangeColor,
                  ),
          ),
        );
      },
    );
  }
}

class CostCard extends StatelessWidget {
  CostCard({
    Key key,
    this.productName,
    this.color,
    this.width,
    this.height,
    this.mortal,
    this.expenses,
    this.totalCost,
    this.isChecked = false,
    this.index,
    this.productImage,
  }) : super(key: key);

  final String productName;
  final String productImage;
  final String color;
  final String width;
  final String height;
  final String mortal;
  final String expenses;
  final String totalCost;
  final int index;
  bool isChecked;

  @override
  Widget build(BuildContext context) {
    WorkshopCubit cubit = WorkshopCubit.get(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0.5, blurRadius: 1)
          ]),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.2,
                  //   height: MediaQuery.of(context).size.width * 0.2,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //     fit: BoxFit.cover,
                  //     image: NetworkImage('$kBaseURL'
                  //         '${cubit.subCategoryId.filePath}'),
                  //   )),
                  // ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Expanded(
                    child: Text(
                      productName,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: kOrangeColor, fontSize: 20),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Checkbox(
                      activeColor: kOrangeColor,
                      hoverColor: kOrangeColor,
                      focusColor: kOrangeColor,
                      fillColor: MaterialStateProperty.all(
                        kOrangeColor,
                      ),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                          if (isChecked) {
                            cubit.costList.add(cubit.costsByClientModel[index]);
                          } else {
                            cubit.costList.remove(cubit.costList
                                .remove(cubit.costsByClientModel[index]));
                          }
                          cubit.costList.forEach((element) {
                            print(element.id);
                          });
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'اللون : ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        color,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'الطول : ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ' $height م ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'العرض : ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '$width م ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.065,
          color: kOrangeColor.withAlpha(200),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                'اجمالي السعر',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                '$totalCost  ج.م ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
