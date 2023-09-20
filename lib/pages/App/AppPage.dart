import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/common/values/colors.dart';
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
        bottomNavigationBar: Container(
          width: 375.w,
          height: 58.h,
          decoration: BoxDecoration(
              color: AppColors.primaryElement,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w),
              topRight: Radius.circular(10.w),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 11,
              ),
            ],
          ),
          child: BottomNavigationBar(
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
                  activeIcon: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Image.asset("assets/icons/home.png",
                          fit: BoxFit.cover, color: AppColors.primaryElement)),
                ),
                BottomNavigationBarItem(
                  label: "Search",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/search.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  activeIcon: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Image.asset("assets/icons/search.png",
                          fit: BoxFit.cover, color: AppColors.primaryElement)),
                ),
                BottomNavigationBarItem(
                  label: "Course",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/play-circle1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  activeIcon: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Image.asset("assets/icons/play-circle1.png",
                          fit: BoxFit.cover, color: AppColors.primaryElement)),
                ),
                BottomNavigationBarItem(
                  label: "Chat",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/message-circle.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  activeIcon: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Image.asset("assets/icons/message-circle.png",
                          fit: BoxFit.cover, color: AppColors.primaryElement)),
                ),
                BottomNavigationBarItem(
                  label: "Setting",
                  icon: SizedBox(
                    width: 15.w,
                    height: 15.h,
                    child: Image.asset(
                      "assets/icons/person2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  activeIcon: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: Image.asset("assets/icons/person2.png",
                          fit: BoxFit.cover, color: AppColors.primaryElement)),
                )
              ]),
        ),
      )),
    );
  }
}
