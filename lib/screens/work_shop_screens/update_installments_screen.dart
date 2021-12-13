import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

import '../update_profile_screen.dart';

class UpdateInstallmentsScreen extends StatelessWidget {
  const UpdateInstallmentsScreen({Key key, this.id}) : super(key: key);

  final id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تعديل الدفعات',
      ),
      body: BlocConsumer<WorkshopCubit, WorkshopStates>(
        listener: (context, state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
          if (state is UpdateInstallmentLoadingState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SpinKitFadingCircle(
                    color: kOrangeColor,
                  ),
                ),
              ),
            );
          } else if (state is UpdateInstallmentSuccessState) {
            if (cubit.isInstallmentUpdated) {
              showAlertDialogWithAction(
                  message: 'تم تعديل الدفعات بنجاح',
                  buttonText: 'تم',
                  context: context,
                  imagePath: 'assets/images/deal.png',
                  action: () {
                    cubit.getInstallmentByClientId(contractId: id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
            }
          } else if (state is UpdateInstallmentErrorState) {
            Navigator.pop(context);
            showToast(text: 'حدث خطأ ما', color: Colors.red);
          }
        },
        builder: (context, state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
          return SingleChildScrollView(
            child: cubit.installmentByContractIdModel != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Label(
                          text: 'الدفعات',
                        ),
                        SizedBox(
                          height: 30,
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
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Color(0xffF8F8F8),
                                            title: Center(
                                                child: Text(
                                              'تأكيد الدفع ؟',
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                color: kDarkBlueColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  'الغاء',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  'تأكيد',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green),
                                                ),
                                                onPressed: () {
                                                  cubit.updateInstallment(
                                                      id: cubit
                                                          .installmentByContractIdModel[
                                                              index]
                                                          .id);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 49,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black26),
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
                                      ),
                                    )
                                  ],
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                cubit.installmentByContractIdModel.length),
                      ],
                    ),
                  )
                : LinearProgressIndicator(
                    color: kOrangeColor,
                  ),
          );
        },
      ),
    );
  }
}
