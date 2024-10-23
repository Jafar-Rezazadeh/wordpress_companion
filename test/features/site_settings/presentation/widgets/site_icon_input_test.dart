import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/site_settings/presentation/widgets/site_icon_input.dart';

void main() {
  testWidgets("should open a dialog when taped on the imageBox",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: SiteIconInput(
            onSelect: (value) {},
          ),
        ),
      ),
    );

    //act
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    //assert
    expect(find.byKey(const Key("select_media_dialog")), findsOneWidget);
  });
}
