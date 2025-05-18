
import 'package:premium_pay_seller/export_files.dart';

class Environment {
  static String baseUrl = dotenv.env['baseUrl'] ?? "";


  static String myIdClientId = dotenv.env['myIdClientId'] ?? "";
  static String myIdClientHash = dotenv.env['myIdClientHash'] ?? "";
  static String myIdClientHashId = dotenv.env['myIdClientHashId'] ?? "";
}


