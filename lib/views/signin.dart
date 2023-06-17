import 'package:firebase_auth_app/services/auth_service.dart';
import 'package:firebase_auth_app/views/github_profile.dart';
import 'package:firebase_auth_app/views/welcome.dart';
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
      appBar: AppBar(title: Text('Firebase Auth'), centerTitle: true, actions: [
        TextButton(
          child: Text(
            'Exit',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ]),
      body: Center(
        child: Container(
          height: 250,
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AuthService().signInGoogle().then((value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WelcomePage(),
                            settings: RouteSettings(arguments: value),
                          )));
                    },
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1024px-Google_%22G%22_Logo.svg.png',
                      scale: 30,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AuthService().signInWithGitHub(context).then((value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GithubWelcome(),
                            settings: RouteSettings(arguments: value),
                          )));
                      ;
                    },
                    child: Image.network(
                      'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                      scale: 12,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
