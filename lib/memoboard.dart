import 'dart:ui';

import 'package:capston2/goologin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class MyMemo extends StatefulWidget {
  @override
  _MyMemoState createState() => _MyMemoState();
}

class _MyMemoState extends State<MyMemo> with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;
  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  TextEditingController _eventController;
  String dropvalue;

  int _value = 1;
  bool isLoading = false;
  String _date =
      DateFormat("yyyy년 M월 d일").format(DateTime.now()).replaceAll(" ", "");
  String monthDate = DateFormat("M월").format(DateTime.now());
  String yearDate = DateFormat("yyyy년").format(DateTime.now());
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool value = false;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<void> _openDatePicker(BuildContext context) async {
    final DateTime d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2025));
    if (d != null) {
      setState(() {
        _date = new DateFormat.yMMMd("ko_KO").format(d).toString();
        monthDate = new DateFormat.M("ko_KO").format(d).toString();
        yearDate = new DateFormat.y("ko_KO").format(d).toString();
      });
    }
  }

  @override
  void initState() {
    _eventController = TextEditingController();
    super.initState();
    getUserData();
  }

  onUpdate() {
    setState(() {
      value = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '메모하기',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0x33E2E2E2)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '말 머리',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.white)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    "과제",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "약속",
                                style: TextStyle(color: Colors.grey),
                              ),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "기타",
                                style: TextStyle(color: Colors.grey),
                              ),
                              value: 3,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                              if (_value == 1) {
                                dropvalue = '과제';
                              } else if (_value == 2) {
                                dropvalue = '약속';
                              } else {
                                dropvalue = '기타';
                              }
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    '메모',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 20, right: 30),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.white)),
                    child: TextField(
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        border: InputBorder.none,
                      ),
                      controller: _eventController,
                      cursorColor: Theme.of(context).primaryColor,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    '날짜',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 180,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          Text(" "),
                          Text(
                            _date,
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      _openDatePicker(context);
                    },
                  ),
                ),
                Container(
                  height: 60,
                ),
                Center(
                  child: Container(
                    width: 180,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('저장', style: TextStyle(fontSize: 22)),
                      onPressed: () {
                        setState(() {
                          databaseReference
                              .child(user.displayName)
                              .child(yearDate)
                              .child(monthDate)
                              .child(_date.toString().replaceAll(" ", ""))
                              .push()
                              .set({
                            '할일': memoValue(),
                            '메모': _eventController.text,
                            '날짜': _date.toString().replaceAll(" ", "")
                          });
                        });
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(_date + " 일정 저장 완료")));
                      },
                      color: Color(0xfff8474f),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 135,
                ),
              ],
            ),
          ),
        ));
  }

  memoValue() {
    if (_value == 1) {
      dropvalue = '과제';
      return dropvalue;
    } else if (_value == 2) {
      dropvalue = '약속';
      return dropvalue;
    } else {
      dropvalue = '기타';
      return dropvalue;
    }
  }
}
