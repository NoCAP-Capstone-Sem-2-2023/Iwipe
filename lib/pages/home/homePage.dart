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
  String? IDValidation;
  String? paymentStatus;

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
      IDValidation = userProfile?['IDValidation'];
      paymentStatus = userProfile?['paymentStatus'];
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
            SizedBox(height: 30.h),
            // Check if user has validated ID
            IDValidation == "" || IDValidation == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You have not validated your ID yet.",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result =
                              await Navigator.pushNamed(context, '/idValidate');
                          if (result == true) {
                            _loadUser(); // Refresh user data if ID is validated.
                          }
                        },
                        child: Text("Validate ID"),
                      ),
                    ],
                  )
                : Container(),
            // Check if user has made a payment
            paymentStatus != "Paid"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You have not made a payment yet.",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryText,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/payment');
                        },
                        child: Text("Make Payment"),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
