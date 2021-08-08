import 'package:bloc/bloc.dart';
import 'package:deezer_media_player/api/deezer_api.dart';
import 'package:deezer_media_player/blocs/home/home_events.dart';
import 'package:deezer_media_player/blocs/home/home_state.dart';
import 'package:deezer_media_player/models/artist.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initialState) {
    add(OnCheckDbEvent());
  }

  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnCheckDbEvent) {
      yield* _mapCheckDb(event);
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
