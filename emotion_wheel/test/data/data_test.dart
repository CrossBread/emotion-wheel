import 'package:emotion_wheel/common/flutter_utils.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Data', () {
    test('Load json from assetBundle', () async {
      String name = 'assets/data/emotions.json';

      var json = await loadJsonFromAsset(name);
      expect(json, isNotNull);
      expect(json, isNotEmpty);
    });
  });
}
