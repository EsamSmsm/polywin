import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/prices_list_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            title: 'نتائج البحث',
            isHomeScreen: false,
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: cubit.searchProductModel != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            cubit.searchProductModel.result.payload.length,
                        itemBuilder: (context, index) => ProductPriceCard(
                          productCode: cubit.searchProductModel.result
                              .payload[index].productCode,
                          productName: cubit
                              .searchProductModel.result.payload[index].name,
                          pricePerMeter: cubit.searchProductModel.result
                              .payload[index].pricePerMeter
                              .toString(),
                          pricePerOne: cubit.searchProductModel.result
                              .payload[index].pricePerOne
                              .toString(),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )
                : Center(
                    child: Text('لا يوجد نتائج'),
                  ),
          ),
        );
      },
    );
  }
}
