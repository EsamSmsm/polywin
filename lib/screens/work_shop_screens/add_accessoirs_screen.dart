import 'package:flutter/material.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/custom_button.dart';
import 'package:polywin/shared/constants.dart';

class AddAccessoiresScreen extends StatelessWidget {
  const AddAccessoiresScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الأكسسوارات',
        isSigned: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemCount: 8,
                itemBuilder: (context, index) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: ExpansionTile(
                      collapsedTextColor: kBlueColor,
                      collapsedIconColor: kBlueColor,
                      title: Text('اسم المنتج'),
                      children: <Widget>[]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                label: 'اضافة الاكسسوار للعنصر',
                color: kBlueColor,
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
