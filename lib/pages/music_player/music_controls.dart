import 'package:deezer_media_player/blocs/music_player/music_player_bloc.dart';
import 'package:deezer_media_player/libs/music_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = MusicPlayerBloc.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
            padding: EdgeInsets.all(6),
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(40),
            child: Icon(Icons.skip_previous, size: 25, color: Colors.black87),
            onPressed: () {
              _bloc.add(OnPrevTrackEvent());
            }),
        SizedBox(width: 15),
        ValueListenableBuilder<MusicPlayerStatus>(
            valueListenable: _bloc.musicPlayer.status,
            builder: (_, value, __) {
              if (_bloc.musicPlayer.loading) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: CupertinoActivityIndicator(
                    radius: 16,
                  ),
                );
              }
              if (_bloc.musicPlayer.error) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.error,
                    size: 40,
                    color: Colors.redAccent,
                  ),
                );
              }
              return CupertinoButton(
                  padding: EdgeInsets.all(6),
                  color: Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(40),
                  child: Icon(
                      _bloc.musicPlayer.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.black87),
                  onPressed: () {
                    if (_bloc.musicPlayer.playing) {
                      _bloc.musicPlayer.pause();
                    } else {
                      _bloc.musicPlayer.resume();
                    }
                  });
            }),
        SizedBox(width: 15),
        CupertinoButton(
            padding: EdgeInsets.all(6),
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(40),
            child: Icon(Icons.skip_next, size: 25, color: Colors.black87),
            onPressed: () {
              _bloc.add(OnNextTrackEvent());
            })
      ],
    );
  }
}
