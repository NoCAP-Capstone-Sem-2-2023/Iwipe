import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwipe/pages/signIn/bloc/sign_in_bloc.dart';
import 'package:iwipe/pages/signIn/signInController.dart';

import '../commonWidget.dart';
import 'bloc/sign_in_event.dart';
import 'bloc/sign_in_state.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Stack(
        children: [
          Container(
            color: const Color.fromRGBO(241, 241, 241, 1),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Color.fromRGBO(241, 241, 241, 1),
                appBar: buildAppBar("Log In"),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildThirdPartyLogin(context),
                      Center(
                          child: reusableText(
                              "Or use your email address to Login")),
                      Container(
                          margin: EdgeInsets.only(top: 20.h),
                          padding: EdgeInsets.only(left: 25.w, right: 25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableText("Email Address"),
                              buildTextField(
                                  "Enter Email Address", "email", "user",
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(SignInEmailChanged(value));
                              }),
                              reusableText("Password"),
                              buildTextField(
                                  "Enter Your Password", "password", "lock",
                                  (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(SignInPasswordChanged(value));
                              }),
                            ],
                          )),
                      forgotPassword(),
                      buildButton(
                        "Log In",
                        true,
                        () {
                          SignInController(context: context)
                              .handleSignIn("email", (bool value) {
                            setState(() {
                              isLoading = value;
                            });
                          });
                        },
                      ),
                      buildButton("Register", false, () {
                        Navigator.of(context).pushNamed("/register");
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading ? buildLoadingIndicator() : Container(),
        ],
      );
    });
  }
}
