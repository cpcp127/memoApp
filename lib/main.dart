import 'package:capston2/goologin.dart';
import 'package:capston2/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final routes={
  '/': (BuildContext context)=> Mygoogle(),
  '/first':(BuildContext context)=>MainPage()
};
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [ const Locale('en', 'US'), const Locale('ko', 'KO'), ],
      theme: ThemeData(
        fontFamily: 'BMDOHYEON',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Mygoogle(title: 'memo'),
    );
  }
}

