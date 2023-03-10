import 'package:emotion_wheel/common/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/common/presentation/widgets/emotions_expansion_list.dart';
import 'package:emotion_wheel/common/presentation/widgets/emotion_quiz.dart';
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
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: Scaffold.of(context).openEndDrawer,
                  icon: const Icon(Icons.info_outline_rounded));
            })
          ],
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Browse Emotions',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Divider(),
            EmotionsExpansionList(colors: emotionColors, emotions: emotions),
          ],
        )),
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const DrawerHeader(child: Text('Jeff Neet')),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Content and emotional content based upon the following research:',
                    // style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Text(
                  emotions.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'by ${emotions.author}',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                  child: Text(
                    emotions.subTitle,
                    // style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Text(
                  'Resources',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                // TODO: Add resource links
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: EmotionQuiz(colors: emotionColors, emotions: emotions),
            ),
            // Flexible(flex: 2, child: EmotionWheel(colors: emotionColors, emotions: emotions)),
          ]),
        ),
      ),
    );
  }
}
