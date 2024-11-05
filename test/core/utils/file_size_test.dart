import 'package:flutter_test/flutter_test.dart';
import 'package:wordpress_companion/core/utils/file_size.dart';

void main() {
  test('filesize', () {
    expect(filesize(1024), '1 KB');
    expect(filesize(1024 * 1024), '1 MB');
    expect(filesize(1024 * 1024 * 1024), '1 GB');
    expect(filesize(1024 * 1024 * 1024 * 1024), '1 TB');
    expect(filesize(1024 * 1024 * 1024 * 1024 * 1024), '1 PB');

    expect(filesize('1024'), '1 KB');

    expect(filesize(0), '0 B');
    expect(filesize(1), '1 B');
    expect(filesize(1023), '1023 B');

    expect(filesize(1024 * 1024 - 1), '1024.00 KB');
    expect(filesize(1024 * 1024 + 1), '1.00 MB');

    expect(filesize(1024 * 1024 * 1024 - 1), '1024.00 MB');
    expect(filesize(1024 * 1024 * 1024 + 1), '1.00 GB');

    expect(filesize(1024 * 1024 * 1024 * 1024 - 1), '1024.00 GB');
    expect(filesize(1024 * 1024 * 1024 * 1024 + 1), '1.00 TB');

    expect(filesize(1024 * 1024 * 1024 * 1024 * 1024 - 1), '1024.00 TB');
    expect(filesize(1024 * 1024 * 1024 * 1024 * 1024 + 1), '1.00 PB');

    expect(filesize(1024 * 1024 * 1024 * 1024 * 1024 * 1024 - 1), '1024.00 PB');
    expect(filesize(1024 * 1024 * 1024 * 1024 * 1024 * 1024 + 1), '1024.00 PB');
  });
}
