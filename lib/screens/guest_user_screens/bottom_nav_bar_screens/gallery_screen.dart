import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/screens/update_profile_screen.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, AppStates state) {},
      builder: (context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xfff8f8f8),
          body: cubit.galleryModel != null
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTabController(
                        length: cubit.galleryModel.payload.length,
                        initialIndex: 0,
                        child: Expanded(
                          child: Column(
                            children: [
                              TabBar(
                                  labelPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey,
                                  physics: BouncingScrollPhysics(),
                                  indicatorColor: kOrangeColor,
                                  isScrollable: true,
                                  tabs: List.generate(
                                    cubit.galleryModel.payload.length,
                                    (index) => Text(
                                      cubit.galleryModel.payload[index].name,
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )),
                              Expanded(
                                child: TabBarView(
                                    physics: BouncingScrollPhysics(),
                                    children: List.generate(
                                      cubit.galleryModel.payload.length,
                                      (index) => SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: cubit
                                                      .galleryModel
                                                      .payload[index]
                                                      .listGallery
                                                      .length !=
                                                  0
                                              ? Column(
                                                  children: List.generate(
                                                    cubit
                                                        .galleryModel
                                                        .payload[index]
                                                        .listGallery
                                                        .length,
                                                    (ndx) => SubCategory(
                                                      cubit: cubit,
                                                      mainCategoryIndex: index,
                                                      subCategoryIndex: ndx,
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Text(
                                                      'لا يوجد اي بيانات بعد !',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        )),
                  ],
                )
              : LinearProgressIndicator(
                  color: kOrangeColor,
                ),
        );
      },
    );
  }
}

class SubCategory extends StatelessWidget {
  const SubCategory({
    Key key,
    @required this.cubit,
    this.mainCategoryIndex,
    this.subCategoryIndex,
  }) : super(key: key);

  final AppCubit cubit;
  final int mainCategoryIndex;
  final int subCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Label(
            text: cubit.galleryModel.payload[mainCategoryIndex]
                .listGallery[subCategoryIndex].categoryChildName),
        SizedBox(
          height: 20,
        ),
        cubit.galleryModel.payload[mainCategoryIndex]
                    .listGallery[subCategoryIndex].gallery.length !=
                0
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: cubit.galleryModel.payload[mainCategoryIndex]
                    .listGallery[subCategoryIndex].gallery.length,
                itemBuilder: (context, index) => ImageCard(
                  cubit: cubit,
                  mainCategoryIndex: mainCategoryIndex,
                  subCategoryIndex: subCategoryIndex,
                  imageIndex: index,
                ),
              )
            : Column(
                children: [
                  Text(
                    'لا يوجد اي بيانات بعد !',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key key,
    @required this.cubit,
    this.mainCategoryIndex,
    this.subCategoryIndex,
    this.imageIndex,
  }) : super(key: key);

  final AppCubit cubit;
  final int mainCategoryIndex;
  final int subCategoryIndex;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(
                '$kBaseURL${cubit.galleryModel.payload[mainCategoryIndex].listGallery[subCategoryIndex].gallery[imageIndex].pathImage}',
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              cubit
                  .galleryModel
                  .payload[mainCategoryIndex]
                  .listGallery[subCategoryIndex]
                  .gallery[imageIndex]
                  .description,
              textDirection: TextDirection.rtl,
            ),
          ),
        )
      ],
    );
  }
}
