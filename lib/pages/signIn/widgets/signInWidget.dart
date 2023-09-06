import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar(){
  return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: Colors.grey,
          height: 0.5.h,
        ),
      ),
      title: Text(
        "Sign In",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      )
  );
}
