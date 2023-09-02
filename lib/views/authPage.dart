import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AuthPage extends StatelessWidget {
  final Locale? currentLocale;

  AuthPage({this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: currentLocale,
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
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.authPage),
          leading: IconButton(
          icon: Icon(Icons.arrow_back), // set your icon here
          onPressed: () => Navigator.pop(context),
        ),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement sign in logic
                },
                child: Text(AppLocalizations.of(context)!.signIn),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement sign up logic
                },
                child: Text(AppLocalizations.of(context)!.signUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
