import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/layout/workshop_layout.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/screens/work_shop_screens/upload_warranty_images_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';

class CreateWarrantyScreen extends StatelessWidget {
  const CreateWarrantyScreen({Key key, this.contractIndex, this.client})
      : super(key: key);

  final int contractIndex;
  final client;

  @override
  Widget build(BuildContext context) {
    TextEditingController warrantyTimeController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'انشاء ضمان',
      ),
      body: BlocConsumer<WorkshopCubit, WorkshopStates>(
        listener: (context, state) {
          if (state is AddWarrantyGallerySuccessState) {
            WorkshopCubit cubit = WorkshopCubit.get(context);
            showAlertDialogWithAction(
                context: context,
                imagePath: 'assets/images/sent.png',
                message: 'تم الارسال بنجاح',
                buttonText: 'شكراً',
                action: () {
                  cubit.getWorkshopContracts();
                  navigateAndFinish(
                      context,
                      WorkShopLayout(
                        selectedIndex:
                            WorkshopCubit.get(context).selectedIndex = 4,
                      ));
                });
          } else if (state is AddWarrantyGalleryLoadingState) {
            showLoadingDialogue(context);
          }
        },
        builder: (context, state) {
          WorkshopCubit cubit = WorkshopCubit.get(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: cubit.workshopContractsModel.payload[contractIndex]
                          .listItem.length >
                      0
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Label(text: 'اختر المنتج'),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Card(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListTile(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            UploadWarrantyImagesScreen(
                                              contractIndex: contractIndex,
                                              client: client,
                                              productIndex: index,
                                              costCalcId: cubit
                                                  .workshopContractsModel
                                                  .payload[contractIndex]
                                                  .listItem[index]
                                                  .id,
                                            ));
                                      },
                                      title: Text(cubit
                                          .workshopContractsModel
                                          .payload[contractIndex]
                                          .listItem[index]
                                          .productName),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5,
                                ),
                            itemCount: cubit.workshopContractsModel
                                .payload[contractIndex].listItem.length)
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.25,
                        ),
                        child: Text(
                          'تم انشاء الضمان علي كل المنتجات',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 18),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

// class ChooseWarrantyTime extends StatelessWidget {
//   const ChooseWarrantyTime({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     WorkshopCubit cubit = WorkshopCubit.get(context);
//     return StatefulBuilder(
//       builder: (context, setState) => Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             textDirection: TextDirection.rtl,
//             children: [
//               Radio<WarrantyTime>(
//                 activeColor: kOrangeColor,
//                 value: WarrantyTime.Month,
//                 groupValue: cubit.warrantyTime,
//                 onChanged: (WarrantyTime value) {
//                   setState(() {
//                     cubit.warrantyTime = value;
//                   });
//                 },
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Text('شهر'),
//             ],
//           ),
//           Row(
//             textDirection: TextDirection.rtl,
//             children: [
//               Radio<WarrantyTime>(
//                 activeColor: kOrangeColor,
//                 value: WarrantyTime.Annual,
//                 groupValue: cubit.warrantyTime,
//                 onChanged: (WarrantyTime value) {
//                   setState(() {
//                     cubit.warrantyTime = value;
//                   });
//                 },
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Text('سنة'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
