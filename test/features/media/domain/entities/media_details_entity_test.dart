import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';

void main() {
  test("should include the fileSize to props ", () {
    //arrange
    const mediaDetails = MediaDetailsEntity(fileSize: 500);

    //act
    final props = mediaDetails.props;

    //assert
    expect(props, [500]);
  });
}
