import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nil/nil.dart';
import 'package:polywin/models/get_all_invoices_from_polywin_model.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class SendOrderScreen extends StatelessWidget {
  SendOrderScreen({Key key, this.invoiceIndex}) : super(key: key);

  final int invoiceIndex;

  List<TextEditingController> quantityControllers = [];
  TextEditingController descriptionController = TextEditingController();
  List<bool> isReceived = [];
  bool isSent = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is UpdateInvoiceDetailsSuccessState) {
          showAlertDialogWithAction(
              context: context,
              message: 'تم التسليم بنجاح',
              imagePath: 'assets/images/vector1.png',
              buttonText: 'شكرا',
              action: () {
                cubit.invoiceDetails = [];
                cubit.getPolywinInvoices();
                cubit.emit(GetPolywinInvoicesSuccessState());
                Navigator.pop(context);
                Navigator.pop(context);
              });
        } else if (state is RefuseInvoiceSuccessState) {
          showAlertDialogWithAction(
              context: context,
              messageColor: Colors.redAccent,
              message: 'تم رفض الطلبية',
              imagePath: 'assets/images/vector1.png',
              buttonText: 'شكرا',
              action: () {
                cubit.invoiceDetails = [];
                cubit.getPolywinInvoices();
                Navigator.pop(context);
                Navigator.pop(context);
              });
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        cubit.invoiceDetails = [];
        if (cubit.getPolywinInvoicesModel.payload[invoiceIndex].details.length >
            0) {
          cubit.getPolywinInvoicesModel.payload[invoiceIndex].details
              .forEach((element) {
            isReceived.add(false);
            quantityControllers
                .add(TextEditingController(text: element.quantity.toString()));
            cubit.insertInvoice(
                id: element.id,
                description: '',
                isReceived: false,
                quantity: element.quantity);
          });
        }
        List<Detail> products =
            cubit.getPolywinInvoicesModel.payload[invoiceIndex].details;

        double totalInvoice = cubit
            .getPolywinInvoicesModel.payload[invoiceIndex].totalWithInvoices;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            isSigned: true,
            title: 'تسليم طلبية',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('محتويات الطلبية',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          // Text(totalInvoice.toString() + ' ج.م',
                          //     textDirection: TextDirection.rtl,
                          //     style: TextStyle(
                          //       fontSize: 18,
                          //     )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.getPolywinInvoicesModel
                            .payload[invoiceIndex].details.length,
                        itemBuilder: (context, index) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          color: Color(0xffF8F8F8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('$kBaseURL'
                                        '${cubit.getPolywinInvoicesModel.payload[invoiceIndex].details[index].imgUrl}'),
                                  ),
                                ),
                              ),
                              Column(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      cubit
                                              .getPolywinInvoicesModel
                                              .payload[invoiceIndex]
                                              .details[index]
                                              .productName +
                                          '- ' +
                                          cubit
                                              .getPolywinInvoicesModel
                                              .payload[invoiceIndex]
                                              .details[index]
                                              .color,
                                      style: TextStyle(
                                        color: Color(0xff636363),
                                        fontSize: 14,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                  Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Text(
                                        'المطلوب : ${cubit.getPolywinInvoicesModel.payload[invoiceIndex].details[index].quantity.toString()}',
                                        style: TextStyle(
                                            color: kOrangeColor,
                                            fontSize: 14,
                                            fontFamily: 'roboto'),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      cubit
                                                  .getPolywinInvoicesModel
                                                  .payload[invoiceIndex]
                                                  .details[index]
                                                  .numberIron !=
                                              0
                                          ? Text(
                                              'الحديد : ${cubit.getPolywinInvoicesModel.payload[invoiceIndex].details[index].numberIron.toString()}',
                                              style: TextStyle(
                                                  color: kOrangeColor,
                                                  fontSize: 14,
                                                  fontFamily: 'roboto'),
                                              textDirection: TextDirection.rtl,
                                            )
                                          : Text(''),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 25,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffFFA41B)),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextFormField(
                                      controller: quantityControllers[index],
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.grey,
                                      style: TextStyle(
                                          fontFamily: 'roboto', fontSize: 14),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintTextDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  StatefulBuilder(builder: (context, setState) {
                                    return SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                          activeColor: Color(0xffFFA41B),
                                          hoverColor: Color(0xffFFA41B),
                                          focusColor: Color(0xffFFA41B),
                                          fillColor: MaterialStateProperty.all(
                                            Color(0xffFFA41B),
                                          ),
                                          value: isReceived[index],
                                          onChanged: (bool value) {
                                            setState(() {
                                              isReceived[index] = value;
                                              cubit.updateInvoice(
                                                  index: index,
                                                  quantity: int.parse(
                                                      quantityControllers[index]
                                                          .text),
                                                  id: cubit
                                                      .getPolywinInvoicesModel
                                                      .payload[invoiceIndex]
                                                      .details[index]
                                                      .id,
                                                  description: '',
                                                  isReceived:
                                                      isReceived[index]);
                                            });
                                          }),
                                    );
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      DescriptionTextField(
                        controller: descriptionController,
                        maxLines: 5,
                        hintText: 'ملاحظات',
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      state is SendInvoiceLoadingState
                          ? CircularProgressIndicator(
                              color: kBlueColor,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomButton(
                                color: kBlueColor,
                                label: 'تسليم الطلبية',
                                onTab: () {
                                  isSent = true;
                                  cubit.sendInvoice(
                                    invoiceId: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].id,
                                    totalInvoices: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].totalInvoices,
                                    discount: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].descountInvoices,
                                    totalWithDiscount: cubit
                                        .getPolywinInvoicesModel
                                        .payload[invoiceIndex]
                                        .totalWithInvoices,
                                    description: descriptionController.text,
                                  );
                                },
                              ),
                            ),
                      SizedBox(
                        height: 24,
                      ),
                      state is RefuseInvoiceLoadingState
                          ? CircularProgressIndicator(
                              color: Colors.redAccent,
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: CustomButton(
                                color: Colors.redAccent,
                                label: 'رفض الطلبية',
                                onTab: () {
                                  isSent = false;
                                  cubit.refuseInvoice(
                                    invoiceId: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].id,
                                    totalInvoices: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].totalInvoices,
                                    discount: cubit.getPolywinInvoicesModel
                                        .payload[invoiceIndex].descountInvoices,
                                    totalWithDiscount: cubit
                                        .getPolywinInvoicesModel
                                        .payload[invoiceIndex]
                                        .totalWithInvoices,
                                    description: descriptionController.text,
                                  );
                                },
                              ),
                            ),
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

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  int maxLines = 1;
  Widget suffixIcon;
  DescriptionTextField(
      {this.controller, this.hintText, this.maxLines, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: TextField(
          textDirection: TextDirection.rtl,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            hintText: hintText,
            isDense: true,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ),
    );
  }
}
