// Create a singleton class
import 'package:deezer_media_player/models/artist.dart';
import 'package:deezer_media_player/models/track.dart';
import 'package:dio/dio.dart';

class DeezerAPI {
  DeezerAPI._();

  static DeezerAPI _instance = DeezerAPI._();

  static DeezerAPI get instance => _instance;

  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://api.deezer.com',
      connectTimeout: 5000,
      receiveTimeout: 10000));

  Future<List<Artist>?> getArtists() async {
    try {
      final response = await _dio.get('/genre/0/artists');
      if (response.statusCode == 200) {
        final List<Artist> artists = (response.data['data'] as List)
            .map((json) => Artist.fromJson(json))
            .toList();
        return artists;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<Track>> getTracks(int id) async {
    try {
      final response = await _dio.get('/artist/$id/top?limit=20');
      if (response.statusCode == 200) {
        final List<Track> tracks = (response.data['data'] as List)
            .map((json) => Track.fromJson(json))
            .toList();
        return tracks;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
