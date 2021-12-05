import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/polywin_admin_screens/bottom_nav_bar_screens/admin_warehouse_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/search_bar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/agent_states.dart';

class AgentWarehouseScreen extends StatelessWidget {
  const AgentWarehouseScreen({Key key}) : super(key: key);

  //
  @override
  Widget build(BuildContext context) {

    AgentCubit cubit = AgentCubit.get(context);

    return BlocConsumer<AgentCubit, AgentStates>(
      listener: (context, state) {},
      builder: (context, state) {


        double calculateTotalValue() {
          double total = 0;
          cubit.getStoreDataModel.payload.forEach((element) {
            element.listProduct.forEach((element) {
              total +=  element.totalPriceProduct;
            });
          });
          print(total.toString());
          return total;
        }
        return Scaffold(
            appBar: CustomAppBar(
              isSigned: true,
              title: 'المخزن',
            ),
            body: cubit.getStoreDataModel != null?
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Colors.white,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'الاجمالي',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('${calculateTotalValue().toString()}   جنيه',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                cubit.getStoreDataModel.payload == null?
                Center(child: Text('لا يوجد منتجات في الخزن'),)
                    :DefaultTabController(
                    length: cubit.getStoreDataModel.payload.length,
                    initialIndex: cubit.getStoreDataModel.payload.length>0?
                    cubit.getStoreDataModel.payload.length- 1:0,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                              physics: BouncingScrollPhysics(),
                              indicatorColor: kBlueColor,
                              labelStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                              isScrollable: cubit.getStoreDataModel
                                  .payload.length > 3 ? true:false,
                              unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.normal),
                              tabs: List.generate(
                                cubit.getStoreDataModel.payload.length,
                                    (index) => Text(
                                  cubit.getStoreDataModel.payload[index]
                                      .categoryName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'GE_SS'),
                                ),
                              )),
                          Expanded(
                            child: TabBarView(
                                physics: BouncingScrollPhysics(),
                                children: List.generate(
                                  cubit.getStoreDataModel.payload.length,
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
                                              itemCount: cubit
                                                  .getStoreDataModel
                                                  .payload[ndx]
                                                  .listProduct
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  ProductCard(
                                                    name: cubit
                                                        .getStoreDataModel
                                                        .payload[ndx]
                                                        .listProduct[index]
                                                        .productName,
                                                    totalProductValue: cubit
                                                        .getStoreDataModel
                                                        .payload[ndx]
                                                        .listProduct[index]
                                                        .totalPriceProduct
                                                        .toString(),
                                                    quantity: cubit
                                                        .getStoreDataModel
                                                        .payload[ndx]
                                                        .listProduct[index]
                                                        .quantity
                                                        .toString(),
                                                    code: cubit
                                                        .getStoreDataModel
                                                        .payload[ndx]
                                                        .listProduct[index]
                                                        .productCode,
                                                    imagePath: cubit
                                                        .getStoreDataModel
                                                        .payload[ndx]
                                                        .listProduct[index]
                                                        .productImg,
                                                  ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                  SizedBox(
                                                    height: 20,
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
              ],
            )
                :LinearProgressIndicator(
              color: kOrangeColor,
            ),

        );
      },
    );
  }
}
