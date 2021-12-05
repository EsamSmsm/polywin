import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polywin/custom_icons/custom_icons.dart';
import 'package:polywin/layout/home_layout.dart';
import 'package:polywin/shared/components/custom_appbar.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/components/social_row.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الرئيسية',
        isHomeScreen: true,
        isSigned: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        HomeScreenItem(
                          title: 'معرض',
                          icon: CustomIcons.gallery,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout(
                                        selectedIndex: AppCubit.get(context)
                                            .selectedIndex = 1,
                                      )),
                            );
                          },
                        ),
                        HomeScreenItem(
                          title: "عن",
                          icon: CustomIcons.info,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout(
                                        selectedIndex: AppCubit.get(context)
                                            .selectedIndex = 4,
                                      )),
                            );
                          },
                        ),
                        HomeScreenItem(
                          title: 'داتا شيت',
                          icon: CustomIcons.data_sheet,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout(
                                        selectedIndex: AppCubit.get(context)
                                            .selectedIndex = 2,
                                      )),
                            );
                          },
                        ),
                        HomeScreenItem(
                          title: 'كاتالوجات',
                          icon: CustomIcons.catalogue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout(
                                        selectedIndex: AppCubit.get(context)
                                            .selectedIndex = 3,
                                      )),
                            );
                          },
                        ),
                        // HomeScreenItem(title: 'صور و فيديوهات', icon: Icons.video_collection_sharp, onTap: (){},),
                        HomeScreenItem(
                          title: 'وكلاء و موزعين',
                          icon: CustomIcons.agents,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeLayout(
                                        selectedIndex: AppCubit.get(context)
                                            .selectedIndex = 0,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: (){
                        Share.share('https://play.google.com/store/apps/details?id=com.polywin.polywin');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'شارك التطبيق',
                            style: TextStyle(color: kBlueColor, fontSize: 24),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.share,
                            size: 30,
                            color: kBlueColor,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 80,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 12,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [kBlueColor, kOrangeColor])),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 12,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [kBlueColor, kOrangeColor])),
      ),
    );
  }
}

class HomeScreenItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const HomeScreenItem({
    @required this.title,
    @required this.icon,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              ),
            ],
            color: Colors.white),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              icon,
              size: 40,
              color: Colors.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Polywin',
                  style: TextStyle(
                    fontSize: 13,
                    color: kOrangeColor,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: kBlueColor,
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [kBlueColor, kOrangeColor])),
              height: 7,
            )
          ],
        ),
      ),
    );
  }
}
