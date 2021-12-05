import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class DiscountsCalculationScreen extends StatelessWidget {
  const DiscountsCalculationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isSigned: true,
        title: ' التخصيمات',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/chart.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              'يمكنك تحميل ملف التخصيمات من هنا',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 80,
            ),
            BlocBuilder<WorkshopCubit, WorkshopStates>(
              builder: (context, state) {
                WorkshopCubit cubit = WorkshopCubit.get(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: CustomButton(
                    color: kBlueColor,
                    label: 'تحميل ملف التخصيمات',
                    onTab: () {
                      launchURL(
                          '$kBaseURL${cubit.workshopFactorsFileModel.payload[0].filePath}');
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
