import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/core_export.dart';

void main() {
  group('ColorPallet Property Test', () {
    test('All colors should be defined', () {
      expect(ColorPallet.deepBlue, isNotNull);
      expect(ColorPallet.blue, isNotNull);
      expect(ColorPallet.midBlue, isNotNull);
      expect(ColorPallet.lightBlue, isNotNull);
      expect(ColorPallet.lowBlue, isNotNull);
      expect(ColorPallet.white, isNotNull);
      expect(ColorPallet.text, isNotNull);
      expect(ColorPallet.border, isNotNull);
      expect(ColorPallet.crimson, isNotNull);
      expect(ColorPallet.lowCrimson, isNotNull);
      expect(ColorPallet.lightGreen, isNotNull);
      expect(ColorPallet.lowBackGround, isNotNull);
      expect(ColorPallet.yellowishGreen, isNotNull);
      expect(ColorPallet.yellow, isNotNull);
    });
  });
}
