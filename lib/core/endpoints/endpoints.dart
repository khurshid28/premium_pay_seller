// import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'package:premium_pay_seller/export_files.dart';

class Endpoints {
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;
  static String baseUrl = dotenv.get('baseUrl',fallback: "");

  static String login = dotenv.get('login',fallback: "");

  static String allApp = dotenv.get('allApp',fallback: "");
  static String app = dotenv.get('app',fallback: "");


  static String myIdClientId = dotenv.get('myIdClientId',fallback: "");
  static String myIdClientHashId = dotenv.get('myIdClientHashId',fallback: "");
  static String myIdClientHash = dotenv.get('myIdClientHash',fallback: "");

  
}
