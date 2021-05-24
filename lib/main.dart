import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'note_player.dart';

void main() => runApp(MyApp(4, 4));

class MyApp extends StatelessWidget {
  final int rowCount;
  final int columnCount;

  MyApp(this.rowCount, this.columnCount);

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

class AppBody extends StatefulWidget {
  final int rowCount;
  final int columnCount;
  final int noteCount;

  const AppBody({required this.rowCount, required this.columnCount, Key? key})
      : noteCount = rowCount * columnCount,
        super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState(rowCount, columnCount);
}

class _AppBodyState extends State<AppBody> {
  int lastX = -1;
  int lastY = -1;
  final NotePlayer notePlayer;

  _AppBodyState(rowCount, columnCount)
      : notePlayer = NotePlayer('audio/', rowCount * columnCount) {
    print("State created");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => handleTap(details, context),
      onPanUpdate: (DragUpdateDetails details) => handleTap(details, context),
      onPanEnd: (DragEndDetails details) => { lastX = -1, lastY = -1 },
      child: Column(
        children: _buildRows(),
      ),
    );
  }

  void handleTap(details, BuildContext context) {
    int x =
        (details.globalPosition.dx / (MediaQuery.of(context).size.width / 4))
            .floor();
    int y =
        (details.globalPosition.dy / (MediaQuery.of(context).size.height / 4))
            .floor();
    if (lastX != x || lastY != y)
      {
        lastX = x;
        lastY = y;
        notePlayer.playNote(y * 4 + x);
      }
  }

  List<Widget> _buildRows() {
    return List.generate(
        widget.rowCount, (y) => Expanded(child: Row(children: _buildTiles(y))));
  }

  List<Widget> _buildTiles(y) {
    return List.generate(widget.columnCount,
        (x) => NoteTile(x: x, y: y, notePlayer: notePlayer));
  }
}

class NoteTile extends StatefulWidget {
  final int x;
  final int y;
  final NotePlayer notePlayer;

  const NoteTile(
      {Key? key, required this.x, required this.y, required this.notePlayer})
      : super(key: key);

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool isSoundOn = false;

  @override
  Widget build(BuildContext context) {
    int brightness = (((widget.x + widget.y + 1) / 7) * 255).round();
    return Expanded(
      child: Material(
        color: Color.fromRGBO(brightness, brightness, brightness, 1.0),
        child: InkWell(),
        // GestureDetector // onPanUpdate: (DragDownDetails details) => _playNote(y * 4 + x + 1)
      ),
    );
  }
}
