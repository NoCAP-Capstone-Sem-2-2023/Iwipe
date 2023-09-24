import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/register/registerController.dart';

import '../commonWidget.dart';
import '../setUpProfile/setUpProfile.dart';
import 'bloc/register_blocs.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    // Return BlocBuilder RegisterBloc, RegisterState
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Container(
        color: const Color.fromRGBO(241, 241, 241, 1),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            appBar: buildAppBar("Register"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 20.h),
                        child: reusableText("Enter details to create an account")),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Username"),
                          buildTextField("Enter Your Username", "username", "user", (value) {
                            context.read<RegisterBloc>().add(RegisterUsernameChanged(value));
                          }),
                          reusableText("Email"),
                          buildTextField("Enter Your Email Address", "email", "user", (value) {
                            context.read<RegisterBloc>().add(RegisterEmailChanged(value));
                          }),                          reusableText("Password"),
                          buildTextField("Enter Your Password", "password", "lock", (value) {
                            context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
                          }),                          reusableText("Password"),
                          buildTextField("Enter Your Confirm Password", "password", "lock", (value) {
                            context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(value));
                          }),
                        ],
                      )),
                  buildButton("Next",true, () {
                    RegisterController(context:context).passingValueToSetup();
                  })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
