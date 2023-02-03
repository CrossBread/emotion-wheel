import 'package:emotion_wheel/emotion_wheel/presentation/widgets/emotion_wheel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  child: ExpansionPanelList.radio(
                      expansionCallback: (panelIndex, isExpanded) => print('Expanded'),
                      children: [
                        ExpansionPanelRadio(
                            value: 1,
                            headerBuilder: (context, isExpanded) => Text('Heading'),
                            body: Text('Body')),
                        ExpansionPanelRadio(
                            value: 2,
                            headerBuilder: (context, isExpanded) => Text('Heading'),
                            body: Text('Body')),
                        ExpansionPanelRadio(
                            value: 3,
                            headerBuilder: (context, isExpanded) => Text('Heading'),
                            body: Text('Body')),
                      ]),
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
}
