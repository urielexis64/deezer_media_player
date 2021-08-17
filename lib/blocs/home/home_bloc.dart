import 'package:bloc/bloc.dart';
import 'package:deezer_media_player/api/deezer_api.dart';
import 'package:deezer_media_player/db/artist_store.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:deezer_media_player/models/track.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initialState) {
    add(OnCheckDbEvent());
  }

  HomeState get initialState => HomeState.initialState;

  static HomeBloc of(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnCheckDbEvent) {
      yield* _mapCheckDb(event);
    } else if (event is OnSearchEvent) {
      yield state.copyWith(searchText: event.searchText);
    } else if (event is OnSelectedEvent) {
      yield* _mapOnSelected(event);
    } else if (event is OnDownloadEvent) {
      yield* _mapOnDownloadTracks(event);
    }
  }

  Stream<HomeState> _mapOnDownloadTracks(OnDownloadEvent event) async* {
    yield state.copyWith(status: HomeStatus.downloading);

    List<Artist> artists = [];

    for (final artist in event.artists) {
      final List<Track> tracks = await DeezerAPI.instance.getTracks(artist.id!);
      artists.add(artist.addTracks(tracks));
    }

    await ArtistsStore.instance.addAll(artists);
    yield state.copyWith(status: HomeStatus.ready, artists: artists);
  }

  Stream<HomeState> _mapOnSelected(OnSelectedEvent event) async* {
    final id = event.artistId;
    final List<Artist> tmp = List<Artist>.from(state.artists);
    final int index = tmp.indexWhere((element) => element.id == id);
    if (index != -1) {
      tmp[index] = tmp[index].onSelected();
      yield state.copyWith(artists: tmp);
    }
  }

  Stream<HomeState> _mapCheckDb(OnCheckDbEvent event) async* {
    final List<Artist> artists = await ArtistsStore.instance.find();

    if (artists.length >= 5) {
      yield state.copyWith(status: HomeStatus.ready, artists: artists);
    } else {
      yield state.copyWith(status: HomeStatus.loading);

      final List<Artist>? artists = await DeezerAPI.instance.getArtists();

      if (artists != null) {
        yield state.copyWith(status: HomeStatus.selecting, artists: artists);
      } else {
        yield state.copyWith(status: HomeStatus.error);
      }
    }
  }
}
