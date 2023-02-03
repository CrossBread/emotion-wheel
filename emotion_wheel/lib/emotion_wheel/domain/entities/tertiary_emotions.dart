class TertiaryEmotions {
  TertiaryEmotions({
    required this.id,
    required this.name,});

  factory TertiaryEmotions.fromJson(dynamic json) {
    var id = json['id'];
    var name = json['name'];

    return TertiaryEmotions(id: id, name: name);
  }
  int id;
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}