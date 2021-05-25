import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final int x;
  final int y;
  final bool isActive;

  const NoteTile(
      {Key? key,
      required this.x,
      required this.y,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int brightness = (((x + y + 1) / 7) * 255).round();
    return Expanded(
      child: Material(
        color: Color.fromRGBO(brightness, brightness, brightness, 1.0),
        child: InkWell(),
        // GestureDetector // onPanUpdate: (DragDownDetails details) => _playNote(y * 4 + x + 1)
      ),
    );
  }
}
