import 'package:flutter_dotenv/flutter_dotenv.dart';

class GlobalVariables {
  static const List<String> bannerImages = [
    'https://storage.googleapis.com/astro-site/home/new-user.webp',
    'https://storage.googleapis.com/astro-site/home/24jam.webp',
  ];

  static String baseUrl = dotenv.env['BASE_URL']!;
}
