import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/common/values/colors.dart';
import '../../global.dart';
import 'Widgets/homePageWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  String? linkAvt;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    Map<String, dynamic>? userProfile = Global.storageService.getUserProfile();
    print(userProfile);
    setState(() {
      username = userProfile?['username'];
      linkAvt = userProfile?['avatar'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(linkAvt),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text(
                "Hello,",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryThreeElementText,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text(
                username ?? "User",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
