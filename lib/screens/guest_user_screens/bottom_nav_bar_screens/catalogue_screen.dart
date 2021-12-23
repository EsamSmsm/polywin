import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';

class CatalogueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.catalogueModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Polywin',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: kOrangeColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'كتالوجات',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: kBlueColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ListView(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                cubit.catalogueModel.payload.length,
                                (index) => CatalogueItem(
                                  label: cubit.catalogueModel.payload[index]
                                      .description,
                                  image: NetworkImage(
                                    '$kBaseURL${cubit.catalogueModel.payload[index].logoPath}',
                                  ),
                                  onTab: () {
                                    launchURL(
                                        '$kBaseURL${cubit.catalogueModel.payload[index].filePath}');
                                  },
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : LinearProgressIndicator(
                  color: kOrangeColor,
                ),
        );
      },
    );
  }
}

class CatalogueItem extends StatelessWidget {
  const CatalogueItem({
    Key key,
    this.label,
    this.onTab,
    this.image,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String label;
  final Function onTab;
  final ImageProvider image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 222,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: image, fit: fit),
                // boxShadow: [
                //   BoxShadow(color: Colors.black45,blurRadius: 1)
                // ]
              ),
            ),
            Container(
              height: 52,
              color: Colors.white.withAlpha(190),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: kOrangeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
