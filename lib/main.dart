import 'package:firebase_auth_app/services/auth_service.dart';
import 'package:firebase_auth_app/views/signin.dart';
import 'package:firebase_auth_app/views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final tfEmail = TextEditingController();
  final tfUsername = TextEditingController();
  final tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Auth'), centerTitle: true, actions: [
        TextButton(
          child: Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ));
          },
        ),
      ]),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoTextField(
                controller: tfEmail,
                placeholder: 'email',
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.alternate_email_rounded,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              CupertinoTextField(
                controller: tfUsername,
                placeholder: 'username',
                prefix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.account_circle,
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
                child: Text('Create Account'),
                onPressed: () {
                  AuthService().signUp(
                    email: tfEmail.text,
                    username: tfUsername.text,
                    password: tfPassword.text,
                    context: context,
                  );

                  //  tfPassword.clear();
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
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // onTap: () {
                    //   AuthService().signInGoogle().then((value) =>
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => WelcomePage(),
                    //         settings: RouteSettings(arguments: value),
                    //       )));
                    // },
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png',
                      scale: 60,
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
