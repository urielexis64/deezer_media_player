part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent {}

class OnNextTrackEvent extends MusicPlayerEvent {}

class OnPrevTrackEvent extends MusicPlayerEvent {}
