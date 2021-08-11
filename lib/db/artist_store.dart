import 'package:deezer_media_player/db/db.dart';
import 'package:deezer_media_player/models/artist.dart';
import 'package:sembast/sembast.dart';

class ArtistsStore {
  ArtistsStore._();
  static ArtistsStore _instance = ArtistsStore._();
  static ArtistsStore get instance => _instance;

  Database _db = DB.instance.database;
  StoreRef<int, Map> _storeRef = StoreRef<int, Map>('artists');

  Future<List<Artist>> find() async {
    final snapshots = await _storeRef.find(_db);
    return snapshots.map<Artist>((e) => Artist.fromJson(e.value)).toList();
  }

  Future<void> add(Artist artist) async {
    _storeRef.record(artist.id!).put(_db, artist.toJson());
  }

  Future<void> addAll(List<Artist> artists) async {
    // Asegurar que todos los datos sean consistentes
    await _db.transaction((transaction) async {
      for (final artist in artists) {
        await _storeRef.record(artist.id!).put(transaction, artist.toJson());
      }
    });
  }

  Future<void> clear() async {
    await _storeRef.delete(_db);
  }
}
