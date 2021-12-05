import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class AdminWarehouseScreen extends StatelessWidget {
  const AdminWarehouseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<PolywinAdminCubit,PolywinAdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        PolywinAdminCubit cubit = PolywinAdminCubit.get(context);

        double calculateTotalValue(){
          double total = 0;
           cubit.getStoreDataModel.payload.forEach((element) {
             element.listProduct.forEach((element) {
               total += element.totalPriceProduct;
             });});
           print (total.toString());
           return total;
        }

        return Scaffold(
          appBar: CustomAppBar(
            isSigned: true,
            title: 'المخزن',
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConditionalBuilder(
              condition: cubit.getStoreDataModel != null,
              fallback: (context) => LinearProgressIndicator(
                color: kOrangeColor,
              ),
              builder: (context) => Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    color: Colors.white,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('الاجمالي',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text(' ${calculateTotalValue().toString()}  جنيه ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  DefaultTabController(
                      length: cubit.getStoreDataModel.payload.length,
                      initialIndex: 0,
                      child: Expanded(
                        child: Column(
                          children: [
                            TabBar(
                              physics: BouncingScrollPhysics(),
                              indicatorColor: kBlueColor,
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              isScrollable: cubit.getStoreDataModel.payload.length>3? true:false,
                              unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.normal),
                              tabs: List.generate(cubit.getStoreDataModel.payload.length, (index) => Text(
                                cubit.getStoreDataModel.payload[index].categoryName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'GE_SS'),
                              ),)
                            ),
                            Expanded(
                              child: TabBarView(
                                  physics: BouncingScrollPhysics(),
                                  children: List.generate(cubit.getStoreDataModel.payload.length, (ndx) => Scaffold(
                                    body: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 20,),
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: cubit.getStoreDataModel.payload[ndx].listProduct.length,
                                              itemBuilder: (context, index) =>  ProductCard(
                                                name: cubit.getStoreDataModel.payload[ndx].listProduct[index].productName,
                                                code:  cubit.getStoreDataModel.payload[ndx].listProduct[index].productCode,
                                                quantity:  cubit.getStoreDataModel.payload[ndx].listProduct[index].quantity.toString(),
                                                totalProductValue:  cubit.getStoreDataModel.payload[ndx].listProduct[index].totalPriceProduct.toString(),
                                              ),
                                              separatorBuilder: (context, index) => SizedBox(height: 20,))
                                        ],
                                      ),
                                    ),
                                  ),)),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key, this.code, this.quantity, this.name, this.totalProductValue, this.imagePath,
  }) : super(key: key);

  final String code;
  final String quantity;
  final String name;
  final String totalProductValue;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height *
              0.2,
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
                    padding:
                        const EdgeInsets.only(
                            top: 10, right: 10),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection:
                              TextDirection.rtl,
                          child: Row(
                            children: [
                              Text(
                                'الكود : ',
                                style: TextStyle(
                                    color: kBlueColor,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                  width: 10),
                              Text(
                                code,
                                style: TextStyle(
                                  fontFamily: 'roboto',
                                    color: kBlueColor,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                              name,
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                            overflow: TextOverflow.clip,
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
                          '$kBaseURL$imagePath',),
                      errorBuilder:(context, error, stackTrace) =>  Container(
                        color: Colors.grey.shade300,
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
                  flex:3,
                    child: Directionality(
                  textDirection:
                      TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets
                            .symmetric(
                        horizontal: 16),
                    child: Row(
                      children: [
                        Text('اجمالي الصنف :',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),),
                        SizedBox(width: 10,),
                        Text(totalProductValue,style: TextStyle(
                            fontSize: 15
                        ),)
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
                  textDirection:
                      TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets
                            .symmetric(
                        horizontal: 20),
                    child: Row(
                      children: [
                        Text('العدد :',style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600
                        ),),
                        SizedBox(width: 8,),
                        Text(quantity,style: TextStyle(
                          fontSize: 17
                        ),)
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
