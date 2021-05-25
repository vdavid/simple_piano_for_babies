import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'app_body.dart';

class App extends StatelessWidget {
  final int rowCount;
  final int columnCount;

  App(this.rowCount, this.columnCount);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    turnOffNavigationBar();

    return MaterialApp(
      home: Scaffold(
        body: AppBody(rowCount: rowCount, columnCount: columnCount),
      ),
    );
  }

  void turnOffNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}