import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:iwipe/pages/payment/bloc/payment_bloc.dart';
import 'package:iwipe/pages/register/registerController.dart';
import 'package:http/http.dart' as http;

import '../commonWidget.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntent;

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "1000",
        "currency": "AUD",
      };

      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51Nub2XKUZVjktPnkJEsfHPO8RwL2znDq3Dc9pBlH4ZE8heKbA2sUi7jBnA3Wx6L489h6Aqa65LHAOGElVSYTHYrb00xckWkayn",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {}
  }

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();

      var gpay = PaymentSheetGooglePay(
        merchantCountryCode: "AU",
        currencyCode: "AUD",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: gpay,
          style: ThemeMode.dark,
          merchantDisplayName: "iWipe",
          paymentIntentClientSecret: paymentIntent!['client_secret'],
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Navigator.of(context).pushNamed('/app');
    } catch (e) {
      print('Payment failed: $e');
    }
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
                      child: buildButton("Make Payment", true, () {
                        print("Make Payment");
                        makePayment();
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
