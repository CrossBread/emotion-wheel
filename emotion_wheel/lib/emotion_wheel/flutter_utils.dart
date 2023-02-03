import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Future<dynamic> loadJsonFromAsset(String asset) async {
  WidgetsFlutterBinding.ensureInitialized();
  return await rootBundle.loadString(asset).then((jsonStr) => json.decode(jsonStr));
}
