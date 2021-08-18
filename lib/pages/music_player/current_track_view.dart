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
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 17,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ClipPath(
                  clipper: AlbumClipper(),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: currentTrack.album!.coverBig!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(currentTrack.album!.title!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            Text(currentTrack.title!,
                textAlign: TextAlign.center,
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

class AlbumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.circular(size.width * 1.75));

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
