import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_states.dart';
import 'package:iwipe/pages/splashScreen/bloc/splashScreen_events.dart';

import 'bloc/splashScreen_blocs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Center(
        child: Scaffold(body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.only(top: 34.h),
              width: 375.w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      BlocProvider.of<SplashScreenBloc>(context)
                          .add(SplashScreenEvent());
                    },
                    children: [
                      _page(
                          1,
                          context,
                          "Next",
                          "Welcome to the iWipe training app - the revolutionary cleaning training program that provides you with the skills and knowledge to start your own cleaning business.",
                          "assets/images/reading.png"),
                      _page(2, context, "Get Started", "Page 2.",
                          "assets/images/boy.png"),
                    ],
                  ),
                  Positioned(
                      bottom: 100.h,
                      child: DotsIndicator(
                        position: state.page,
                        dotsCount: 2,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: Colors.blue,
                          size: const Size.square(8.0),
                          activeSize: const Size(18.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ))
                ],
              ),
            );
          },
        )),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String image) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.h,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 17.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 2) {
              //Animation while swipe on splash screen

              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("signIn", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.w),
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 8,
                  blurRadius: 20,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
