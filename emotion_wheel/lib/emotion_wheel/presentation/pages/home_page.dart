import 'package:emotion_wheel/emotion_wheel/domain/entities/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/pages/emotions_expansion_list.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/widgets/emotion_wheel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FeelingWheelEmotions emotions;
  final List<MaterialColor> emotionColors;

  const HomePage({required this.emotions, required this.emotionColors, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Emotion Wheel'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  width: 300,
                  child: EmotionsExpansionList(colors: emotionColors, emotions: emotions),
                ),
              ),
            ),
            const Flexible(flex: 2, child: EmotionWheel()),
          ]),
        ),
      ),
    );
  }
}
