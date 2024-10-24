import 'package:url_launcher/url_launcher.dart';

class CustomUrlLauncher {
  Future<bool> openInBrowser(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      return false;
    }
  }
}
