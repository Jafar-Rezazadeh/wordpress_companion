import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/widgets/infinite_list_view.dart';

void main() {
  testWidgets(
      "should show full_screen_loading widget when showFullScreenLoading is true",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const _TestWidget(
        showFullScreenLoading: true,
      ),
    );

    //assert
    expect(find.byKey(const Key("full_screen_loading")), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets(
      "should show no_data_info_text when fullScreenLoading is false and data is empty",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const _TestWidget(
        showFullScreenLoading: false,
        data: [],
      ),
    );

    //assert
    expect(find.byKey(const Key("no_data_info_text")), findsOneWidget);
    expect(find.byKey(const Key("full_screen_loading")), findsNothing);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets("should invoke the onRefresh method when dragged top",
      (tester) async {
    //arrange
    int a = 0;
    Future<void> onRefresh() async {
      a++;
    }

    await tester.pumpWidget(_TestWidget(
      onRefresh: onRefresh,
      data: const ["hello"],
    ));
    final listViewFinder = find.byType(ListView).first;

    //verification
    expect(listViewFinder, findsOneWidget);

    //act
    await tester.drag(listViewFinder, const Offset(0, 500));
    await tester.pumpAndSettle();

    //assert
    expect(a, 1);
  });

  testWidgets(
      "should invoke the onScrolledToBottom method when listView is scrolled to bottom",
      (tester) async {
    //arrange
    bool invoked = false;
    onScrolledToBottom() {
      invoked = true;
    }

    await tester.pumpWidget(
      _TestWidget(
        data: List.generate(10, (int i) => "hello $i"),
        onScrolledToBottom: onScrolledToBottom,
      ),
    );
    final listViewFinder = find.byType(ListView).first;

    //verification
    expect(invoked, false);
    expect(listViewFinder, findsOneWidget);

    //act
    await tester.drag(listViewFinder, const Offset(0, -1000));
    await tester.pumpAndSettle();

    //assert
    expect(invoked, true);
  });

  testWidgets(
      "should show load_on_scroll_widget when showBottomLoading is true",
      (tester) async {
    //arrange
    await tester.pumpWidget(
      const _TestWidget(
        showBottomLoading: true,
        data: ["hello"],
      ),
    );
    await tester.pump(Durations.short1);
    //assert
    expect(find.byKey(const Key("load_on_scroll_widget")), findsOneWidget);
  });
}

class _TestWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final dynamic Function() onScrolledToBottom;
  final List<String>? data;
  final bool? showBottomLoading;
  final bool? showFullScreenLoading;
  static Future<void> _onRefresh() async {}
  static _onScrollBottom() {}
  const _TestWidget({
    this.onRefresh = _onRefresh,
    this.onScrolledToBottom = _onScrollBottom,
    this.data,
    this.showBottomLoading,
    this.showFullScreenLoading,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfiniteListView(
        onRefresh: onRefresh,
        onScrolledToBottom: onScrolledToBottom,
        data: data ?? [],
        itemBuilder: (item) => Text(item),
        showBottomLoadingWhen: showBottomLoading ?? false,
        showFullScreenLoadingWhen: showFullScreenLoading ?? false,
      ),
    );
  }
}
