import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/views/welcome.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(
      {required String email,
      required String username,
      required String password,
      context}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _register(email: email, username: username, password: password);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      log(e.message.toString());
    }
  }

  Future<void> signIn({required email, required password, context}) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    final navigator = Navigator.of(context);
    try {
      if (userCredential.user != null) {
        log('giriş başarılı');
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  Future<void> _register(
      {required String email,
      required String username,
      required String password}) async {
    await userCollection.doc().set({
      "email": email,
      "username": username,
      "password": password,
    });
  }

  Future<User?> signInGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = await firebaseAuth.signInWithCredential(credential);
    log(user.user!.email.toString());

    return user.user;
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? currentUser = await GoogleSignIn().currentUser;

    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  Future<AdditionalUserInfo?> signInWithGitHub() async {
    final result = await firebaseAuth.signInWithProvider(
      GithubAuthProvider(),
    );

    // log('hata');
    // // showDialog(
    // //   context: context,
    // //   builder: (context) => AlertDialog(
    // //     title: Text('Hata'),
    // //     content: Text('GitHub kimlik doğrulaması başarısız oldu.'),
    // //     actions: [
    // //       TextButton(
    // //         child: Text('Tamam'),
    // //         onPressed: () => Navigator.pop(context),
    // //       ),
    // //     ],
    // //   ),
    // // );
    log(result.additionalUserInfo.toString());
    return result.additionalUserInfo;
  }

  Future<void> signOutGithub() async {
    await FirebaseAuth.instance.signOut();
  }
}
