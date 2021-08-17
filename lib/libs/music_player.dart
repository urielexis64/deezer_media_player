import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

enum MusicPlayerStatus { loading, error, playing, paused }

class MusicPlayer {
  MusicPlayer() {
    _init();
  }

  Future<void> dispose() async {
    final player = await _completer.future;
    await player.closeAudioSession();
  }

  Completer<FlutterSoundPlayer> _completer = Completer();
  ValueNotifier<MusicPlayerStatus> _status =
      ValueNotifier(MusicPlayerStatus.loading);

  ValueNotifier<MusicPlayerStatus> get status => _status;

  bool get loading => _status.value == MusicPlayerStatus.loading;

  bool get playing => _status.value == MusicPlayerStatus.playing;

  bool get paused => _status.value == MusicPlayerStatus.paused;

  bool get error => _status.value == MusicPlayerStatus.error;

  Future<void> _init() async {
    final player = await FlutterSoundPlayer().openAudioSession();
    _completer.complete(player);
  }

  Future<void> play(String uri) async {
    final player = await _completer.future;
    await player.startPlayer(fromURI: uri);
    _status.value = MusicPlayerStatus.playing;
  }

  Future<void> resume() async {
    final player = await _completer.future;
    await player.resumePlayer();
    _status.value = MusicPlayerStatus.playing;
  }

  Future<void> pause() async {
    final player = await _completer.future;
    await player.pausePlayer();
    _status.value = MusicPlayerStatus.paused;
  }
}
