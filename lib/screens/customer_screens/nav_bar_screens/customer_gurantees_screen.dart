import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/layout/customert_layout.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';

import '../warranty_details_screen.dart';

class CustomerGuaranteesScreen extends StatelessWidget {
  const CustomerGuaranteesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'الضمانات',
        isSigned: true,
      ),
      body: BlocConsumer<CustomerCubit, CustomerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'الضمانات',
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
                cubit.clientWarrantiesModel != null &&
                        state is! GetWarrantiesLoadingState
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.clientWarrantiesModel.length,
                        itemBuilder: (context, index) => Column(
                          //alignment: Alignment.topLeft,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateTo(
                                    context,
                                    WarrantyDetailsScreen(
                                      warrantyIndex: index,
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 0.5)
                                    ]),
                                child: Column(
                                  children: [
                                    ///data column
                                    Column(
                                      children: [
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit
                                                        .clientWarrantiesModel[
                                                            index]
                                                        .productName ??
                                                    '',
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : LinearProgressIndicator(
                        color: kOrangeColor,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
