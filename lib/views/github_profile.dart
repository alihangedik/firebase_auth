import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GithubWelcome extends StatefulWidget {
  const GithubWelcome({super.key});

  @override
  State<GithubWelcome> createState() => _GithubWelcomeState();
}

class _GithubWelcomeState extends State<GithubWelcome> {
  @override
  Widget build(BuildContext context) {
    final AdditionalUserInfo? githubUser =
        ModalRoute.of(context)?.settings.arguments as AdditionalUserInfo?;
    final user = githubUser!.profile!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOutGithub();
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
        centerTitle: true,
        title: Text(githubUser.providerId.toString()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      height: 100,
                      child: Image.network(
                        user['avatar_url'],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user['name'],
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(githubUser.username.toString()),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        user['company'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Biography\n',
            textAlign: TextAlign.center,
          ),
          Text(
            user['bio'],
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Followers'),
                    Text(
                      user['followers'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Following'),
                    Text(
                      user['following'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Public Gists'),
                    Text(
                      user['public_gists'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Public Repos'),
                    Text(
                      user['public_repos'].toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
