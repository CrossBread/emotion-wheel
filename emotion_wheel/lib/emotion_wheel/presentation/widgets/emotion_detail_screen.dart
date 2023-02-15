import 'package:emotion_wheel/emotion_wheel/presentation/widgets/emotion_detail_screen_card.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/widgets/lorem_ipsum_text.dart';
import 'package:flutter/material.dart';

class EmotionDetailScreen extends StatelessWidget {
  final String choice;

  const EmotionDetailScreen(
    this.choice, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(tag: choice, child: Text(choice, style: Theme.of(context).textTheme.headlineLarge)),
        Card(
          child: Text('$choice > Bread > Crumb '),
        ),
        EmotionDetailScreenCard(emotionText: 'Core', oppositeText: 'Op Core'),
        EmotionDetailScreenCard(emotionText: 'Secondary', oppositeText: 'Op Secondary'),
        EmotionDetailScreenCard(emotionText: 'Tertiary', oppositeText: 'Op Tertiary'),
        Flexible(
          child: Card(
            child: ListView(
              shrinkWrap: true,
              clipBehavior: Clip.hardEdge,
              children: [
                Text('Where is this emotion felt in the body?'),
                LoremIpsumText(),
              ],
            ),
          ),
        )
      ],
    )));
  }
}
