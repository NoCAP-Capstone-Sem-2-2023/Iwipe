import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/splashScreen/splashScreen.dart';
import 'package:iwipe/app_blocs.dart';

import 'views/landingPage.dart';
import 'views/authPage.dart';
import 'views/signUpPage.dart';
import 'views/signInPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBlocs(),
      child: ScreenUtilInit(
          builder: (context, child) => const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
              )),
    );
  }
}

void main() {
  runApp(MyApp());
}
