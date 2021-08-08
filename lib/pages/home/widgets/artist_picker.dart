import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_media_player/blocs/home/bloc.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        final artists = state.artists;
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 130,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20),
            delegate: SliverChildBuilderDelegate((_, i) {
              final Artist artist = artists[i];
              return Column(
                children: [
                  Expanded(
                      child: ClipOval(
                          child: CachedNetworkImage(
                    imageUrl: artist.picture!,
                    placeholder: (_, __) => CupertinoActivityIndicator(),
                  ))),
                  Text(
                    artist.name!,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }, childCount: artists.length),
          ),
        );
      },
    );
  }
}
