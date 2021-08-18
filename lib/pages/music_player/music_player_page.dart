import 'package:deezer_media_player/blocs/music_player/music_player_bloc.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:deezer_media_player/pages/music_player/current_track_view.dart';
import 'package:deezer_media_player/pages/music_player/music_controls.dart';
import 'package:deezer_media_player/pages/music_player/music_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicPlayerPage extends StatefulWidget {
  final Artist artist;

  const MusicPlayerPage({Key? key, required this.artist}) : super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late MusicPlayerBloc _musicBloc;

  @override
  void initState() {
    super.initState();
    _musicBloc = MusicPlayerBloc(widget.artist);
  }

  @override
  void dispose() {
    _musicBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _musicBloc,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              top: false,
              child: Column(
                children: [
                  CurrentTrackView(),
                  MusicControls(),
                  MusicPlayerProgress()
                ],
              )),
        ),
      ),
    );
  }
}
