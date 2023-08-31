import 'package:beliyuk/env/env.dart';

class Urls {
  static String baseUrl = Env.baseUrl;

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
      '$baseUrl/api/wishlists?sort=id:desc&filters[userId][\$eq]=$userId';

  static String getWishlistByProductId(int userId, int productId) =>
      '$baseUrl/api/wishlists?filters[userId][\$eq]=$userId&filters[productId][\$eq]=$productId';

  static String addWishlist = '$baseUrl/api/wishlists';

  static String removeWishlist(int wishlistId) =>
      '$baseUrl/api/wishlists/$wishlistId';

  static String createOrder = '$baseUrl/api/orders';

  static String getAllOrders(int userId) =>
      '$baseUrl/api/orders?sort=id:desc&filters[userId][\$eq]=$userId';

  // === RajaOngkir ===

  static String rajaOngkirUrl = Env.rajaOngkirUrl;
  static String apiKeyRajaOngkir = Env.rajaOngkirApiKey;

  static String getAllCities(String provinceId) =>
      '$rajaOngkirUrl/starter/city?province=$provinceId';

  static String getAllCourier = '$rajaOngkirUrl/starter/cost';
}
