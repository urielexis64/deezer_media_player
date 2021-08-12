import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_media_player/blocs/home/bloc.dart';
import 'package:deezer_media_player/db/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyArtists extends StatelessWidget {
  const MyArtists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        final artists = state.artists;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              final currentArtist = artists[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyAppTheme.instance.darkEnabled
                          ? Color(0xff102027)
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: MyAppTheme.instance.darkEnabled
                                ? Colors.white.withOpacity(.03)
                                : Colors.black12,
                            offset: Offset(0, 2))
                      ],
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: currentArtist.picture!,
                                  width: 70,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      currentArtist.name!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: MyAppTheme.instance.darkEnabled
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${currentArtist.tracks.length} tracks",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            child: Icon(Icons.play_arrow),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: state.artists.length,
          ),
        );
      },
    );
  }
}
