import 'package:emotion_wheel/emotion_wheel/data/models/core_emotion.dart';
import 'package:emotion_wheel/emotion_wheel/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/widgets/emotion_detail_screen.dart';
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
    return Navigator(
      // TODO: Replace with go router at the app level.
      pages: [MaterialPage(child: GoodBadScreen(widget.emotions, widget.colors))],
    );
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

  final FeelingWheelEmotions emotions;
  final List<MaterialColor> colors;

  const GoodBadScreen(this.emotions, this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      titleText: 'Hello.',
      promptText: 'How are you feeling right now?',
      choices: choices,
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoreScreen(
                  emotions.coreEmotions.where((coreEmotion) => coreEmotion.isPositive == (choice == 'Good')),
                  colors),
            ));
      },
    );
  }
}

class CoreScreen extends StatelessWidget {
  final Iterable<CoreEmotion> coreEmotions;
  final List<MaterialColor> colors;

  const CoreScreen(this.coreEmotions, this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      titleText: coreEmotions.first.isPositive ? 'Good' : 'Bad',
      promptText: 'Which way are you leaning?',
      choices: coreEmotions.map((e) => e.name).toList(),
      onChoiceMade: (choice) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondaryScreen(
                  coreEmotions.firstWhere((coreEmotion) => coreEmotion.name == choice), colors),
            ));
      },
    );
  }
}

class SecondaryScreen extends StatelessWidget {
  final CoreEmotion coreEmotion;
  final List<MaterialColor> colors;

  const SecondaryScreen(this.coreEmotion, this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    var coreEmotionChoice = 'No, I just feel ${coreEmotion.name}';
    return ChoiceScreen(
      titleText: coreEmotion.name,
      promptText: "Can you name a more specific feeling?",
      choices: [
        ...coreEmotion.secondaryEmotions.map((e) => e.name).toList(),
        coreEmotionChoice,
      ],
      onChoiceMade: (choice) {
        if (choice == coreEmotionChoice) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmotionDetailScreen(coreEmotion.name),
              ));
        } else {
          var choiceIndex =
              coreEmotion.secondaryEmotions.indexWhere((secondaryEmotion) => secondaryEmotion.name == choice);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TertiaryScreen(
                coreEmotion,
                choiceIndex,
                colors,
              ),
            ),
          );
        }
      },
    );
  }
}

class TertiaryScreen extends StatelessWidget {
  final CoreEmotion coreEmotion;
  final int choiceIndex;
  final List<MaterialColor> colors;

  const TertiaryScreen(this.coreEmotion, this.choiceIndex, this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    var secondaryEmotion = coreEmotion.secondaryEmotions[choiceIndex];
    var tertiaryEmotion = coreEmotion.tertiaryEmotions[choiceIndex];

    var choiceNames = [tertiaryEmotion.name, secondaryEmotion.name, coreEmotion.name];
    var choices = [
      'Yes, I feel ${choiceNames[0]}]',
      'No, I feel ${choiceNames[1]}',
      'Actually, I just feel ${choiceNames[2]}',
    ];

    return ChoiceScreen(
      titleText: coreEmotion.secondaryEmotions[choiceIndex].name,
      promptText: 'Is ${tertiaryEmotion.name} an even closer match?',
      choices: choices,
      onChoiceMade: (choice) {
        String choiceName = choiceNames[choices.indexOf(choice)];

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmotionDetailScreen(choiceName),
            ));
      },
    );
  }
}

class ChoiceScreen extends StatelessWidget {
  final String titleText;
  final String promptText;
  final List<String> choices;
  final Null Function(String choice) onChoiceMade;

  const ChoiceScreen({
    super.key,
    required this.choices,
    required this.onChoiceMade,
    required this.titleText,
    required this.promptText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Hero(
                tag: titleText, child: Text(titleText, style: Theme.of(context).textTheme.headlineLarge)),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Text(promptText, style: Theme.of(context).textTheme.headlineMedium),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...choices.map((label) {
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () => onChoiceMade(label), child: Hero(tag: label, child: Text(label))),
                ));
              }).toList(),
            ],
          ),
        )
      ],
    );
  }
}
