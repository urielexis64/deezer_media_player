import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_media_player/blocs/home/home_bloc.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        final List<Artist> artists = state.artists
            .where((artist) => artist.name!
                .toLowerCase()
                .contains(state.searchText.toLowerCase()))
            .toList();
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
                      child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      bloc.add(OnSelectedEvent(artist.id!));
                    },
                    child: ClipOval(
                        child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: artist.picture!,
                          placeholder: (_, __) => CupertinoActivityIndicator(),
                        ),
                        Positioned.fill(
                            child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          color: artist.selected
                              ? Colors.black26
                              : Colors.transparent,
                          child: Icon(
                            Icons.check_circle,
                            color: artist.selected
                                ? Colors.white
                                : Colors.transparent,
                          ),
                        ))
                      ],
                    )),
                  )),
                  Text(
                    artist.name!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
