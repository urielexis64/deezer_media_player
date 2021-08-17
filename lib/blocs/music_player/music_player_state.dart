part of 'music_player_bloc.dart';

class MusicPlayerState extends Equatable {
  const MusicPlayerState({required this.currentIndexTrack});

  final int currentIndexTrack;

  static MusicPlayerState initialState() =>
      MusicPlayerState(currentIndexTrack: 0);

  @override
  List<Object> get props => [currentIndexTrack];

  MusicPlayerState copyWith({int? currentIndexTrack}) => MusicPlayerState(
      currentIndexTrack: currentIndexTrack ?? this.currentIndexTrack);
}
