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

  Future<void> handleEmailReg(
      String username,
      String email,
      String password,
      String? selectedImagePath,
      Function setLoading,
      Function isMounted) async {
    // Show loading indicator
    if (isMounted()) {
      setLoading(true);
    }
    final state = context.read<SetupProfileBloc>().state;

    String firstName = state.firstName;
    String lastName = state.lastName;
    String avt = state.avt;

    String? userId;

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

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        userId = credential.user!.uid;
        await credential.user!.updateDisplayName(username);
        await credential.user!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please check your email to verify your account')),
        );
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

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(userId).set({
        'avatar': downloadURL,
        'username': username,
        'email': email,
        'firstName': state.firstName,
        'lastName': state.lastName,
        'type': 'Email',
        'openId': 'None',
        'IDValidation': "",
        'paymentStatus': 'Not Paid',
        'moodleID': "",
        'password': password,
      });
    } catch (e) {
      print("Failed to add user to Firestore: $e");
// Handle the error
    }

    // Hide loading indicator
    if (isMounted()) {
      setLoading(false);
    }
    //reset route to home screen
    if (Navigator.canPop(context)) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}
