import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polywin/shared/components/defaults.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/app_states.dart';
import 'catalogue_screen.dart';

class DataSheetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return cubit.dataSheetModel != null
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
                                    'داتا شيت',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: kBlueColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => CatalogueItem(
                              label: cubit
                                  .dataSheetModel.payload[index].description,
                              image: NetworkImage(
                                  '$kBaseURL${cubit.dataSheetModel.payload[index].imagePath}'),
                            ),
                            itemCount: cubit.dataSheetModel.payload.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : LinearProgressIndicator(
                  color: kOrangeColor,
                );
        },
      ),
    );
  }
}
