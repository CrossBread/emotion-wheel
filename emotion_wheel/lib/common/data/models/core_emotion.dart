import 'secondary_emotions.dart';
import 'tertiary_emotions.dart';

class CoreEmotion {
  CoreEmotion({
    required this.id,
    required this.name,
    required this.isPositive,
    required this.secondaryEmotions,
    required this.tertiaryEmotions,
  });

  factory CoreEmotion.fromJson(dynamic json) {
    var id = json['id'];
    var name = json['name'];
    var isPositive = json['isPositive'];
    var secondaryEmotions = <SecondaryEmotions>[];
    if (json['secondary_emotions'] != null) {
      json['secondary_emotions'].forEach((v) {
        secondaryEmotions.add(SecondaryEmotions.fromJson(v));
      });
    }
    var tertiaryEmotions = <TertiaryEmotions>[];
    if (json['tertiary_emotions'] != null) {
      json['tertiary_emotions'].forEach((v) {
        tertiaryEmotions.add(TertiaryEmotions.fromJson(v));
      });
    }

    return CoreEmotion(
        id: id,
        name: name,
        isPositive: isPositive,
        secondaryEmotions: secondaryEmotions,
        tertiaryEmotions: tertiaryEmotions);
  }

  int id;
  String name;
  bool isPositive;
  List<SecondaryEmotions> secondaryEmotions;
  List<TertiaryEmotions> tertiaryEmotions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['isPositive'] = isPositive;
    map['secondary_emotions'] = secondaryEmotions.map((v) => v.toJson()).toList();
    map['tertiary_emotions'] = tertiaryEmotions.map((v) => v.toJson()).toList();
    return map;
  }
}
