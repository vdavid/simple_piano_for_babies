// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    turnOffNavigationBar();

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter!'),
        ),
        body: Center(
          child: Text('Hello DSKjkds World!!!'),
        ),
      ),
    );
  }

  void turnOffNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}