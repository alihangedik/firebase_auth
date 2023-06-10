import 'package:firebase_auth_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final tfEmail = TextEditingController();
  final tfUsername = TextEditingController();
  final tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Firebase Auth'),
        trailing: TextButton(
          child: Text('Exit'),
          onPressed: () {},
        ),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoTextField(
                controller: tfEmail,
                placeholder: 'email',
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.alternate_email,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              CupertinoTextField(
                obscureText: true,
                controller: tfPassword,
                placeholder: 'password',
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.password,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              CupertinoButton.filled(
                child: Text('Sign In'),
                onPressed: () {
                  AuthService().signIn(
                    context: context,
                    email: tfEmail.text,
                    password: tfPassword.text,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
