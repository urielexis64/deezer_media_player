import 'package:deezer_media_player/blocs/home/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
      if (state.status != HomeStatus.selecting) return SizedBox();

      final selectedArtists =
          state.artists.where((artist) => artist.selected).toList();
      return Container(
        color: Colors.black38,
        padding: EdgeInsets.all(10),
        child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  'Select at least 5 artists',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                CupertinoButton(
                  child: Text('NEXT'),
                  onPressed: selectedArtists.length >= 5
                      ? () => bloc.add(OnDownloadEvent(selectedArtists))
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  color: Colors.blueGrey,
                )
              ],
            )),
      );
    });
  }
}
