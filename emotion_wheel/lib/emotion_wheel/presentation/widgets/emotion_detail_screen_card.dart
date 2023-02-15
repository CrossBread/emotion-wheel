import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmotionDetailScreenCard extends StatelessWidget {
  const EmotionDetailScreenCard({
    super.key,
    required this.emotionText,
    required this.oppositeText,
  });

  final String emotionText;
  final String oppositeText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(emotionText),
          Spacer(),
          Text('Opposite:'),
          Text(oppositeText),
          IconButton(onPressed: () => _goToOpposite(), icon: Icon(FontAwesomeIcons.arrowRight))
        ],
      ),
    );
  }

  void _goToOpposite() => print('Go to opposite');
}
