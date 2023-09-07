import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/signIn/signIn.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_blocs.dart';
import 'package:iwipe/pages/splashScreen/splashScreen.dart';
import 'package:iwipe/app_blocs.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBlocs>(
          create: (context) => AppBlocs(),
        ),
        BlocProvider<SplashScreenBloc>(
          create: (context) => SplashScreenBloc(),
        ),
      ],
      child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    backgroundColor: Color.fromRGBO(241, 241, 241, 1),
                    elevation: 0,
                  ),
                ),
                home: const SplashScreen(),
                routes: {
                  "signIn": (context) => const SignIn(),
                },
              )),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
