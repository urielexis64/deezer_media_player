import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_media_player/blocs/music_player/music_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentTrackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = MusicPlayerBloc.of(context);
    return Container(child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final currentTrack = _bloc.artist.tracks[state.currentIndexTrack];
        print(state.currentIndexTrack);
        return Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: currentTrack.album!.coverBig!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(currentTrack.album!.title!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            Text(currentTrack.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("${state.currentIndexTrack + 1}/${_bloc.artist.tracks.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
            SizedBox(height: 15),
          ],
        );
      },
    ));
  }
}
