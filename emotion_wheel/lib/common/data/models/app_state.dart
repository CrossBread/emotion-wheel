import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:emotion_wheel/common/data/models/core_emotion.dart';
import 'package:emotion_wheel/common/data/models/secondary_emotions.dart';
import 'package:emotion_wheel/common/data/models/tertiary_emotions.dart';
import 'package:flutter/cupertino.dart';

// part 'app_state.g.dart';

// @CopyWith()
class AppState extends ChangeNotifier {
  bool _showOnlyPositive = false;
  CoreEmotion? _selectedCoreEmotion;
  SecondaryEmotions? _selectedSecondaryEmotion;
  TertiaryEmotions? _selectedTertiaryEmotion;

  AppState(
      /*{
    this.selectedCoreEmotion,
    this.selectedSecondaryEmotion,
    this.selectedTertiaryEmotion,
  }*/
      );

  // TODO:  Should we just replace all of these with get/set state and copyWith?  The consumers can become Selectors and check what they care about.

  String get oppositeEmotion {
    // TODO: implement oppositeEmotion
    throw UnimplementedError();
  }

  bool get showOnlyPositive => _showOnlyPositive;

  set showOnlyPositive(bool showOnlyPositive) {
    _showOnlyPositive = showOnlyPositive;
    notifyListeners();
  }

  CoreEmotion? get selectedCoreEmotion => _selectedCoreEmotion;

  set selectedCoreEmotion(CoreEmotion? emotion) {
    _selectedCoreEmotion = emotion;
    notifyListeners();
  }

  SecondaryEmotions? get selectedSecondaryEmotion => _selectedSecondaryEmotion;

  set selectedSecondaryEmotion(SecondaryEmotions? emotion) {
    _selectedSecondaryEmotion = emotion;
    notifyListeners();
  }

  TertiaryEmotions? get selectedTertiaryEmotion => _selectedTertiaryEmotion;

  set selectedTertiaryEmotion(TertiaryEmotions? emotion) {
    _selectedTertiaryEmotion = emotion;
    notifyListeners();
  }
}
