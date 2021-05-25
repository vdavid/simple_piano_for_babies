import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';

class NotePlayer {
  final String assetPrefix;
  final int noteCount;
  final AudioCache audioCache = AudioCache();
  List<Uint8List>? fileCache;

  NotePlayer(this.assetPrefix, this.noteCount);

  playNote(int index) async {
    if (fileCache == null) {
      await _initializeAudioCache();
    }
    audioCache.playBytes(fileCache![index]);
  }

  _initializeAudioCache() async {
    var listOfIndexes = new List<int>.generate(noteCount, (index) => index + 1);
    Iterable<Future<Uint8List>> fileContentFutures = listOfIndexes.map(
        (index) async => (await audioCache.loadAsFile('$assetPrefix$index.mp3'))
            .readAsBytes());
    fileCache = await Future.wait(fileContentFutures);
  }
}
