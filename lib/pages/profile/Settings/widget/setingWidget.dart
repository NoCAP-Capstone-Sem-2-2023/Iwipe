import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/common/values/colors.dart';

AppBar buildAppbar() {
  return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        child: Container(
          child: Text(
            "Settings",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText),
          ),
        ),
      ));
}

Widget SettingBTN(BuildContext context, void Function()? func) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Are you sure you want to log out your account?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(onPressed: () => func!(), child: Text("Yes")),
              ],
            );
          });
    },
    child: Container(
      height: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/icons/Logout.png"),
        ),
      ),
    ),
  );
}
