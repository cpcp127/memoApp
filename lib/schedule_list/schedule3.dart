import 'dart:ui';
import 'package:capston2/schedule_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MySchedule3 extends StatefulWidget {
  @override
  _MySchedule3State createState() => _MySchedule3State();
}

class _MySchedule3State extends State<MySchedule3> {
  bool monVal=false;
  String _date3=DateFormat("yyyy년 MM월 d일").format(DateTime.now().add(Duration(days: 3))).replaceAll(" ", "");



  final FirebaseAuth auth=FirebaseAuth.instance;

  FirebaseUser user;

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

  final dbref=FirebaseDatabase.instance.reference();

  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('목록',style: TextStyle(color: Colors.black,fontSize: 20),),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_date3+"에 할일",style: TextStyle(fontSize: 30),),

              Container(
                height: 20,

              ),
              FutureBuilder(//오늘 할일 FutureBuilder
                  future: dbref.child(user.displayName).child(_date3).once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {

                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      if(values !=null){
                        values.forEach((key, values) {
                          lists.add(values);
                        });
                      }else{
                        return Container(child: Text('메모를 추가해주세요!'),);
                      }
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onLongPress: (){
                                Alert(
                                  context: context,
                                  type: AlertType.info,
                                  title: "삭제",
                                  desc: "해당 일정을 삭제하시겠습니까?",
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
                                        dbref.child(user.displayName).child(_date3).child(values.keys.elementAt(index).toString()).remove();
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(builder: (context) => new MainSchedule()));
                                      },
                                      color: Colors.teal,
                                    )
                                  ],
                                ).show();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),

                                child: Card(
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Text("분류: " + lists[index]["할일"]),
                                      Text("메모: " + lists[index]["메모"]),
                                      Text("날짜: " + lists[index]["날짜"]),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    else{
                      return CircularProgressIndicator();
                    }
                  }),

            ],
          ),
        ),
      )
    );
  }
  _fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'REMOTE DATA';
  }
}