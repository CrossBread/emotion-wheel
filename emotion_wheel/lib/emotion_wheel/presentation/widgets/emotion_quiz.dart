import 'package:emotion_wheel/emotion_wheel/domain/entities/feeling_wheel_emotions.dart';
import 'package:flutter/material.dart';

class EmotionQuiz extends StatefulWidget {
  final FeelingWheelEmotions emotions;
  final List<MaterialColor> colors;

  const EmotionQuiz({super.key, required this.colors, required this.emotions});

  @override
  State<EmotionQuiz> createState() => _EmotionQuizState();
}

class _EmotionQuizState extends State<EmotionQuiz> {
  var emotionMap = <String, String>{};

  @override
  Widget build(BuildContext context) {
    return const GoodBadScreen();
  }

  @override
  void initState() {
    super.initState();
    //   widget.emotions.coreEmotions.where((element) => element.isPositive).map((e) => {'null'})
    //   for (var emotion in widget.emotions.coreEmotions.where((element) => element.isPositive).toList())
    // {
    //   emotionMap.ad
    // }
  }
}

class GoodBadScreen extends StatelessWidget {
  static const List<String> choices = ['Good', 'Bad'];

  const GoodBadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      choices: choices,
      titleText: 'How are you feeling right now?',
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TertiaryScreen(),
            ));
      },
    );
  }
}

class CoreScreen extends StatelessWidget {
  static const List<String> choices = ['Good', 'Bad'];

  const CoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      choices: choices,
      titleText: 'How are you feeling right now?',
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoodBadScreen(),
            ));
      },
    );
  }
}

class SecondaryScreen extends StatelessWidget {
  static const List<String> choices = ['Good', 'Bad'];

  const SecondaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      choices: choices,
      titleText: 'How are you feeling right now?',
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoodBadScreen(),
            ));
      },
    );
  }
}

class TertiaryScreen extends StatelessWidget {
  static const List<String> choices = ['Good', 'Bad'];

  const TertiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      choices: choices,
      titleText: 'How are you feeling right now?',
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoodBadScreen(),
            ));
      },
    );
  }
}

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({
    super.key,
    required this.choices,
    required this.onChoiceMade,
    required this.titleText,
  });

  final List<String> choices;
  final Null Function(String choice) onChoiceMade;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Text(titleText, style: Theme.of(context).textTheme.headlineMedium),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...choices.map((label) {
                return Expanded(
                    child: ElevatedButton(onPressed: () => onChoiceMade(label), child: Text(label)));
              }).toList(),
            ],
          ),
        )
      ],
    );
  }
}
