import 'package:emotion_wheel/common/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/common/flutter_utils.dart';
import 'package:flutter/material.dart';

class EmotionWheelApp extends StatefulWidget {
  final RouterConfig<Object> router;

  const EmotionWheelApp({required this.router, super.key});

  @override
  State<EmotionWheelApp> createState() => _EmotionWheelAppState();
}

class _EmotionWheelAppState extends State<EmotionWheelApp> {
  var _isLoading = true;
  Map<String, dynamic> json = {};
  FeelingWheelEmotions? _emotions;

  final emotionColors = [
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.deepOrange,
    Colors.orange
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: widget.router,
      debugShowCheckedModeBanner: false,
      title: 'Emotion Wheel',
      theme: ThemeData.dark(
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      // home: _isLoading
      //     ? SplashPage(
      //         onLoad: _initAppState,
      //         onLoadComplete: () => setState(() {
      //           _isLoading = false;
      //         }),
      //       )
      //     : HomePage(emotions: _emotions!, emotionColors: emotionColors),
    );
  }

  Future<void> _initAppState() async {
    _emotions = FeelingWheelEmotions.fromJson(await loadJsonFromAsset('assets/data/emotions.json'));
  }
}
