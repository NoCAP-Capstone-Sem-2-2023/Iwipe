import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/routes/routes.dart';
import 'global.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Color.fromRGBO(241, 241, 241, 1),
                    elevation: 0,
                  ),
                ),
                onGenerateRoute: AppPages.GenerateRouteSettings,
              )),
    );
  }
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Global.init();
  runApp(MyApp());
}
