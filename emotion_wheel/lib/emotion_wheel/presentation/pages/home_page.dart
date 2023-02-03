import 'package:emotion_wheel/emotion_wheel/domain/entities/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/widgets/emotion_wheel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  final FeelingWheelEmotions emotions;

  const HomePage(this.emotions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Emotion Wheel'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  width: 300,
                  child: _buildExpansionPanels(context, emotions),
                  // children: [
                  //   ExpansionPanelRadio(
                  //       value: 1,
                  //       headerBuilder: (context, isExpanded) => Text('Heading'),
                  //       body: Text('Body')),
                  //   ExpansionPanelRadio(
                  //       value: 2,
                  //       headerBuilder: (context, isExpanded) => Text('Heading'),
                  //       body: Text('Body')),
                  //   ExpansionPanelRadio(
                  //       value: 3,
                  //       headerBuilder: (context, isExpanded) => Text('Heading'),
                  //       body: Text('Body')),
                  // ]
                ),
              ),
            ),
            Flexible(flex: 2, child: EmotionWheel()),
          ]),
        ),
        // body: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Container(color: Colors.black),
        //     Container(color: Colors.purpleAccent),
        //   ],
        // ),
      ),
    );
  }

  Widget _buildExpansionPanels(BuildContext context, FeelingWheelEmotions emotions) {
    var colors = [Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.deepOrange, Colors.orange];
    return Theme(
      data: ThemeData(
          listTileTheme: ListTileThemeData(textColor: Colors.black),
          textTheme: Theme.of(context).textTheme.copyWith(
                // headlineMedium: TextStyle(color: Colors.black),
                // titleLarge: TextStyle(color: Colors.grey.shade900),
                titleMedium: TextStyle(color: Colors.black),
              )),
      child: ExpansionPanelList.radio(
        expansionCallback: (panelIndex, isExpanded) => print('Expanded'),
        animationDuration: kThemeAnimationDuration * 3,
        expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: emotions.coreEmotions.map(
          (core) {
            var color = colors.removeAt(0);
            return ExpansionPanelRadio(
              backgroundColor: color.shade500,
              canTapOnHeader: true,
              value: core.id,
              headerBuilder: (context, isExpanded) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                child: Text(
                  core.name,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color.shade900),
                ),
              ),
              body: SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                expandedHeaderPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: core.secondaryEmotions
                    .map((secondary) => ExpansionPanelRadio(
                          backgroundColor: color.shade300,
                          canTapOnHeader: true,
                          value: secondary.id,
                          headerBuilder: (context, isExpanded) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                            child: Text(
                              secondary.name,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color.shade900),
                            ),
                          ),
                          body: ListView(shrinkWrap: true, children: [
                            ListTile(
                              tileColor: color.shade100,
                              textColor: color.shade900,
                              title: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8.0),
                                child: Text(
                                  core.tertiaryEmotions
                                      .firstWhere((tertiary) => tertiary.id == secondary.id)
                                      .name,
                                  // style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              trailing: core.isPositive
                                  ? Icon(FontAwesomeIcons.arrowTrendDown)
                                  : Icon(FontAwesomeIcons.arrowTrendUp),
                            ),
                          ]),
                        ))
                    .toList(),
              )),
            );
          },
        ).toList(),
      ),
    );
  }
}
