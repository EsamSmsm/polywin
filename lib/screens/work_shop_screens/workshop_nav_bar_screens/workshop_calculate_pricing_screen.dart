import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/screens/work_shop_screens/workshop_total_price_screen.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/components/custom_label.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';
import 'package:polywin/shared/cubit/workshop_states.dart';
import '../../../shared/components/custom_dropdown_field.dart';
import '../workshop_display_price_screen.dart';
import 'package:numberpicker/numberpicker.dart';

class WorkshopCalculatePricingScreen extends StatelessWidget {
  const WorkshopCalculatePricingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController mortalController = TextEditingController(text: '5');
    TextEditingController expensesController =
        TextEditingController(text: '100');
    TextEditingController profitsController = TextEditingController(text: '40');

    int widthMeterValue = 0;
    int widthCMValue = 0;
    int heightMeterValue = 0;
    int heightCMValue = 0;
    bool isLoading1 = false;
    bool isLoading2 = false;
    return BlocConsumer<WorkshopCubit, WorkshopStates>(
        listener: (context, WorkshopStates state) {
      if (state is RequestPriceSuccessState && isLoading1) {
        navigateTo(
            context,
            WorkshopTotalPriceScreen(
              width: '$widthMeterValue.$widthCMValue',
              height: '$heightMeterValue.$heightCMValue',
            ));
        isLoading1 = false;
        isLoading2 = false;
      } else if (state is RequestPriceSuccessState && isLoading2) {
        navigateTo(
            context,
            WorkshopDisplayPriceScreen(
              width: '$widthMeterValue.$widthCMValue',
              height: '$heightMeterValue.$heightCMValue',
            ));
        isLoading1 = false;
        isLoading2 = false;
      } else if (state is RequestPriceErrorState) {
        showToast(text: 'حدث خطأ', color: Colors.redAccent);
        isLoading1 = false;
        isLoading2 = false;
      }
    }, builder: (context, WorkshopStates state) {
      WorkshopCubit cubit = WorkshopCubit.get(context);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isHomeScreen: true,
          title: 'حساب التكلفة',
          isSigned: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              ///text
              AppCubit.get(context).colorsModel != null &&
                      cubit.subCategories != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 22, right: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'من فضلك أضف تفاصيل المنتج',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  : LinearProgressIndicator(
                      color: kOrangeColor,
                    ),

              ///listview
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) => ProductTile(
                    index: index,
                    isSelected: cubit.products[index]['isSelected'],
                    label: cubit.products[index]['title'],
                    image: AssetImage(cubit.products[index]['icon']),
                    onTab: () {
                      cubit.subCategoryId = null;
                      cubit.subCategories = [];
                      cubit.changeSelectedProduct(index);
                      cubit.workShopProductsModel.payload.forEach((element) {
                        if (element.id == cubit.products[index]['id']) {
                          cubit.subCategories = element.listSub;
                        }
                      });
                      print(cubit.subCategories);
                    },
                  ),
                ),
              ),

              ///product details
              //Center(child: Text(cubit.products[cubit.selectedItem]['title'])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Product
                    Label(text: 'اختر المنتج'),
                    SizedBox(
                      height: 20,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => CustomDropdownField(
                        hint: 'المنتج',
                        itemsList: cubit.subCategories.map((e) {
                          return DropdownMenuItem(
                            child: Text(
                              e.subCategory,
                              textDirection: TextDirection.rtl,
                            ),
                            value: e,
                            alignment: Alignment.centerRight,
                          );
                        }).toList(),
                        value: cubit.subCategoryId,
                        onChanged: (value) {
                          setState(() {
                            cubit.subCategoryId = value;
                            print(value.id);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    /// Color
                    BlocBuilder<AppCubit, AppStates>(
                      builder: (context, state) => StatefulBuilder(
                          builder: (context, setState) => CustomDropdownField(
                                hint: 'اللون',
                                itemsList: AppCubit.get(context)
                                        .colorsModel
                                        .payload
                                        .map((e) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          e.colorName,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        value: e,
                                        alignment: Alignment.centerRight,
                                      );
                                    }).toList() ??
                                    [],
                                value: cubit.colorId,
                                onChanged: (value) {
                                  setState(() {
                                    cubit.colorId = value;
                                    print(value.id);
                                  });
                                },
                              )),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    ///القياسات ///
                    Label(text: 'الطول'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xffc8c8c8)),
                                color: Color(0xfffcfcfc),
                              ),
                              child: StatefulBuilder(
                                builder: (context, setState) => Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الأمتار',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          heightMeterValue++;
                                        });
                                      },
                                    ),
                                    Text(
                                      heightMeterValue.toString(),
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (heightMeterValue > 0)
                                            heightMeterValue--;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xffc8c8c8)),
                                color: Color(0xfffcfcfc),
                              ),
                              child: StatefulBuilder(
                                builder: (context, setState) => Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'سنتميتر',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (heightCMValue < 100)
                                            heightCMValue++;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 35,
                                      child: NumberPicker(
                                        value: heightCMValue,
                                        axis: Axis.vertical,
                                        onChanged: (value) {
                                          setState(() {
                                            heightCMValue = value;
                                          });
                                        },
                                        textStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                        selectedTextStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                        minValue: 0,
                                        maxValue: 100,
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (heightCMValue > 0)
                                            heightCMValue--;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Label(text: 'العرض'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xffc8c8c8)),
                                color: Color(0xfffcfcfc),
                              ),
                              child: StatefulBuilder(
                                builder: (context, setState) => Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'الأمتار',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          widthMeterValue++;
                                        });
                                      },
                                    ),
                                    Text(
                                      widthMeterValue.toString(),
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (widthMeterValue > 0)
                                            widthMeterValue--;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xffc8c8c8)),
                                color: Color(0xfffcfcfc),
                              ),
                              child: StatefulBuilder(
                                builder: (context, setState) => Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'سنتميتر',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (widthCMValue < 100)
                                            widthCMValue++;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 35,
                                      child: NumberPicker(
                                        value: widthCMValue,
                                        axis: Axis.vertical,
                                        onChanged: (value) {
                                          setState(() {
                                            widthCMValue = value;
                                            print(widthCMValue);
                                          });
                                        },
                                        textStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                        selectedTextStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                        minValue: 0,
                                        maxValue: 100,
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          if (widthCMValue > 0) widthCMValue--;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Label(text: 'نسبة الهالك ( % )'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffc8c8c8)),
                        color: Color(0xfffcfcfc),
                      ),
                      child: TextFormField(
                        controller: mortalController,
                        keyboardType: TextInputType.numberWithOptions(),
                        cursorColor: Colors.grey,
                        style: TextStyle(fontFamily: 'roboto'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "النسبة المئوية للهالك",
                          hintStyle: TextStyle(color: Colors.black54),
                          contentPadding: EdgeInsets.all(10),
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Label(text: ' المصروفات بالجنيه'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffc8c8c8)),
                        color: Color(0xfffcfcfc),
                      ),
                      child: TextFormField(
                        controller: expensesController,
                        keyboardType: TextInputType.numberWithOptions(),
                        cursorColor: Colors.grey,
                        style: TextStyle(fontFamily: 'roboto'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "مصروفات اضافية",
                          hintStyle: TextStyle(color: Colors.black54),
                          contentPadding: EdgeInsets.all(10),
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Label(text: 'نسبة الربح ( % )'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffc8c8c8)),
                        color: Color(0xfffcfcfc),
                      ),
                      child: TextFormField(
                        controller: profitsController,
                        keyboardType: TextInputType.numberWithOptions(),
                        cursorColor: Colors.grey,
                        style: TextStyle(fontFamily: 'roboto'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "النسبة المئوية للربح",
                          hintStyle: TextStyle(color: Colors.black54),
                          contentPadding: EdgeInsets.all(10),
                          hintTextDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ///calculate
              state is RequestPriceLoadingState && isLoading1
                  ? CircularProgressIndicator(
                      color: kBlueColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: CustomButton(
                        label: 'حساب التكلفة علي الورشة',
                        color: kBlueColor,
                        onTab: () {
                          isLoading1 = true;
                          if (cubit.subCategoryId != null &&
                              cubit.colorId != null &&
                              mortalController.text != null &&
                              expensesController.text != null) {
                            cubit.requestTotalPrice(
                                subCategoryId: cubit.subCategoryId.id,
                                colorId: cubit.colorId.id,
                                width: '$widthMeterValue.$widthCMValue',
                                height: '$heightMeterValue.$heightCMValue',
                                mortal: mortalController.text,
                                net: profitsController.text,
                                expenses: expensesController.text);
                          } else {
                            showToast(
                                text: 'تأكد من ادخال البيانات بشكل كامل',
                                color: Colors.redAccent);
                          }
                        },
                      ),
                    ),
              SizedBox(height: 20),

              ///send button
              state is RequestPriceLoadingState && isLoading2
                  ? CircularProgressIndicator(
                      color: kDarkBlueColor,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: CustomButton(
                        label: 'عرض السعر للعميل ',
                        color: kDarkBlueColor,
                        onTab: () {
                          isLoading2 = true;
                          if (cubit.subCategoryId != null &&
                              cubit.colorId != null &&
                              mortalController.text != null &&
                              expensesController.text != null) {
                            cubit.requestTotalPrice(
                                subCategoryId: cubit.subCategoryId.id,
                                colorId: cubit.colorId.id,
                                width: '$widthMeterValue.$widthCMValue',
                                height: '$heightMeterValue.$heightCMValue',
                                mortal: mortalController.text,
                                net: profitsController.text,
                                expenses: expensesController.text);
                          } else {
                            showToast(
                                text: 'تأكد من ادخال البيانات بشكل كامل',
                                color: Colors.redAccent);
                          }
                        },
                      ),
                    ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      );
    });
  }
}

class ProductTile extends StatelessWidget {
  ProductTile({
    Key key,
    this.label,
    this.image,
    this.index,
    this.isSelected,
    this.onTab,
  }) : super(key: key);

  final String label;
  final ImageProvider image;
  final int index;
  final bool isSelected;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 0.22,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isSelected
                ? Border.all(color: kBlueColor)
                : Border.all(color: Colors.transparent),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1)]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: image),
              SizedBox(
                height: 10,
              ),
              Text(
                label,
                style: TextStyle(
                    color: kBlueColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
