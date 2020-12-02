import 'dart:ui';

import 'package:capston2/goologin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//계정 정보
class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String _date=DateFormat("yyyy년 MM월 dd일").format(DateTime.now()).replaceAll(" ", "");
  List<Map<dynamic, dynamic>> lists = [];
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth=FirebaseAuth.instance;
  final dbref=FirebaseDatabase.instance.reference();
  FirebaseUser user;
  String _photo;
  getUserData() async{
    FirebaseUser userData=await FirebaseAuth.instance.currentUser();
    setState(() {
      user=userData;
      _photo=user.photoUrl.toString();
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
        title: Text('마이페이지',style: TextStyle(color: Colors.black,fontSize: 20),),
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
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: 300,
                height: 350,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 0, left: 10, right: 10),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: (_photo==null)?null:NetworkImage(_photo),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 35),
                                child: Text(user.displayName+" 님",style: TextStyle(color: Colors.black,fontSize: 20),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(user.email,style: TextStyle(color: Colors.grey),),
                              ),
                              FutureBuilder(//오늘 할일 FutureBuilder
                                  future: dbref.child(user.displayName).child(_date).once(),
                                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {

                                    if (snapshot.hasData) {
                                      lists.clear();
                                      Map<dynamic, dynamic> values = snapshot.data.value;
                                      if(values !=null){
                                        values.forEach((key, values) {
                                          lists.add(values);
                                        });
                                      }else{
                                        return Container(child: Text('오늘 까지 해야하는 일 : 0',style: TextStyle(color: Colors.grey),),);
                                      }
                                      return Text("오늘 까지 해야하는 일 : "+lists.length.toString()+"개",style: TextStyle(color: Colors.grey),);
                                    }else return Container();
                                  }),
                            ],
                          ),
                        )
                      ],
                    )),
              ),

            ],
          ),
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