import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalVariables {
  static String baseUrl = dotenv.env['BASE_URL']!;

  static const String successLogin = 'success';
}
