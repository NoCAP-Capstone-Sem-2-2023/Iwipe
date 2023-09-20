import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/common/values/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Container(
      margin: EdgeInsets.only(left: 7.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.w,
            height: 12.h,
            child: Image.asset("assets/icons/menu.png"),
          ),
          Text("Profile",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText)),
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset("assets/icons/more-vertical.png"),
          ),
        ],
      ),
    ),
  );
}

var imagesInfo = <String, String>{
  "Settings": "settings.png",
  "Payment details": "credit-card.png",
  "Certificate": "award.png"
};

//Profile IMG and edit
Widget profileDisplayAndEdit() {
  return Container(
    width: 80.w,
    height: 80.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      image: DecorationImage(
        image: AssetImage("assets/icons/headpic.png"),
      ),
    ),
    child: Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: Container(
          width: 25.w,
          height: 25.h,
          decoration: BoxDecoration(
            color: AppColors.primaryElement, // Setting red background color
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Image(
            image: AssetImage("assets/icons/edit 2.png"),
          ),
        ),
      ),
    ),
  );
}

Widget profileFeatures() {
  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
        (index) => GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                      "assets/icons/${imagesInfo.values.elementAt(index)}"),
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: AppColors.primaryElement,
                  ),
                ),
                SizedBox(width: 15.w),
                Text(imagesInfo.keys.elementAt(index),
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText)),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
