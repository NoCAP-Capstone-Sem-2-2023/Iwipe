import 'package:flutter/cupertino.dart';

Widget buildPage(int index) {
  List<Widget> _widgetOptions = const <Widget>[
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Course")),
    Center(child: Text("Chat")),
    Center(child: Text("Profile")),
  ];

  return _widgetOptions[index];
}
