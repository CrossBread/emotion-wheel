import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<Map<String, dynamic>> loadJsonFromAsset(String assetPath) async {
  WidgetsFlutterBinding.ensureInitialized();
  return await rootBundle.loadStructuredData(assetPath, (String s) async => json.decode(s));
}
