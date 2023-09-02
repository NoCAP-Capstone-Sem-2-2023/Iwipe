
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'views/landingPage.dart';
import 'views/authPage.dart';
import 'views/signUpPage.dart';
import 'views/signInPage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = Locale('en', ''); // Default locale
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLocale = Locale(languageCode, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('it', ''),
        Locale('vi', ''),
      ],
      routes: {
        '/': (context) => LandingPage(changeLanguage: _changeLanguage),
        '/auth': (context) => AuthPage(currentLocale: _currentLocale),
        '/signup': (context) => SignUpPage(currentLocale: _currentLocale),
        '/signin': (context) => SignInPage(currentLocale: _currentLocale),
      },
    );
  }
}

void main() {
  runApp(MyApp());
}
