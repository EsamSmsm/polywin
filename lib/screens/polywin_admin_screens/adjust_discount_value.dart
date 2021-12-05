import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_states.dart';

class AdjustDiscountValue extends StatelessWidget {
  const AdjustDiscountValue({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolywinAdminCubit, PolywinAdminStates>(
        listener: (context, state) {},
        builder: (context, state) {
          PolywinAdminCubit cubit = PolywinAdminCubit.get(context);
          return Scaffold(
              appBar: CustomAppBar(
                title: ' نسبة الخصم',
                isSigned: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Label(text: 'نسبة الخصم للوكلاء'),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        itemCount: cubit.agentsDiscounts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3.5,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color(0xffFCFCFC),
                            border: Border.all(color: Color(0xffDFDFDF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.agentsDiscounts[index].typeofCategoryName,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    cubit.agentsDiscounts[index].descount
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'roboto'),
                                  ),
                                  cubit.workshopsDiscounts[index]
                                              .typeDescountName ==
                                          'نسبة مئوية'
                                      ? Text(
                                          '% ',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'roboto'),
                                        )
                                      : Text(''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Label(text: 'نسبة الخصم للورش'),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        itemCount: cubit.workshopsDiscounts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3.5,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          // width: MediaQuery.of(context).size.width*0.45,
                          // height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(
                            color: Color(0xffFCFCFC),
                            border: Border.all(color: Color(0xffDFDFDF)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cubit.workshopsDiscounts[index]
                                    .typeofCategoryName,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                              Row(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Text(
                                    cubit.workshopsDiscounts[index].descount
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'roboto'),
                                  ),
                                  cubit.workshopsDiscounts[index]
                                              .typeDescountName ==
                                          'نسبة مئوية'
                                      ? Text(
                                          '% ',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'roboto'),
                                        )
                                      : Text(''),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
