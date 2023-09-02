import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LandingPage extends StatefulWidget {
  final Function(String) changeLanguage;

  LandingPage({required this.changeLanguage});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late double opacityLevel;
  late bool showPopup;

  @override
  void initState() {
    super.initState();
    opacityLevel = 0.0;
    showPopup = false;

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacityLevel = 1.0;
        showPopup = true;
      });
    });
  }

  void _changeLanguage(String languageCode) {
    widget.changeLanguage(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: height / 3,
            left: width / 4,
            child: Image.asset(
              'assets/images/maid.png',
              width: width / 2,
              height: height / 3,
            ),
          ),

          // Chat bubble
          Positioned(
            top: height / 2, // This will position it in the middle of the screen
            left: width / 4,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                AppLocalizations.of(context)!.landingText,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),


          // Popup
          if (showPopup) Positioned(
            top: 100,
            left: 50,
            child: AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/auth');
                },
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.gettingStared,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ) else Container(),


          // Swipe to change to auth page
          Positioned.fill(
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx < 0) {
                  Navigator.pushNamed(context, '/auth');
                }
              },
            ),
          ),

          // Language selection
          Positioned(
            top: 40,
            right: 20,
            child: DropdownButton<String>(
              value: Localizations.localeOf(context).languageCode,
              icon: Icon(Icons.language),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);
                }
              },
              items: <String>['en', 'it', 'vi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
