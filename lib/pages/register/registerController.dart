import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../setUpProfile/setUpProfile.dart';
import 'bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;

  const RegisterController({required this.context});

  Future<void> passingValueToSetup() async {
    final state = context.read<RegisterBloc>().state;
    String username = state.username;
    String email = state.email;
    String password = state.password;
    String confirmPassword = state.confirmPassword;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your username')),
      );
      return;
    }
    final users = FirebaseFirestore.instance.collection('users');
    final querySnapshotUserName =
        await users.where('username', isEqualTo: username).get();
    if (querySnapshotUserName.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username already taken')),
      );
      return;
    }
    final querySnapshotEmail =
        await users.where('email', isEqualTo: email).get();
    if (querySnapshotEmail.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email already taken')),
      );
      return;
    }
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    } else {
      // Email validation
      final emailRegEx = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegEx.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email format')),
        );
        return;
      }
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    } else {
      if (password.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password too short')),
        );
        return;
      }

      // Regular expression to enforce password policy
      Pattern pattern =
          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=*-_]).+$';
      RegExp regex = new RegExp(pattern as String);

      if (!regex.hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password must have at least 1 digit, 1 lower case letter, 1 upper case letter, and 1 special character like *, -, or #',
            ),
          ),
        );
        return;
      }
    }

    if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your confirm password')),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password and confirm password not match')),
      );
      return;
    }

    try {
      //passing thoose data to SettingUpProfile
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetUpProfile(),
          settings: RouteSettings(
            arguments: {
              'username': username,
              'email': email,
              'password': password,
              'confirmPassword': confirmPassword,
            },
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
