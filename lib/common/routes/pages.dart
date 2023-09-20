//unify BlocProvider and routes and pages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/common/routes/names.dart';
import 'package:iwipe/pages/register/bloc/register_blocs.dart';
import 'package:iwipe/pages/register/register.dart';
import 'package:iwipe/pages/signIn/signIn.dart';
import 'package:iwipe/pages/splashScreen/splashScreen.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_blocs.dart';

import '../../global.dart';
import '../../pages/App/AppPage.dart';
import '../../pages/App/bloc/appBlocs.dart';
import '../../pages/signIn/bloc/sign_in_bloc.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.initial,
          page: const SplashScreen(),
          bloc: BlocProvider(
            create: (_) => SplashScreenBloc(),
          )),
      PageEntity(
          route: AppRoutes.signIn,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.register,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(),
          )),
      PageEntity(
          route: AppRoutes.app,
          page: const AppPage(),
          bloc: BlocProvider(
            create: (_) => AppBloc(),
          ))
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProvider = <dynamic>[];
    for (var bloc in routes()) {
      blocProvider.add(bloc.bloc);
    }
    return blocProvider;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        //If user already open the app before, then go to sign in page
        bool deviceFirstOpen = Global.storageService.getDeviceOpenFirstTime();
        if (result.first.route == AppRoutes.initial && deviceFirstOpen) {
          //If user already sign in, then go to app page
          bool isLogIn = Global.storageService.getIsLogin();
          if (result.first.route == AppRoutes.initial && isLogIn) {
            return MaterialPageRoute(
                builder: (_) => const AppPage(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => const SignIn(), settings: settings);
        }

        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}
