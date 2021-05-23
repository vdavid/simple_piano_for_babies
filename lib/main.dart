// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final int _rowCount = 4;
  final int _columnCount = 4;

  @override
  Widget build(BuildContext context) {
    turnOffNavigationBar();

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Column(
          children: _buildRows(),
        ),
      ),
    );
  }

  List<Widget> _buildRows() {
    return List.generate(
        _rowCount, (y) => Expanded(child: Row(children: _buildTiles(y))));
  }

  List<Widget> _buildTiles(y) {
    return List.generate(_columnCount, (x) => _buildTile(x, y));
  }

  Widget _buildTile(int x, int y) {
    int brightness = (((x + y + 1) / 7) * 255).round();
    return Expanded(
      child: Material(
        color: Color.fromRGBO(brightness, brightness, brightness, 1.0),
        child: InkWell(
          onTap: () {
            print("$x $y Container clicked");
          },
        ),
      ),
    );
  }

  void turnOffNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
