import 'package:deezer_media_player/models/artist.dart';
import 'package:equatable/equatable.dart';

enum HomeStatus { cheking, loading, selecting, downloading, ready, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Artist> artists;

  HomeState({required this.status, required this.artists});

  static HomeState get initialState =>
      HomeState(status: HomeStatus.cheking, artists: const []);

  HomeState copyWith({HomeStatus? status, List<Artist>? artists}) => HomeState(
      status: status ?? this.status, artists: artists ?? this.artists);

  @override
  List<Object?> get props => [status, artists];
}
