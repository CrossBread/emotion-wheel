import 'package:emotion_wheel/common/emotional_wheel_app.dart';
import 'package:emotion_wheel/provider/provider_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProviderApp(
    builder: (router) => EmotionWheelApp(router: router),
  ));
}
