import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/work_shop_screens/add_customer_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_button_2.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/search_bar.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkshopCubit,WorkshopStates>(
        listener: (context, state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
        },
      builder: (context, state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'قائمة العملاء',
            isSigned: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton2(
                        label: 'اضافة عميل',
                        color: Color(0xffFFA41B),
                        onTab: () {
                          navigateTo(context, AddClientScreen());
                        },
                      ),
                      Text(
                        'قائمة العملاء',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        textDirection: TextDirection.rtl,
                      )
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.getAllClientsModel != null,
                  fallback: (context) => LinearProgressIndicator(
                    color: kOrangeColor,
                  ),
                  builder: (context) => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cubit.getAllClientsModel.payload.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: Text(cubit.getAllClientsModel.payload[index].name),
                        subtitle: Text(
                          cubit.getAllClientsModel.payload[index].clientPhone,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
