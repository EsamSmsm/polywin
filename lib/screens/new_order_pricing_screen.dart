import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/models/get_parent_category.dart';
import 'package:polywin/screens/order_details_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class NewOrderPricingScreen extends StatelessWidget {
  const NewOrderPricingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      bloc: AppCubit.get(context)..getParentCategoryWithProducts(),
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xfff8f8f8),
          appBar: CustomAppBar(
            title: 'طلبية جديدة',
            isSigned: true,
          ),
          body: Scrollable(
            viewportBuilder: (context, position) => ConditionalBuilder(
              condition: cubit.getParentCategory != null,
              fallback: (context) => LinearProgressIndicator(
                color: kOrangeColor,
              ),
              builder: (context) => Column(
                children: [
                  DefaultTabController(
                    length: cubit.getParentCategory.payload.length,
                    initialIndex: 0,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            labelPadding: EdgeInsets.all(15),
                            isScrollable:
                                cubit.getParentCategory.payload.length <= 4
                                    ? false
                                    : true,
                            physics: BouncingScrollPhysics(),
                            indicatorColor: kOrangeColor,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                            tabs: List.generate(
                              cubit.getParentCategory.payload.length,
                              (index) => Text(
                                cubit.getParentCategory.payload[index]
                                    .parentCategory,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'GE_SS'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                physics: BouncingScrollPhysics(),
                                children: List.generate(
                                  cubit.getParentCategory.payload.length,
                                  (index) => SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                            thickness: 1,
                                          ),
                                          itemCount: cubit
                                              .getParentCategory
                                              .payload[index]
                                              .listCategory
                                              .length,
                                          itemBuilder: (context, ndx) =>
                                              CategoryTile(
                                            cubit: cubit,
                                            index: index,
                                            ndx: ndx,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          // CustomButton(
                          //   label: 'اضافة الي الطلبية',
                          //   color: kBlueColor,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomButton(
                              label: 'عرض الطلبية',
                              color: kDarkBlueColor,
                              onTab: () {
                                navigateTo(context, OrderDetailsScreen());
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key key,
    @required this.cubit,
    this.index,
    this.ndx,
  }) : super(key: key);

  final AppCubit cubit;
  final int index; // => index of main category
  final int ndx; // => index of parent category

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ExpansionTile(
        collapsedTextColor: kBlueColor,
        collapsedIconColor: kBlueColor,
        title: Text(cubit
            .getParentCategory.payload[index].listCategory[ndx].categoryName),
        children: cubit.getParentCategory.payload[index].listCategory[ndx]
                    .products !=
                null
            ? List<Widget>.generate(
                cubit.getParentCategory.payload[index].listCategory[ndx]
                    .products.length,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    shape: Border.all(color: Colors.grey.shade200),
                    leading: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '$kBaseURL${cubit.getParentCategory.payload[index].listCategory[ndx].products[i].imgUrl}'),
                        ),
                      ),
                    ),
                    title: Text(
                      cubit.getParentCategory.payload[index].listCategory[ndx]
                          .products[i].name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          Product product = cubit.getParentCategory
                              .payload[index].listCategory[ndx].products[i];
                          String title = product.name;
                          int productQuantity = 0;
                          int ironQuantity = 0;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: kBlueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ///add quantity
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        Text(
                                          'الكمية',
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffFA912E))),

                                          ///  COUNTER CONTAINER
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ///decrease count
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (productQuantity > 0)
                                                      productQuantity--;
                                                  });
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFA912E),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(4),
                                                      topLeft:
                                                          Radius.circular(4),
                                                    ),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffFA912E)),
                                                  ),
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  productQuantity.toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'roboto'),
                                                ),
                                              ),

                                              ///increase quantity
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    productQuantity++;
                                                  });
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFA912E),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(4),
                                                        topRight:
                                                            Radius.circular(4),
                                                      ),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xffFA912E))),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    ///iron number
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   textDirection: TextDirection.rtl,
                                    //   children: [
                                    //     Text(
                                    //       'عدد الحديد',
                                    //       textDirection: TextDirection.rtl,
                                    //     ),
                                    //     SizedBox(
                                    //       width: 50,
                                    //     ),
                                    //     Container(
                                    //       height: 30,
                                    //       width: 90,
                                    //       decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(5),
                                    //           border: Border.all(
                                    //               color: Color(0xffFA912E))),
                                    //
                                    //       ///  COUNTER CONTAINER
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.spaceBetween,
                                    //         children: [
                                    //           ///decrease count
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               setState(() {
                                    //                 if (ironQuantity > 0)
                                    //                   ironQuantity--;
                                    //               });
                                    //             },
                                    //             child: Container(
                                    //               height: double.infinity,
                                    //               width: 30,
                                    //               decoration: BoxDecoration(
                                    //                 color: Color(0xffFA912E),
                                    //                 borderRadius:
                                    //                     BorderRadius.only(
                                    //                   bottomLeft:
                                    //                       Radius.circular(4),
                                    //                   topLeft:
                                    //                       Radius.circular(4),
                                    //                 ),
                                    //                 border: Border.all(
                                    //                     color:
                                    //                         Color(0xffFA912E)),
                                    //               ),
                                    //               child: Icon(
                                    //                 Icons.remove,
                                    //                 color: Colors.white,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           Container(
                                    //             child: Text(
                                    //               ironQuantity.toString(),
                                    //               style: TextStyle(
                                    //                   fontFamily: 'roboto'),
                                    //             ),
                                    //           ),
                                    //
                                    //           ///increase quantity
                                    //           GestureDetector(
                                    //             onTap: () {
                                    //               setState(() {
                                    //                 ironQuantity++;
                                    //               });
                                    //             },
                                    //             child: Container(
                                    //               height: double.infinity,
                                    //               width: 30,
                                    //               decoration: BoxDecoration(
                                    //                   color: Color(0xffFA912E),
                                    //                   borderRadius:
                                    //                       BorderRadius.only(
                                    //                     bottomRight:
                                    //                         Radius.circular(4),
                                    //                     topRight:
                                    //                         Radius.circular(4),
                                    //                   ),
                                    //                   border: Border.all(
                                    //                       color: Color(
                                    //                           0xffFA912E))),
                                    //               child: Icon(
                                    //                 Icons.add,
                                    //                 color: Colors.white,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                ),
                                actions: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    child: CustomButton2(
                                      color: Color(0xffFA912E),
                                      label: 'اضافة',
                                      onTab: () {
                                        if (product.descount == null) {
                                          product.descount = 0;
                                        }
                                        double priceWithDiscount = double.parse(
                                            (product.pricePerOne -
                                                    (product.pricePerOne *
                                                        (product.descount /
                                                            100)))
                                                .toStringAsFixed(2));
                                        cubit.addProduct(
                                          id: product.id,
                                          name: product.name,
                                          imgURL: product.imgUrl,
                                          categoryId: product.categoryId,
                                          quantity: productQuantity,
                                          pricePerOne: product.pricePerOne,
                                          pricePerMeter: product.pricePerMeter,
                                          discount: product.descount,
                                          priceWithDiscount: priceWithDiscount,
                                          totalOrder: priceWithDiscount *
                                              productQuantity,
                                          numberIron: ironQuantity,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ))
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            : [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('لا يوجد منتج'),
                )
              ],
      ),
    );
  }
}
