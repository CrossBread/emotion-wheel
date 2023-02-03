import 'package:emotion_wheel/emotion_wheel/domain/entities/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/emotion_wheel/flutter_utils.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/pages/home_page.dart';
import 'package:emotion_wheel/emotion_wheel/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return MaterialApp(
      title: 'Emotion Wheel',
      theme: ThemeData.dark(
        useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      home: _isLoading
          ? SplashPage(
        onLoad: _initAppState,
        onLoadComplete: () =>
            setState(() {
              _isLoading = false;
            }),
      )
          : HomePage(emotions: _emotions!, emotionColors: emotionColors),
    );
  }

  Future<void> _initAppState() async {
    _emotions = FeelingWheelEmotions.fromJson(await loadJsonFromAsset('assets/data/emotions.json'));
  }
}
