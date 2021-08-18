import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

enum MusicPlayerStatus { loading, error, playing, paused }

class MusicPlayer {
  MusicPlayer() {
    _init();
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    final player = await _completer.future;
    await player.closeAudioSession();
  }

  Completer<FlutterSoundPlayer> _completer = Completer();
  ValueNotifier<MusicPlayerStatus> _status =
      ValueNotifier(MusicPlayerStatus.loading);

  Duration? _duration;
  StreamSubscription? _subscription;
  Duration? get duration => _duration;

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
    _status.value = MusicPlayerStatus.loading;
    _duration = null;
    await _subscription?.cancel();
    final player = await _completer.future;
    await player.startPlayer(fromURI: uri);

    player.setSubscriptionDuration(Duration(seconds: 1));
    _subscription = player.onProgress?.listen((event) {
      if (_duration == null && event.duration.inSeconds > 0) {
        _duration = event.duration;
        _status.value = MusicPlayerStatus.playing;
      }
    });
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
