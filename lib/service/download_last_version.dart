import 'package:url_launcher/url_launcher.dart';

Future<void> DownLoadLastVersion() async {

  final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.premium_pay.premium_pay_seller');
  if (!await launchUrl(url,mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
