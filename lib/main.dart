import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'note_player.dart';

void main() => runApp(MyApp(4, 4));

class MyApp extends StatelessWidget {
  final int rowCount;
  final int columnCount;
  final int noteCount;
  final NotePlayer notePlayer;

  MyApp(this.rowCount, this.columnCount)
      : noteCount = rowCount * columnCount,
        notePlayer = NotePlayer('audio/', rowCount * columnCount);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    turnOffNavigationBar();

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: _buildRows(),
        ),
      ),
    );
  }

  List<Widget> _buildRows() {
    return List.generate(
        rowCount, (y) => Expanded(child: Row(children: _buildTiles(y))));
  }

  List<Widget> _buildTiles(y) {
    return List.generate(columnCount, (x) => _buildTile(x, y));
  }

  Widget _buildTile(int x, int y) {
    int brightness = (((x + y + 1) / 7) * 255).round();
    return Expanded(
      child: Material(
        color: Color.fromRGBO(brightness, brightness, brightness, 1.0),
        child: InkWell(onTap: () => notePlayer.playNote(y * 4 + x + 1)
            // GestureDetector // onPanUpdate: (DragDownDetails details) => _playNote(y * 4 + x + 1)
            ),
      ),
    );
  }

  void turnOffNavigationBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
