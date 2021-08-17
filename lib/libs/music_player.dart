import 'dart:async';
import 'package:flutter_sound_lite/flutter_sound.dart';

class MusicPlayer {
  MusicPlayer() {
    _init();
  }

  Future<void> dispose() async {
    final player = await _completer.future;
    await player.closeAudioSession();
  }

  Completer<FlutterSoundPlayer> _completer = Completer();

  Future<void> _init() async {
    final player = await FlutterSoundPlayer().openAudioSession();
    _completer.complete(player);
  }

  Future<void> play(String uri) async {
    final player = await _completer.future;

    await player.startPlayer(fromURI: uri);
  }
}
