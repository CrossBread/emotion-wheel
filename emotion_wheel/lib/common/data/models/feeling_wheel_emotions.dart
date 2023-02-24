import 'package:emotion_wheel/common/data/models/core_emotion.dart';

class FeelingWheelEmotions {
  FeelingWheelEmotions({
    required this.title,
    required this.subTitle,
    required this.author,
    required this.citation,
    required this.coreEmotions,
  });

  factory FeelingWheelEmotions.fromJson(dynamic json) {
    var title = json['title'];
    var subTitle = json['sub_title'];
    var author = json['author'];
    var citation = json['citation'];
    var coreEmotions = <CoreEmotion>[];
    if (json['core_emotions'] != null) {
      json['core_emotions'].forEach((v) {
        coreEmotions.add(CoreEmotion.fromJson(v));
      });
    }
    return FeelingWheelEmotions(
        title: title, subTitle: subTitle, author: author, citation: citation, coreEmotions: coreEmotions);
  }

  String title;
  String subTitle;
  String author;
  String citation;
  List<CoreEmotion> coreEmotions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['author'] = author;
    map['citation'] = citation;
    map['core_emotions'] = coreEmotions.map((v) => v.toJson()).toList();
    return map;
  }
}
