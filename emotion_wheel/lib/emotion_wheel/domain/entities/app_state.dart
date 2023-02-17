import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/cupertino.dart';

part 'app_state.g.dart';

@CopyWith()
class AppState extends ChangeNotifier {
  final String? selectedCoreEmotion;
  final String? selectedSecondaryEmotion;
  final String? selectedTertiaryEmotion;

  AppState({
    this.selectedCoreEmotion,
    this.selectedSecondaryEmotion,
    this.selectedTertiaryEmotion,
  });

  String get oppositeEmotion {
    // TODO: implement oppositeEmotion
    throw UnimplementedError();
  }
}
