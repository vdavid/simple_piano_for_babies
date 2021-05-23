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
        body: InkWell(
          onTap: () {
            print("Container clicked");
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.yellow,
            child: CustomPaint(painter: FaceOutlinePainter()),
          ),
        ),
      ),
    );
  }

  void turnOffNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (int y = 0; y < size.height; y++) {
      for (int x = 0; x < size.width; x++) {
        int brightness = (((x + y + 1) / 7) * 255).round();
        Color color = Color.fromRGBO(brightness, brightness, brightness, 1.0);
        final paint = Paint()
          ..style = PaintingStyle.fill
          ..strokeWidth = 0.0
          ..color = color;
        canvas.drawRect(
          Rect.fromLTWH(x * size.width / 4, y * size.height / 4, size.width / 4,
              size.height / 4),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
