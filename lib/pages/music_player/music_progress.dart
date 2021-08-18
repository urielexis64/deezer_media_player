import 'package:after_layout/after_layout.dart';
import 'package:deezer_media_player/blocs/music_player/music_player_bloc.dart';
import 'package:deezer_media_player/libs/music_player.dart';
import 'package:flutter/material.dart';

String formatTime(Duration? time) {
  if (time == null) return '--:--';

  final minutes = '${time.inMinutes.remainder(60)}'.padLeft(2, '0');
  final seconds = '${time.inSeconds.remainder(60)}'.padLeft(2, '0');
  return "$minutes:$seconds";
}

class MusicPlayerProgress extends StatefulWidget {
  @override
  _MusicPlayerProgressState createState() => _MusicPlayerProgressState();
}

class _MusicPlayerProgressState extends State<MusicPlayerProgress>
    with AfterLayoutMixin {
  ValueNotifier<double> _sliderValue = ValueNotifier<double>(0);
  late MusicPlayerBloc? _bloc;

  bool _dragging = false;

  @override
  void afterFirstLayout(BuildContext context) {
    _bloc = MusicPlayerBloc.of(context);
    _bloc!.musicPlayer.position.addListener(() {
      if (!_dragging) {
        _sliderValue.value =
            _bloc!.musicPlayer.position.value.inSeconds.toDouble();
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) return SizedBox();
    final musicPlayer = _bloc!.musicPlayer;
    return Padding(
      padding: EdgeInsets.all(15),
      child: ValueListenableBuilder<MusicPlayerStatus>(
        valueListenable: musicPlayer.status,
        builder: (_, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              child!,
              Expanded(
                child: ValueListenableBuilder<double>(
                    valueListenable: _sliderValue,
                    builder: (_, value, __) {
                      double max = 1.0;
                      final secondsDuration = Duration(seconds: value.toInt());

                      if (musicPlayer.duration != null) {
                        max = musicPlayer.duration!.inSeconds.toDouble();
                      }

                      return AbsorbPointer(
                        absorbing: musicPlayer.loading,
                        child: Slider(
                            value: value,
                            max: max,
                            label: '${formatTime(secondsDuration)}',
                            divisions: 100,
                            onChangeStart: (_) => _dragging = true,
                            onChangeEnd: (_) {
                              _dragging = false;
                              musicPlayer.seekTo(secondsDuration);
                            },
                            onChanged: (v) {
                              _sliderValue.value = v;
                            }),
                      );
                    }),
              ),
              Text(formatTime(musicPlayer.duration)),
            ],
          );
        },
        child: ValueListenableBuilder<Duration>(
            valueListenable: musicPlayer.position,
            builder: (_, value, __) {
              return Text(formatTime(value));
            }),
      ),
    );
  }
}
