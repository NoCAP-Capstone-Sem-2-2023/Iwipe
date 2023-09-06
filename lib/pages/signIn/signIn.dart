import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/signIn/widgets/signInWidget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromRGBO(241, 241, 241, 1),
          appBar: buildAppBar(),
        ),
      ),
    );
  }
}
