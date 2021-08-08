import 'dart:convert';

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

class Artist {
  Artist(
      {this.id,
      this.name,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.radio,
      this.tracklist,
      this.type,
      this.selected = false});

  int? id;
  String? name;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  String? type;
  bool selected;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"] == null ? null : json["picture"],
        pictureSmall:
            json["picture_small"] == null ? null : json["picture_small"],
        pictureMedium:
            json["picture_medium"] == null ? null : json["picture_medium"],
        pictureBig: json["picture_big"] == null ? null : json["picture_big"],
        pictureXl: json["picture_xl"] == null ? null : json["picture_xl"],
        radio: json["radio"] == null ? null : json["radio"],
        tracklist: json["tracklist"] == null ? null : json["tracklist"],
        type: json["type"] == null ? null : json["type"],
      );

  Artist onSelected() {
    return Artist(
        id: id,
        name: name,
        picture: picture,
        pictureSmall: pictureSmall,
        pictureMedium: pictureMedium,
        pictureBig: pictureBig,
        pictureXl: pictureXl,
        radio: radio,
        tracklist: tracklist,
        type: type,
        selected: !selected);
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture,
        "picture_small": pictureSmall == null ? null : pictureSmall,
        "picture_medium": pictureMedium == null ? null : pictureMedium,
        "picture_big": pictureBig == null ? null : pictureBig,
        "picture_xl": pictureXl == null ? null : pictureXl,
        "radio": radio == null ? null : radio,
        "tracklist": tracklist == null ? null : tracklist,
        "type": type == null ? null : type,
      };
}
