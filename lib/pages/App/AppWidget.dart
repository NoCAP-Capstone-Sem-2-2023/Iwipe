import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/home/homePage.dart';
import 'package:iwipe/pages/profile/profile.dart';

import '../../common/values/colors.dart';

Widget buildPage(int index) {
  List<Widget> _widgetOptions = [
    HomePage(),
    Center(child: Text("Search")),
    Center(child: Text("Course")),
    Center(child: Text("Chat")),
    Profile(),
  ];

  return _widgetOptions[index];
}

var bottomTabs = [
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
];
