part of 'home_bloc.dart';

enum HomeStatus { cheking, loading, selecting, downloading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Artist> artists;
  final String searchText;

  HomeState({
    required this.status,
    required this.artists,
    required this.searchText,
  });

  static HomeState get initialState =>
      HomeState(status: HomeStatus.cheking, artists: const [], searchText: '');

  HomeState copyWith(
          {HomeStatus? status, List<Artist>? artists, String? searchText}) =>
      HomeState(
          status: status ?? this.status,
          artists: artists ?? this.artists,
          searchText: searchText ?? this.searchText);

  @override
  List<Object?> get props => [status, artists, searchText];
}
