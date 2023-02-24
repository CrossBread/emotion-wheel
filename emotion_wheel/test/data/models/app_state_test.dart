import 'package:emotion_wheel/common/data/models/app_state.dart';
import 'package:emotion_wheel/common/data/models/core_emotion.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group(
    'App State',
    () {
      test('Emotion Setters', () {
        final state = AppState();
        var mockCoreEmotion =
            CoreEmotion(id: 0, name: 'name', isPositive: true, secondaryEmotions: [], tertiaryEmotions: []);

        state.addListener(() => expect(state.selectedCoreEmotion, mockCoreEmotion));

        expect(state.selectedCoreEmotion, isNull);
        state.selectedCoreEmotion = mockCoreEmotion;
        expect(state.selectedCoreEmotion, isNotNull);
      });
    },
  );
}
