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
      children: [
        Hero(tag: choice, child: Text(choice, style: Theme.of(context).textTheme.headlineLarge)),
      ],
    )));
  }
}
