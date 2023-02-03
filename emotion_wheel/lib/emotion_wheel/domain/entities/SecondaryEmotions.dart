class SecondaryEmotions {
  SecondaryEmotions({
      required this.id,
      required this.name,});

  factory SecondaryEmotions.fromJson(dynamic json) {
    var id = json['id'];
    var name = json['name'];

    return SecondaryEmotions(id: id, name: name);
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