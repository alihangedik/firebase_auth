import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            child: Image.network(
              user == null ? '' : user.photoURL.toString(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              user == null ? '' : user.displayName.toString(),
              style: TextStyle(fontSize: 27),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              'Giriş Başarılı\nHoşgeldin',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CupertinoButton.filled(
            child: Text('Sign Out'),
            onPressed: () {
              AuthService().signOut();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
