import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/customer_states.dart';

class WarrantyDetailsScreen extends StatelessWidget {
  const WarrantyDetailsScreen({Key key, this.warrantyIndex}) : super(key: key);
  final int warrantyIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'الضمان',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CustomerCubit, CustomerStates>(
            builder: (context, state) {
              CustomerCubit cubit = CustomerCubit.get(context);
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'شهادة ضمان',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kBlueColor),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/warranty.png'))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Label(text: 'ضمان 20 سنة علي القطاعات'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kDarkBlueColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'نهاية الضمان',
                              style: TextStyle(
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              cubit.clientWarrantiesModel[warrantyIndex]
                                  .endSectorsWarrantyDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(color: kBlueColor, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kDarkBlueColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'بداية الضمان',
                              style: TextStyle(
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              cubit.clientWarrantiesModel[warrantyIndex]
                                  .startSectorsWarrantyDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(color: kBlueColor, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Label(text: 'ضمان 5 سنين علي الأكسسوار'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kDarkBlueColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'نهاية الضمان',
                              style: TextStyle(
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              cubit.clientWarrantiesModel[warrantyIndex]
                                  .endAccessoresWarrantyDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(color: kBlueColor, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kDarkBlueColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'بداية الضمان',
                              style: TextStyle(
                                  color: kDarkBlueColor,
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            ),
                            Text(
                              cubit.clientWarrantiesModel[warrantyIndex]
                                  .startAccessoresWarrantyDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(color: kBlueColor, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Label(text: 'الصور'),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit
                        .clientWarrantiesModel[warrantyIndex].listImage.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 2 / 2,
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: NetworkImage(
                                      '$kBaseURL${cubit.clientWarrantiesModel[warrantyIndex].listImage[index]}',
                                    ),
                                  )),
                                ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '$kBaseURL${cubit.clientWarrantiesModel[warrantyIndex].listImage[index]}',
                          ),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
