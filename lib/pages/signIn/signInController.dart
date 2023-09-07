import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == 'email') {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty) {
          print('email is empty');
        }
        if (password.isEmpty) {
          print('password is empty');
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if(credential.user == null){
            //
            print('user is null');
          }
          if(credential.user!.emailVerified){
            //
            print('email verified');
          }

          var user = credential.user;
          if (user != null) {
            // sign in successful
            print('sign in successful');
          }else{
            // sign in failed
          }

        }on FirebaseAuthException catch (e) {
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
          } else {
            // unknown error
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
