
import 'dart:ui';

import 'package:capston2/main_page.dart';
import 'package:capston2/memoboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Mygoogle extends StatefulWidget {
  final String title;

  const Mygoogle({Key key, this.title}) : super(key: key);

  @override
  _MygoogleState createState() => _MygoogleState();
}

class _MygoogleState extends State<Mygoogle> {

  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  GoogleSignIn _googleSignIn=GoogleSignIn(
    scopes: <String>['email'],
  );

  GoogleSignInAccount _currentUser;


  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });

      if (_currentUser != null) {
        _handleFirebase();

      }
    });

    _googleSignIn.signInSilently(); //자동로그인
  }
  void _handleFirebase() async {
    GoogleSignInAuthentication googleAuth = await _currentUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser firebaseUser = await firebaseAuth.signInWithCredential(credential);

    if (firebaseUser != null) {
      print('Login');
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MainPage()));

    }
  }


  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.png"), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Text("매일 매일 잊지 말고",style: TextStyle(fontSize: 15,color: Colors.white),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("메모 해보세요.",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: _signInButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {

        _handleSignIn();

      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white,width: 1.8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Google 계정으로 로그인',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
