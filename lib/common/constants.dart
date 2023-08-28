import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static String baseUrl = dotenv.env['BASE_URL']!;

  static String getAllProducts =
      '$baseUrl/api/products?populate[category][populate]=*&populate[images]=*';

  static String getProductById(int id) =>
      '$baseUrl/api/products/$id?populate[category][populate]=*&populate[images]=*';

  static String searchProducts(String query) =>
      '$baseUrl/api/products?filters[name][\$contains]=$query&populate[category][populate]=*&populate[images]=*';

  static String getAllProductsByCategory(int categoryId) =>
      '$baseUrl/api/products?filters[category][id][\$eq]=$categoryId&populate[category][populate]=*&populate[images]=*';

  static String getAllCategories = '$baseUrl/api/categories?populate=*';

  static String getAllBanners = '$baseUrl/api/banners?populate=*';

  static String login = '$baseUrl/api/auth/local';

  static String register = '$baseUrl/api/auth/local/register';

  static String getAllWishlist(int userId) =>
      '$baseUrl/api/wishlists?filters[userId][\$eq]=$userId';

  static String getWishlistByProductId(int userId, int productId) =>
      '$baseUrl/api/wishlists?filters[userId][\$eq]=$userId&filters[productId][\$eq]=$productId';

  static String addWishlist = '$baseUrl/api/wishlists';

  static String removeWishlist(int wishlistId) =>
      '$baseUrl/api/wishlists/$wishlistId';

  // === RajaOngkir ===

  static String rajaOngkirUrl = dotenv.env['RAJA_ONGKIR_URL']!;
  static String apiKeyRajaOngkir = dotenv.env['API_KEY_RAJA_ONGKIR']!;

  static String getAllCities(String provinceId) =>
      '$rajaOngkirUrl/starter/city?province=$provinceId';

  static String getAllCourier = '$rajaOngkirUrl/starter/cost';
}
