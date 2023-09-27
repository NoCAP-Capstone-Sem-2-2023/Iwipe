import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../common/values/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../../global.dart';

class PaymentController {
  final BuildContext context;

  Map<String, dynamic>? paymentIntent;

  PaymentController({required this.context});

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
  void makeCardPayment() async {
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

      String? userID = Global.storageService.getUserID();
      print(userID);
      // Call createUserInMoodle after successful payment
      String? moodleID = await createUserInMoodle();

      if (moodleID != null) {
        // Update Firestore to set Moodle ID and paymentStatus to "Paid"
        CollectionReference users =
        FirebaseFirestore.instance.collection('users');
        await users.doc(userID).update({
          'paymentStatus': 'Paid',
          'moodleID': moodleID // Update Moodle ID here
        });

        // Fetch the latest user profile from Firestore
        DocumentSnapshot doc = await users.doc(userID).get();
        if (doc.exists) {
          Map<String, dynamic> updatedUserProfile =
          doc.data() as Map<String, dynamic>;

          // Update local storage
          await Global.storageService.setString(
              AppConstant.STORAGE_USER_PROFILE, jsonEncode(updatedUserProfile));
        }
      }

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/app', (Route<dynamic> route) => false);
    } catch (e) {
      print('Payment failed: $e');
    }
  }
  void makePaypalPayment() async {

  }
  Future<String?> createUserInMoodle() async {
    final String token = AppConstant.MasterAPITOKEN;
    final String domain = AppConstant.domain;
    final String functionName = "core_user_create_users";

    final String url = "$domain/webservice/rest/server.php";

    Map<String, dynamic>? userProfile = Global.storageService.getUserProfile();
    final String username = userProfile?['username'];
    final String password = userProfile?['password'];
    final String firstName = userProfile?['firstName'];
    final String lastName = userProfile?['lastName'];
    final String email = userProfile?['email'];

    final response = await http.post(Uri.parse(url), body: {
      'wstoken': token,
      'wsfunction': functionName,
      'moodlewsrestformat': 'json',
      'users[0][username]': username,
      'users[0][password]': password,
      'users[0][firstname]': firstName,
      'users[0][lastname]': lastName,
      'users[0][email]': email,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map && jsonResponse.containsKey('exception')) {
        print("Moodle exception: ${jsonResponse['message']}");
        return null;
      } else {
        print("User created in Moodle: $jsonResponse");
        return jsonResponse['id']
            .toString(); // Replace 'id' with the actual key for Moodle ID
      }
    } else {
      print("Failed to create user in Moodle: ${response.body}");
      return null;
    }
  }
}
