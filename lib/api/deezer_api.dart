// Create a singleton class
import 'package:deezer_media_player/models/artist.dart';
import 'package:dio/dio.dart';

class DeezerAPI {
  DeezerAPI._();

  static DeezerAPI _instance = DeezerAPI._();

  static DeezerAPI get instance => _instance;

  final Dio _dio = Dio();

  Future<List<Artist>?> getArtists() async {
    try {
      final response = await _dio.get('https://api.deezer.com/genre/0/artists');
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
}
