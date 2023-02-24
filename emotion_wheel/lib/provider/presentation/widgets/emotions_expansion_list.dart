import 'package:emotion_wheel/common/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/provider/provider_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EmotionsExpansionList extends StatelessWidget {
  const EmotionsExpansionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          listTileTheme: const ListTileThemeData(textColor: Colors.black),
          textTheme: Theme.of(context).textTheme.copyWith(
                // headlineMedium: TextStyle(color: Colors.black),
                // titleLarge: TextStyle(color: Colors.grey.shade900),
                titleMedium: const TextStyle(color: Colors.black),
              )),
      child: Consumer2<FeelingWheelEmotions, EmotionColors>(
        builder: (context, emotions, colors, child) => ExpansionPanelList.radio(
          expansionCallback: (panelIndex, isExpanded) => print('Expanded'),
          animationDuration: kThemeAnimationDuration * 3,
          expandedHeaderPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: emotions.coreEmotions.map(
            (core) {
              var color = colors[core.id - 1];
              return ExpansionPanelRadio(
                backgroundColor: color.shade500,
                canTapOnHeader: true,
                value: core.id,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                    child: Text(
                      core.name,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: color.shade900),
                    ),
                  );
                },
                body: SingleChildScrollView(
                    child: ExpansionPanelList.radio(
                  expandedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  children: core.secondaryEmotions.map((secondary) {
                    return ExpansionPanelRadio(
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
                        Builder(
                          builder: (context) => ListTile(
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
                                ? const Icon(FontAwesomeIcons.arrowTrendDown)
                                : const Icon(FontAwesomeIcons.arrowTrendUp),
                            onTap: () {
                              // TODO: Make sure graph is visible
                              // Scrollable.ensureVisible(
                              //   ?,
                              //   duration: Duration(seconds: 1),
                              //   curve: Curves.easeOutQuad,
                              // );
                            },
                          ),
                        ),
                      ]),
                    );
                  }).toList(),
                )),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
