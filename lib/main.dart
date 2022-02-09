import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:polywin/layout/agent_layout.dart';
import 'package:polywin/layout/customert_layout.dart';
import 'package:polywin/layout/polywin_admin_layout.dart';
import 'package:polywin/layout/workshop_layout.dart';
import 'package:polywin/network/local/cache_helper.dart';
import 'package:polywin/network/remote/dio_helper.dart';
import 'package:polywin/screens/guest_user_screens/home_screen.dart';
import 'package:polywin/shared/bloc_observer.dart';
import 'package:polywin/shared/constants.dart';
import 'package:polywin/shared/cubit/agent_cubit.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:polywin/shared/cubit/customer_cubit.dart';
import 'package:polywin/shared/cubit/polywin_admin_cubit.dart';
import 'package:polywin/shared/cubit/workshop_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  kToken = CacheHelper.getData('token');
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget getCurrentUser() {
      switch (kUserType) {
        case 1:
          {
            return PolywinAdminLayout();
          }
          break;
        case 2:
          {
            return AgentLayout();
          }
          break;
        case 3:
          {
            return WorkShopLayout();
          }
          break;
        case 4:
          {
            return CustomerLayout();
          }
          break;
        default:
          {
            return HomeScreen();
          }
        //return null;
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..fetchData()),
        BlocProvider(
          create: (context) => WorkshopCubit()..fetchData(),
        ),
        BlocProvider(
          create: (context) => PolywinAdminCubit()..fetchData(),
        ),
        BlocProvider(
          create: (context) => AgentCubit()..fetchData(),
        ),
        BlocProvider(
          create: (context) => CustomerCubit()..fetchData(),
        ),
      ],
      child: MaterialApp(
        title: 'Polywin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'GE_SS',
          primarySwatch: Colors.blue,
        ),
        home: kToken == '' ? HomeScreen() : getCurrentUser(),
        //
      ),
    );
  }
}
