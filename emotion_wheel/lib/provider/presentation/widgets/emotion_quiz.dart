import 'package:emotion_wheel/common/data/models/app_state.dart';
import 'package:emotion_wheel/common/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/constants.dart';
import 'package:emotion_wheel/provider/provider_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GoodBadScreen extends StatelessWidget {
  static const goodChoice = 'Good';
  static const List<String> choices = [goodChoice, 'Bad'];

  const GoodBadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoiceScreen(
      titleText: 'Hello.',
      promptText: 'How are you feeling right now?',
      choices: choices,
      onChoiceMade: (choice) {
        Provider.of<AppState>(context, listen: false).showOnlyPositive = choice == goodChoice;
        context.pushNamed('quiz-core');
      },
    );
  }
}

class CoreScreen extends StatelessWidget {
  const CoreScreen({super.key});

  // emotions.coreEmotions
  //     .where((coreEmotion) => coreEmotion.isPositive == (choice == 'Good')

  @override
  Widget build(BuildContext context) {
    return Consumer3<FeelingWheelEmotions, EmotionColors, AppState>(
      builder: (context, feelingWheelEmotions, colors, appState, child) {
        var coreEmotions = feelingWheelEmotions.coreEmotions
            .where((coreEmotion) => coreEmotion.isPositive == appState.showOnlyPositive);
        return ChoiceScreen(
          titleText: appState.showOnlyPositive ? 'Good' : 'Bad',
          promptText: 'Which way are you leaning?',
          choices: coreEmotions.map((e) => e.name).toList(),
          onChoiceMade: (choice) {
            appState.selectedCoreEmotion =
                coreEmotions.firstWhere((coreEmotion) => coreEmotion.name == choice);

            context.pushNamed('quiz-secondary');
          },
        );
      },
    );
  }
}

class SecondaryScreen extends StatelessWidget {
  const SecondaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<FeelingWheelEmotions, EmotionColors, AppState>(
        builder: (context, feelingWheelEmotions, colors, appState, child) {
      var coreEmotion = appState.selectedCoreEmotion!;
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
            context.pushNamed(
              'emotion-detail',
              params: {kEmotionNamePathParameter: coreEmotion.name},
            );
          } else {
            appState.selectedSecondaryEmotion = appState.selectedCoreEmotion?.secondaryEmotions
                .firstWhere((coreEmotion) => coreEmotion.name == choice);

            context.pushNamed('quiz-tertiary');
          }
        },
      );
    });
  }
}

class TertiaryScreen extends StatelessWidget {
  const TertiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<FeelingWheelEmotions, EmotionColors, AppState>(
      builder: (context, feelingWheelEmotions, colors, appState, child) {
        var coreEmotion = appState.selectedCoreEmotion;
        var secondaryEmotion = appState.selectedSecondaryEmotion;
        var tertiaryEmotion =
            coreEmotion?.tertiaryEmotions[(coreEmotion.secondaryEmotions.indexOf(secondaryEmotion!))];

        var tertiaryPrefix = 'Yes, I feel';
        var corePrefix = 'Actually, I just feel';

        Map<String, String?> choicesMap = {
          '$tertiaryPrefix ${tertiaryEmotion?.name}': tertiaryEmotion?.name,
          'No, I feel ${secondaryEmotion?.name}': secondaryEmotion?.name,
          '$corePrefix ${coreEmotion?.name}': coreEmotion?.name,
        };

        return ChoiceScreen(
            titleText: appState.selectedSecondaryEmotion?.name ?? 'No Emotion Selected',
            promptText: 'Is ${tertiaryEmotion?.name} an even closer match?',
            choices: choicesMap.keys.toList(),
            onChoiceMade: (choice) {
              if (choice.contains(tertiaryPrefix)) {
                appState.selectedTertiaryEmotion = tertiaryEmotion;
              }
              context.pushNamed(
                'emotion-detail',
                params: {kEmotionNamePathParameter: choicesMap[choice] ?? 'error'},
              );
            });
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
