import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'music_player_events.dart';
part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final Artist artist;

  MusicPlayerBloc(this.artist) : super(MusicPlayerState.initialState());

  @override
  Stream<MusicPlayerState> mapEventToState(
    MusicPlayerEvent event,
  ) async* {
    if (event is OnNextTrackEvent) {
      final index = state.currentIndexTrack + 1;
      if (index < artist.tracks.length) {
        yield state.copyWith(currentIndexTrack: index);
      }
    } else if (event is OnPrevTrackEvent) {
      final index = state.currentIndexTrack - 1;
      if (index >= 0) {
        yield state.copyWith(currentIndexTrack: index);
      }
    }
  }

  static MusicPlayerBloc of(BuildContext context) {
    return BlocProvider.of<MusicPlayerBloc>(context);
  }
}
