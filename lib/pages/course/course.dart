import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/values/colors.dart';
import '../../global.dart';
import 'courseWidget.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  WebViewController? _webViewController;
  String? username;
  String? password;
  String? paymentStatus;
  bool isLoading = true;

  _loadUser() async {
    Map<String, dynamic>? userProfile = Global.storageService.getUserProfile();
    setState(() {
      username = userProfile?['username'];
      password = userProfile?['password'];
      paymentStatus = userProfile?['paymentStatus'];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Course",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText)),
        centerTitle: true,
      ),
      body: paymentStatus == "Paid"
          ? Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      WebView(
                        initialUrl: 'https://quocchic.net/course/view.php?id=3',
                        // Replace with your Moodle site URL
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _webViewController = webViewController;
                        },
                        onPageFinished: (String url) {
                          setState(() {
                            isLoading = false;
                          });
                          if (url == 'https://quocchic.net/login/index.php') {
                            // Replace with your Moodle login URL
                            _webViewController?.evaluateJavascript('''
              document.getElementById("username").value = "$username";
              document.getElementById("password").value = "$password";
              document.getElementById("loginbtn").click();
              ''');
                          }
                        },
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    "You have not made a payment yet. \n\n"
                    "Please return to home page and make a payment to access the course.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
