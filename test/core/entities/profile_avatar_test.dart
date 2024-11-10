import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/entities/profile_avatar.dart';

void main() {
  // test("should contain the expected values in the props ", () {
  //   //arrange
  //   const profileAvatar = ProfileAvatar(
  //     size24px: "url1",
  //     size48px: "url2",
  //     size96px: "url3",
  //   );

  //   //act
  //   final result = profileAvatar.props;

  //   //assert
  //   expect(result, containsAll(["url1", "url2", "url3"]));
  // });

  test("should be same if the object has the same field values ", () {
    //arrange
    const object1 = ProfileAvatar(
      size24px: "url1",
      size48px: "url2",
      size96px: "url3",
    );

    const object2 = ProfileAvatar(
      size24px: "url1",
      size48px: "url2",
      size96px: "url3",
    );

    //assert
    expect(object1 == object2, isTrue);
  });
}
