import 'dart:ui';

import 'package:capston2/accout_page.dart';
import 'package:capston2/bottom_navigation_provider.dart';
import 'package:capston2/calendars.dart';
import 'package:capston2/memoboard.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  BottomNavigationProvider _bottomNavigationProvider;
  Widget _navigationBody() {
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return MyMemo();
        break;
      case 1:
        return MyCalendars();
        break;
      case 2:
        return MyAccount();
        break;
    }
    return Container();
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text(
              '메모하기',
              style: TextStyle(fontSize: 13),
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('페이지', style: TextStyle(fontSize: 13))),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('마이페이지', style: TextStyle(fontSize: 13))),
      ],
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.red,
      onTap: (index) {
        //provider navigation state:
        //프로바이더로 네비게이션 상태 데이터 관리
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
