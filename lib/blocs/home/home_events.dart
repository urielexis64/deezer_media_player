abstract class HomeEvent {}

class OnCheckDbEvent extends HomeEvent {}

class OnLoadArtistsEvent extends HomeEvent {}

class OnSelectArtistEvent extends HomeEvent {}

class OnSearchEvent extends HomeEvent {
  final String searchText;

  OnSearchEvent(this.searchText);
}

class OnDownloadEvent extends HomeEvent {}

class OnSelectedEvent extends HomeEvent {
  final int artistId;

  OnSelectedEvent(this.artistId);
}
