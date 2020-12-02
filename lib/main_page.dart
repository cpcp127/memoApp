import 'dart:ui';

import 'package:capston2/accout_page.dart';
import 'package:capston2/memoboard.dart';
import 'file:///C:/Users/cpcp1/FlutterProjects/capston2/lib/schedule_list/schedule.dart';
import 'package:capston2/schedule_main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  int _selectedIndex=0;

  List _pages=[MyMemo(),MyAccount(),MainSchedule()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child:_pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
       // backgroundColor: Color(0xccff9a9e),
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pinkAccent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add_circle),title: Text('메모하기',style: TextStyle(fontSize: 13),)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('마이페이지',style: TextStyle(fontSize: 13))),
            BottomNavigationBarItem(icon: Icon(Icons.event),title: Text('메모지',style: TextStyle(fontSize: 13)))
          ]),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }
  handleLoginOutPopup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Login Out",
      desc: "Do you want to login out now?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            handleSignOut();


          },
          color: Colors.teal,
        )
      ],
    ).show();
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });


    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });


    SystemNavigator.pop();

  }
}
