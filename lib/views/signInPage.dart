import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SignInPage extends StatelessWidget {
  final Locale? currentLocale;

  SignInPage({this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signIn),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.email),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.password),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement sign-in logic
              },
              child: Text(AppLocalizations.of(context)!.signIn),
            ),
          ],
        ),
      ),
    );
  }
}
