import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class ChooseClientScreen extends StatelessWidget {
  const ChooseClientScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'العملاء',
        isSigned: true,
        isHomeScreen: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('قائمة العملاء',textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  // CustomButton2(
                  //   label: 'ارسال',
                  //   color: Color(0xffFFA41B),
                  //   onTab: () {
                  //   },
                  // ),
                ],
              ),
              SizedBox(height: 30,),
              BlocBuilder<WorkshopCubit,WorkshopStates>(
                builder:(context, state) {
                  WorkshopCubit cubit = WorkshopCubit.get(context);
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:(context, index) {
                        bool isSelected = false;
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            title: Text(cubit.getAllClientsModel
                                .payload[index].name,
                              textDirection: TextDirection.rtl,
                            ),
                            selectedTileColor: kOrangeColor,
                            onTap: (){

                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16,),
                      itemCount: cubit.getAllClientsModel.payload.length
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
