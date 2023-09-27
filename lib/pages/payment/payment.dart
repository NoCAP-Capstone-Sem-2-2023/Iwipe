import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:iwipe/pages/payment/bloc/payment_bloc.dart';
import 'package:iwipe/pages/payment/paymentController.dart';
import 'package:iwipe/pages/register/registerController.dart';
import 'package:http/http.dart' as http;

import '../commonWidget.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late PaymentController paymentController =
      PaymentController(context: context);

  @override
  void initState() {
    super.initState();
    paymentController = PaymentController(context: context);
  }

  @override
  Widget build(BuildContext context) {
    // Return BlocBuilder RegisterBloc, RegisterState
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      return Container(
        color: const Color.fromRGBO(241, 241, 241, 1),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromRGBO(241, 241, 241, 1),
            appBar: buildAppBar("Payment"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: buildSecondaryButtonWithSize(
                          "Apply for Government Asistance", 12, true, () {
                        RegisterController(context: context)
                            .passingValueToSetup();
                      })),
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: buildButton("Make Payment by Card", true, () {
                        paymentController.makeCardPayment();
                      })),
                  Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: buildButton("Make Payment by Paypal", true, () {
                        paymentController.makePaypalPayment();
                      })),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
