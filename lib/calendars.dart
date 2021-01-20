import 'dart:ui';

import 'package:capston2/memoboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class MyCalendars extends StatefulWidget {
  @override
  _MyCalendarsState createState() => _MyCalendarsState();
}

class _MyCalendarsState extends State<MyCalendars>
    with TickerProviderStateMixin {
  final dbref = FirebaseDatabase.instance.reference();
  String countSch = '';
  List<Map<dynamic, dynamic>> lists = [];
  final Map<DateTime, List> _holidays = {
    DateTime(2021, 1, 1): ['New Year\'s Day'],
  };
  String dateFormat =
      DateFormat("yyyy년 M월 d일").format(DateTime.now()).replaceAll(" ", "");
  String monthDay = "";
  String yearDay = "";
  String dayDay = "";
  Map<DateTime, List<dynamic>> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  FirebaseUser user;
  String hal = "과제";

  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    getUserData();

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();

    super.dispose();
  }

  _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected' + '$day');
    setState(() {
      //_selectedEvents = events;
      dateFormat = day.year.toString() +
          '년' +
          day.month.toString() +
          '월' +
          day.day.toString() +
          '일';
      monthDay = day.month.toString();
      yearDay = day.year.toString();
      dayDay = day.day.toString();
    });
    return [monthDay, yearDay, dayDay, dateFormat];
  }

  void _onVisibleDaysChanged(
      DateTime month, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');

    setState(() {});
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '이번달 스케줄 수',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 6.0, color: Colors.red)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '과제',
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 6.0, color: Colors.blue)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '약속',
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 6.0, color: Colors.teal)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '기타',
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          ),
          _buildTableCalendar(),
          Expanded(child: dateSelect()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'ko_KO',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget dateSelect() {
    return FutureBuilder(
        future: dbref
            .child(user.displayName)
            .child(yearDay + "년")
            .child(monthDay + "월")
            .child(dateFormat)
            .once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            lists.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            if (values != null) {
              values.forEach((key, values) {
                lists.add(values);
              });
            } else {
              return Text(
                '메모를 추가해주세요!',
                style: TextStyle(color: Colors.red),
              );
            }
            return Container(
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  color: Color(0xff30384c)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        dateFormat,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                textColor(index, values),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          } else {
            return Text(
              '로딩중',
              style: TextStyle(fontSize: 25),
            );
          }
        });
  }

  Widget textColor(int index, Map<dynamic, dynamic> values) {
    if (lists[index]["할일"] == '과제') {
      return Row(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: Colors.red,
            size: 27,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(lists[index]["메모"],
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(color: Colors.red)),
          ),
          iconsButton(values, index)
        ],
      );
    } else if (lists[index]["할일"] == '약속') {
      return Row(
        children: [
          Icon(
            Icons.access_alarm,
            color: Colors.blue,
            size: 27,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
              child: Text(lists[index]["메모"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(color: Colors.blue))),
          iconsButton(values, index)
        ],
      );
    } else {
      return Row(
        children: [
          Icon(
            Icons.add_alert,
            color: Colors.teal,
            size: 27,
          ),
          SizedBox(
            width: 8,
          ),
          Flexible(
              child: Text(lists[index]["메모"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(color: Colors.teal))),
          iconsButton(values, index)
        ],
      );
    }
  }

  Widget iconsButton(Map<dynamic, dynamic> values, int index) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        size: 25,
        color: Colors.white,
      ),
      onPressed: () {
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
              onPressed: () => Navigator.pop(context, false),
              color: Colors.teal,
            ),
            DialogButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  dbref
                      .child(user.displayName)
                      .child(yearDay + "년")
                      .child(monthDay + "월")
                      .child(dateFormat)
                      .child(values.keys.elementAt(index).toString())
                      .remove()
                      .then((_) {
                    Navigator.pop(context, true);
                  });
                });
              },
              color: Colors.teal,
            )
          ],
        ).show();
      },
    );
  }
}
