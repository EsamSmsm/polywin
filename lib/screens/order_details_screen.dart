import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/new_order_pricing_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/agent_states.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (state is AddInvoiceDetailsSuccessState) {
          if (cubit.addInvoiceDetailsResponse == true) {
            showAlertDialogWithAction(
                context: context,
                imagePath: 'assets/images/sent.png',
                message: 'تم الارسال بنجاح',
                buttonText: 'شكراً',
                action: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  cubit.order = [];
                  cubit.emit(RefreshState());
                });
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        double getTotalWithDiscount() {
          double count = 0;
          cubit.order.forEach((element) {
            count += element['totalOrder'];
          });
          return double.parse(count.toStringAsFixed(2));
        }

        double getTotal() {
          double count = 0;
          cubit.order.forEach((element) {
            count += element['pricePerOne'] * element['quantity'];
          });
          return double.parse(count.toStringAsFixed(2));
        }

        double discount = getTotal() - getTotalWithDiscount();

        return Scaffold(
          appBar: CustomAppBar(
            isSigned: true,
            title: 'تفاصيل الطلبية',
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  color: Colors.grey.shade100,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'اجمالي الطلبية',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('  ${getTotalWithDiscount().toString()}  جنيه ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  itemCount: cubit.order.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '$kBaseURL${cubit.order[index]['imgURL']}'),
                          ),
                        ),
                      ),
                      title: Text(
                        cubit.order[index]['productName'],
                      ),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Row(
                          textDirection: TextDirection.ltr,
                          children: [
                            IconButton(
                                onPressed: () {
                                  cubit.order.removeAt(index);
                                  cubit.emit(RefreshState());
                                },
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                  size: 32,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 32,
                              height: 28,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffFA912E)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  cubit.order[index]['quantity'].toString(),
                                  style: TextStyle(fontFamily: 'roboto'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                cubit.order.length > 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Column(
                          children: [
                            ConditionalBuilder(
                              condition:
                                  state is! AddInvoiceDetailsLoadingState &&
                                      state is! AddInvoiceLoadingState,
                              fallback: (context) => CircularProgressIndicator(
                                color: kDarkBlueColor,
                              ),
                              builder: (context) => CustomButton(
                                color: kDarkBlueColor,
                                label: 'ارسال الطلبية',
                                onTab: () async {
                                  await cubit.addNewInvoice(
                                    discountInvoices: getTotal(),
                                    totalInvoices: discount,
                                    totalWithInvoices: getTotalWithDiscount(),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomButton(
                                color: Colors.red,
                                label: 'حذف الطلبية',
                                onTab: () {
                                  cubit.order = [];
                                  Navigator.pop(context);
                                  cubit.emit(RefreshState());
                                }),
                          ],
                        ),
                      )
                    : Text(''),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
