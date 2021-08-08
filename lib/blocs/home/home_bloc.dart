import 'package:bloc/bloc.dart';
import 'package:deezer_media_player/api/deezer_api.dart';
import 'package:deezer_media_player/blocs/home/home_events.dart';
import 'package:deezer_media_player/blocs/home/home_state.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    }
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
    await Future.delayed(Duration(seconds: 1));
    yield state.copyWith(status: HomeStatus.loading);

    final List<Artist>? artists = await DeezerAPI.instance.getArtists();

    if (artists != null) {
      yield state.copyWith(status: HomeStatus.selecting, artists: artists);
    } else {
      yield state.copyWith(status: HomeStatus.error);
    }
  }
}
