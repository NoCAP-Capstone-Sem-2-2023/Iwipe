import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../../common/values/constant.dart';
import '../../global.dart';
import 'bloc/setUpProfileBloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SetUpProfileController {
  final BuildContext context;

  const SetUpProfileController({required this.context});

  Future<void> handleEmailReg(String username, String email, String password,
      String? selectedImagePath) async {
    final state = context.read<SetupProfileBloc>().state;

    String firstName = state.firstName;
    String lastName = state.lastName;
    String avt = state.avt;

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your first name')),
      );
      return;
    }
    if (lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your last name')),
      );
      return;
    }

    //print all for debug
    print('username: $username');
    print('email: $email');
    print('password: $password');
    print('firstName: $firstName');
    print('lastName: $lastName');
    print('avt: $avt');

    String? downloadURL;
    if (selectedImagePath != null) {
      File file = File(selectedImagePath);
      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('avatars/$username')
            .putFile(file);

        downloadURL = await snapshot.ref.getDownloadURL();
      } catch (e) {
        print("Failed to upload image: $e");
      }
    }

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.add({
        'avatar': downloadURL,
        'username': username,
        'email': email,
        'firstName': state.firstName,
        'lastName': state.lastName,
        'type': 'Email',
        'openId': 'None',
      });

      // Store user data locally
      await storeUserData({
        'avatar': downloadURL,
        'username': username,
        'email': email,
        'firstName': state.firstName,
        'lastName': state.lastName,
        'type': 'Email',
        'openId': 'None',
      });
    } catch (e) {
      print("Failed to add user to Firestore: $e");
      // Handle the error
    }

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.updateDisplayName(username);
        await credential.user!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please check your email to verify your account')),
        );
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak')),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email')),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The email address is not valid')),
        );
      }
    }

    try {
      await createUserInMoodle(username, password, firstName, lastName, email);
    } catch (e) {
      print("Failed to create user in Moodle: $e");
    }

    //reset route to home screen
    Navigator.of(context).pop();
  }

  Future<void> createUserInMoodle(String username, String password,
      String firstName, String lastName, String email) async {
    final String token = AppConstant.MasterAPITOKEN;
    final String domain = AppConstant.domain;
    final String functionName = "core_user_create_users";

    final String url = "$domain/webservice/rest/server.php";

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
      if (jsonResponse.containsKey('exception')) {
        print("Moodle exception: ${jsonResponse['message']}");
      } else {
        print("User created in Moodle: $jsonResponse");
      }
    } else {
      print("Failed to create user in Moodle: ${response.body}");
    }
  }
}

Future<bool> storeUserData(Map<String, dynamic> userData) async {
  await Global.storageService
      .setString(AppConstant.STORAGE_USER_PROFILE, jsonEncode(userData));
  return true;
}
