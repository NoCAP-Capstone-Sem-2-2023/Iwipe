import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/profile/profileWidgets.dart';

import '../../global.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
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
      linkAvt = userProfile?['avatar'];
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          profileDisplayAndEdit(linkAvt),
          Padding(
            padding: EdgeInsets.only(top:15.h ,left: 25.w),
            child: profileFeatures(context),
          ),
        ]),
      )),
    );
  }
}
