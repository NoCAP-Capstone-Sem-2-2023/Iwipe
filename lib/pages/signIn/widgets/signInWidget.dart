import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar buildAppBar() {
  return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
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
      ));
}

Widget buildThirdPartyLogin(BuildContext context) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _reusableIcons("google"),
          _reusableIcons("facebook"),
          _reusableIcons("apple"),
        ],
      ),
    ),
  );
}

Widget _reusableIcons(String iconName) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: 40.w,
      height: 40.h,
      child: Image.asset(
        "assets/icons/$iconName.png",
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(top: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.8),
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

Widget buildTextField(String text, String textType, String icon,
    void Function(String value)? func) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(top: 5.h, bottom: 20.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15.w)),
      border: Border.all(color: Colors.black.withOpacity(0.5)),
    ),
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 12.w),
          child: Image.asset("assets/icons/$icon.png"),
        ),
        Container(
          width: 270.w,
          height: 50.h,
          child: TextField(
            onChanged: (value) => func!(value),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.transparent,
              )),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.transparent,
              )),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.transparent,
              )),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.transparent,
              )),
            ),
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Avenir",
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
            autocorrect: false,
            obscureText: textType == "password" ? true : false,
            textAlignVertical: TextAlignVertical.center,
          ),
        )
      ],
    ),
  );
}

Widget forgotPassword() {
  return Container(
    width: 260.w,
    height: 44.h,
    margin: EdgeInsets.only(left: 25.w),
    child: GestureDetector(
      onTap: () {},
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          color: Colors.black.withOpacity(0.8),
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue,
        ),
      ),
    ),
  );
}

Widget buildButton(String buttonName, void Function()? func) {
  return GestureDetector(
    onTap: () {
      func?.call(); // Use func?.call() to invoke the function if it's not null
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: buttonName == "Log In" ? 40.h : 0.h,
          bottom: 10.h),
      decoration: BoxDecoration(
          color: buttonName == "Log In" ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.w))),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              color: buttonName == "Log In" ? Colors.white : Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
