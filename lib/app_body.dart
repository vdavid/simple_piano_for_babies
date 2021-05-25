import 'package:flutter/material.dart';
import 'note_player.dart';
import 'note_tile.dart';

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
  List<NoteTile> tiles = List.empty();
  List<bool>? tileActiveStates;

  _AppBodyState(rowCount, columnCount)
      : notePlayer = NotePlayer('audio/', rowCount * columnCount) {
    print("State created");
  }


  @override
  void initState() {
    super.initState();
    tileActiveStates = List<bool>.generate(widget.noteCount, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    tiles = _buildTiles();
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        print("Tap down");
        handleTap(details, context);
      },
      onPanUpdate: (DragUpdateDetails details) {
        print("Pan update");
        handleTap(details, context);
      },
      onPanEnd: (DragEndDetails details)
      {
        lastX = -1;
        lastY = -1;
        tileActiveStates!.asMap().forEach((key, value) { _setActive(key, false); });
      },
      onTapUp: (TapUpDetails details) {
        lastX = -1;
        lastY = -1;
        tileActiveStates!.asMap().forEach((key, value) { _setActive(key, false); });
      },
      child: Column(
        children: List.generate(widget.rowCount, (y) {
          return Expanded(
              child: Row(
                  children: tiles.sublist(
                      y * widget.columnCount, y * widget.columnCount + widget.columnCount)));
        }),
      ),
    );
  }

  void handleTap(details, BuildContext context) {
    int index = getIndexByTapDetails(details, context);
    int x = index % widget.columnCount;
    int y = (index / widget.columnCount).floor();
    if (lastX != x || lastY != y) {
      lastX = x;
      lastY = y;
      notePlayer.playNote(index);
      _setActive(index, true);
    }
  }

  int getIndexByTapDetails(details, BuildContext context) {
    int x =
    (details.globalPosition.dx / (MediaQuery.of(context).size.width / widget.columnCount))
        .floor();
    int y =
    (details.globalPosition.dy / (MediaQuery.of(context).size.height / widget.columnCount))
        .floor();
    return y * 4 + x;
  }

  _setActive(index, value) {
    setState(() => {
      tileActiveStates![index] = value
    });
  }

  List<NoteTile> _buildTiles() {
    return List.generate(
        widget.noteCount,
        (index) => NoteTile(
            x: index % widget.columnCount,
            y: (index / widget.columnCount).floor(),
            isActive: tileActiveStates![index]));
  }
}
