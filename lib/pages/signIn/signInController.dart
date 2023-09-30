import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iwipe/common/values/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../global.dart';
import 'bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type, Function setLoading) async {
    try {
      if (type == 'email') {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your email address')),
          );
          return;
        }
        if (password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter your password')),
          );
          return;
        }
        setLoading(true);
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);

          var user = credential.user;
          if (user != null) {
            // sign in successful
            await storeUserDataFromFirestore(user.uid);
            await storeUserID();
            setLoading(false);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/app', (route) => false);
          } else {
            setLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign in failed')),
            );
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            // user not found
          } else if (e.code == 'wrong-password') {
            // wrong password
            print('wrong password');
          } else if (e.code == 'invalid-email') {
            // invalid email
            print('invalid email');
          } else if (e.code == 'user-disabled') {
            // user disabled
            print('user disabled');
          } else {}
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

Future<void> storeUserDataFromFirestore(String userId) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot doc = await users.doc(userId).get();
  if (doc.exists) {
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    await Global.storageService
        .setString(AppConstant.STORAGE_USER_PROFILE, jsonEncode(userData));
  }
}

Future<void> storeUserID() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    String userId = currentUser.uid;
    await Global.storageService.setString(AppConstant.STORAGE_USER_ID, userId);
  } else {
    print("No current user found.");
  }
}
