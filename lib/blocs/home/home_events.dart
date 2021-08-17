part of 'home_bloc.dart';

abstract class HomeEvent {}

class OnCheckDbEvent extends HomeEvent {}

class OnLoadArtistsEvent extends HomeEvent {}

class OnSelectArtistEvent extends HomeEvent {}

class OnSearchEvent extends HomeEvent {
  final String searchText;

  OnSearchEvent(this.searchText);
}

class OnDownloadEvent extends HomeEvent {
  List<Artist> artists;
  OnDownloadEvent(this.artists);
}

class OnSelectedEvent extends HomeEvent {
  final int artistId;

  OnSelectedEvent(this.artistId);
}
