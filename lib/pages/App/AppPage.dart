import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/App/AppWidget.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: buildPage(_index),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _index = index;
              });
            },
            currentIndex: _index,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  activeIcon: Image.asset("assets/icons/home.png",
                      fit: BoxFit.cover,
                      color: Color.fromRGBO(241, 241, 241, 1))),
              BottomNavigationBarItem(
                  label: "Search",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              BottomNavigationBarItem(
                  label: "Course",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              BottomNavigationBarItem(
                  label: "Chat",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      fit: BoxFit.cover,
                    ),
                  )),
              BottomNavigationBarItem(
                  label: "Setting",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/home.png",
                      fit: BoxFit.cover,
                    ),
                  ))
            ]),
      )),
    );
  }
}
