import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/search_result_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/search_bar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class PricesListScreen extends StatelessWidget {
  const PricesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController searchController = TextEditingController();
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            isSigned: true,
            title: 'قائمة الاسعار',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                ///search bar
                SearchBar(
                  controller: searchController,
                  search: () {
                    cubit.searchProduct(search: searchController.text);
                    if (cubit.searchProductModel != null) {
                      navigateTo(context, SearchResultScreen());
                    }
                  },
                ),
                SizedBox(height: 20),
                ConditionalBuilder(
                  condition: cubit.productsListModel != null,
                  fallback: (context) => LinearProgressIndicator(
                    color: kOrangeColor,
                  ),
                  builder: (context) => DefaultTabController(
                    length: cubit.productsListModel.payload.length,
                    initialIndex: 0,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                              //padding: EdgeInsets.symmetric(vertical: 10),
                              physics: BouncingScrollPhysics(),
                              labelPadding: EdgeInsets.all(10),
                              indicatorColor: kBlueColor,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              isScrollable:
                                  cubit.productsListModel.payload.length > 3
                                      ? true
                                      : false,
                              unselectedLabelStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              tabs: List.generate(
                                cubit.productsListModel.payload.length,
                                (index) => Text(
                                  cubit.productsListModel.payload[index]
                                      .categoryName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontFamily: 'GE_SS'),
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: BouncingScrollPhysics(),
                              children: List.generate(
                                cubit.productsListModel.payload.length,
                                (ndx) => Scaffold(
                                  body: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: cubit.productsListModel
                                              .payload[ndx].listProduct.length,
                                          itemBuilder: (context, index) =>
                                              ProductPriceCard(
                                            productCode: cubit
                                                .productsListModel
                                                .payload[ndx]
                                                .listProduct[index]
                                                .productCode,
                                            productName: cubit
                                                .productsListModel
                                                .payload[ndx]
                                                .listProduct[index]
                                                .name,
                                            pricePerMeter: cubit
                                                .productsListModel
                                                .payload[ndx]
                                                .listProduct[index]
                                                .pricePerMeter
                                                .toString(),
                                            pricePerOne: cubit
                                                .productsListModel
                                                .payload[ndx]
                                                .listProduct[index]
                                                .pricePerOne
                                                .toString(),
                                            imagePath: '$kBaseURL'
                                                '${cubit.productsListModel.payload[ndx].listProduct[index].imgUrl}',
                                          ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                            height: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductPriceCard extends StatelessWidget {
  const ProductPriceCard(
      {this.productCode,
      this.productName,
      this.pricePerOne,
      this.pricePerMeter,
      this.imagePath});

  final String productCode;
  final String productName;
  final String pricePerOne;
  final String pricePerMeter;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                'الكود : ',
                                style:
                                    TextStyle(color: kBlueColor, fontSize: 17),
                              ),
                              SizedBox(width: 10),
                              Text(
                                productCode,
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    color: kBlueColor,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            productName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image(
                      image: NetworkImage(
                        imagePath ?? '',
                      ),
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'السعر بالعود :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              pricePerOne,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    )),
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey,
                ),
                Expanded(
                    flex: 2,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'السعر بالمتر :',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              pricePerMeter,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
