import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.getCompanyInfoModel!=null?SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Polywin',
                              style: TextStyle(
                                fontSize: 20,
                                color: kOrangeColor,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'عن',
                              style: TextStyle(
                                fontSize: 20,
                                color: kBlueColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Text(
                            cubit.getCompanyInfoModel.payload.companyInfo,
                            style: TextStyle(
                              color: Color(0xff0D5670),
                              fontSize: 17,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                              '"نافذة المستقبل"',
                              style: TextStyle(color: kOrangeColor, fontSize: 17),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          cubit.getCompanyInfoModel.payload.futureInfo,
                          style: TextStyle(
                            color: Color(0xff0D5670),
                            fontSize: 17,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: (){
                            launchURL('$kBaseURL${cubit.getCompanyInfoModel.payload.companyFile}');
                          },
                          child: Row(textDirection: TextDirection.rtl,
                          children: [
                            Icon(Icons.cloud_download_outlined,
                            color: kBlueColor,size: 35,),
                            SizedBox(width: 10,),
                            Text('تحميل ملف الشركة',textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 20,
                              color: kBlueColor,
                              fontWeight: FontWeight.bold
                            ),)
                          ],),
                        ),
                        SizedBox(height: 30,),
                        Text(
                          'منتجات',
                          style: TextStyle(
                              color: kOrangeColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProductItem(
                          label: 'شبابيك',
                          image: AssetImage('assets/images/window.png'),
                        ),
                        ProductItem(
                          label: 'أبواب',
                          image: AssetImage('assets/images/doors.png'),
                        ),
                        ProductItem(
                          label: 'قطاعات',
                          image: AssetImage('assets/images/cuts.png'),
                        ),
                        ProductItem(
                          label: 'أكسسوارات',
                          image: AssetImage('assets/images/accessoires.png'),
                        ),
                        ProductItem(
                          label: 'مكائن',
                          image: AssetImage('assets/images/machines.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    child: Text(
                      "اتصل الان  15231",
                      style: TextStyle(fontSize: 24, color: kOrangeColor),
                    ),
                    onPressed: () {
                      launchURL('tel:15231');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SocialRow(),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          )
          :LinearProgressIndicator(
            color: kOrangeColor,
          ),
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.image,
    this.label,
  }) : super(key: key);

  final String label;
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(190),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Polywin',
                    style: TextStyle(
                      color: kOrangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                      color: kOrangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
