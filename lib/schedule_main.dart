
import 'dart:ui';

import 'package:capston2/goologin.dart';
import 'package:capston2/schedule_list/schedule.dart';
import 'package:capston2/schedule_list/schedule1.dart';

import 'package:capston2/schedule_list/schedule2.dart';
import 'package:capston2/schedule_list/schedule3.dart';
import 'package:capston2/schedule_list/schedule4.dart';
import 'package:capston2/schedule_list/schedule5.dart';
import 'package:capston2/schedule_list/schedule6.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MainSchedule extends StatefulWidget {
  @override
  _MainScheduleState createState() => _MainScheduleState();
}

class _MainScheduleState extends State<MainSchedule> {
  String _date=DateFormat("MM월 dd일").format(DateTime.now()).replaceAll(" ", "");
  String _date1=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 1))).replaceAll(" ", "");
  String _date2=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 2))).replaceAll(" ", "");
  String _date3=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 3))).replaceAll(" ", "");
  String _date4=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 4))).replaceAll(" ", "");
  String _date5=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 5))).replaceAll(" ", "");
  String _date6=DateFormat("MM월 dd일").format(DateTime.now().add(Duration(days: 6))).replaceAll(" ", "");

  final dbref=FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> lists = [];
  FirebaseUser user;
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  getUserData() async{
    FirebaseUser userData=await FirebaseAuth.instance.currentUser();
    setState(() {
      user=userData;

    });
  }


  @override
  void initState() {
    super.initState();
    getUserData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 목록',style: TextStyle(color: Colors.black,fontSize: 20),),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.vpn_key,color: Colors.black,), onPressed: handleLoginOutPopup),
      ),
     body: Container(
       decoration: BoxDecoration(
           color: Color(0x33E2E2E2)
       ),
       child: Column(
         children: <Widget>[
           Container(
             height: 30,
           ),
           Text("오늘",style: TextStyle(fontSize: 25),),
              Container(
                width: 150,
                height: 50,
                child: RaisedButton(
                  color: Color(0x33808080),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15),

                 ),
                 onPressed: (){
                   Navigator.of(context).push(
                       new MaterialPageRoute(builder: (context) => new MySchedule()));
                 },
                  child: Text(_date,style: TextStyle(color: Colors.white,fontSize: 20),),

             ),
              ),
           Container(
             height: 30,
           ),
           Text("일주일",style: TextStyle(fontSize: 25),),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule1()));
                   },
                   child: Text(_date1,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),
               Container(
                 width: 15,
               ),
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule2()));
                   },
                   child: Text(_date2,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),

             ],
           ),
           Container(
             height: 30,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule3()));
                   },
                   child: Text(_date3,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),
               Container(
                 width: 15,
               ),
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule4()));
                   },
                   child: Text(_date4,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),
             ],
           ),
           Container(
             height: 30,
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule5()));
                   },
                   child: Text(_date5,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),
               Container(
                 width: 15,
               ),
               Container(
                 width: 150,
                 height: 50,
                 child: RaisedButton(
                   color: Color(0x33808080),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),

                   ),
                   onPressed: (){
                     Navigator.of(context).push(
                         new MaterialPageRoute(builder: (context) => new MySchedule6()));
                   },
                   child: Text(_date6,style: TextStyle(color: Colors.white,fontSize: 20),),

                 ),
               ),
             ],
           ),
         ],
       ),
     ),
    );
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


    //SystemNavigator.pop();
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new Mygoogle()));
  }
}
