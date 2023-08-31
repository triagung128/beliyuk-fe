import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:beliyuk/data/database/database_helper.dart';
import 'package:beliyuk/data/datasources/local/address_local_data_source.dart';
import 'package:beliyuk/data/datasources/local/auth_local_data_source.dart';
import 'package:beliyuk/data/datasources/local/cart_local_data_source.dart';
import 'package:beliyuk/data/datasources/remote/address_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/auth_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/banner_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/category_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/courier_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/transaction_remote_data_source.dart';
import 'package:beliyuk/data/datasources/remote/wishlist_remote_data_source.dart';
import 'package:beliyuk/data/repositories/address_repository_impl.dart';
import 'package:beliyuk/data/repositories/auth_repository_impl.dart';
import 'package:beliyuk/data/repositories/banner_repository_impl.dart';
import 'package:beliyuk/data/repositories/cart_repository_impl.dart';
import 'package:beliyuk/data/repositories/category_repository_impl.dart';
import 'package:beliyuk/data/repositories/courier_repository_impl.dart';
import 'package:beliyuk/data/repositories/product_repository_impl.dart';
import 'package:beliyuk/data/repositories/transaction_repository_impl.dart';
import 'package:beliyuk/data/repositories/wishlist_repository_impl.dart';
import 'package:beliyuk/domain/repositories/address_repository.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';
import 'package:beliyuk/domain/repositories/banner_repository.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';
import 'package:beliyuk/domain/repositories/category_repository.dart';
import 'package:beliyuk/domain/repositories/courier_repository.dart';
import 'package:beliyuk/domain/repositories/product_repository.dart';
import 'package:beliyuk/domain/repositories/transaction_repository.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';
import 'package:beliyuk/domain/usecases/address/get_all_cities.dart';
import 'package:beliyuk/domain/usecases/address/get_all_provinces.dart';
import 'package:beliyuk/domain/usecases/auth/get_auth.dart';
import 'package:beliyuk/domain/usecases/auth/login.dart';
import 'package:beliyuk/domain/usecases/auth/register.dart';
import 'package:beliyuk/domain/usecases/auth/remove_auth.dart';
import 'package:beliyuk/domain/usecases/auth/save_auth.dart';
import 'package:beliyuk/domain/usecases/banner/get_all_banners.dart';
import 'package:beliyuk/domain/usecases/cart/add_cart.dart';
import 'package:beliyuk/domain/usecases/cart/add_quantity.dart';
import 'package:beliyuk/domain/usecases/cart/delete_all_carts.dart';
import 'package:beliyuk/domain/usecases/cart/get_all_carts.dart';
import 'package:beliyuk/domain/usecases/cart/get_cart_by_id.dart';
import 'package:beliyuk/domain/usecases/cart/reduce_quantity.dart';
import 'package:beliyuk/domain/usecases/cart/remove_cart.dart';
import 'package:beliyuk/domain/usecases/category/get_all_categories.dart';
import 'package:beliyuk/domain/usecases/courier/get_cost.dart';
import 'package:beliyuk/domain/usecases/product/get_all_products.dart';
import 'package:beliyuk/domain/usecases/product/get_all_products_by_category.dart';
import 'package:beliyuk/domain/usecases/product/get_product_by_id.dart';
import 'package:beliyuk/domain/usecases/product/search_products.dart';
import 'package:beliyuk/domain/usecases/transaction/create_transaction.dart';
import 'package:beliyuk/domain/usecases/transaction/get_all_transactions.dart';
import 'package:beliyuk/domain/usecases/wishlist/add_wishlist.dart';
import 'package:beliyuk/domain/usecases/wishlist/get_all_wishlists.dart';
import 'package:beliyuk/domain/usecases/wishlist/get_wishlist_by_product_id.dart';
import 'package:beliyuk/domain/usecases/wishlist/remove_wishlist.dart';
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/blocs/category/category_bloc.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/blocs/detail_product/detail_product_bloc.dart';
import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';
import 'package:beliyuk/presentation/blocs/main/main_bloc.dart';
import 'package:beliyuk/presentation/blocs/search_product/search_product_bloc.dart';
import 'package:beliyuk/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:beliyuk/presentation/blocs/wishlist/wishlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchProductBloc(searchProducts: locator()),
  );
  locator.registerFactory(
    () => CategoryBloc(getAllProductsByCategory: locator()),
  );
  locator.registerFactory(
    () => HomeBloc(
      getAllBanners: locator(),
      getAllCategories: locator(),
      getAllProducts: locator(),
    ),
  );
  locator.registerFactory(
    () => AuthBloc(
      getAuth: locator(),
      login: locator(),
      register: locator(),
      removeAuth: locator(),
      saveAuth: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailProductBloc(
      getAuth: locator(),
      addWishlist: locator(),
      getProductById: locator(),
      getWishlistByProductId: locator(),
      removeWishlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WishlistBloc(
      getAllWishlists: locator(),
      getAuth: locator(),
      removeWishlist: locator(),
    ),
  );
  locator.registerFactory(
    () => CartBloc(
      addCart: locator(),
      addQuantity: locator(),
      deleteAllCarts: locator(),
      getAllCarts: locator(),
      getCartById: locator(),
      reduceQuantity: locator(),
      removeCart: locator(),
    ),
  );
  locator.registerFactory(
    () => CheckoutBloc(
      getAllProvinces: locator(),
      getAllCities: locator(),
      getCost: locator(),
    ),
  );
  locator.registerFactory(
    () => TransactionBloc(
      getAuth: locator(),
      getAllTransactions: locator(),
      createTransaction: locator(),
    ),
  );
  locator.registerFactory(
    () => MainBloc(getAuth: locator()),
  );

  // usecase
  locator.registerLazySingleton(() => GetAllProducts(locator()));
  locator.registerLazySingleton(() => GetAllProductsByCategory(locator()));
  locator.registerLazySingleton(() => GetProductById(locator()));
  locator.registerLazySingleton(() => SearchProducts(locator()));
  locator.registerLazySingleton(() => GetAllCategories(locator()));
  locator.registerLazySingleton(() => GetAllBanners(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => GetAuth(locator()));
  locator.registerLazySingleton(() => SaveAuth(locator()));
  locator.registerLazySingleton(() => RemoveAuth(locator()));
  locator.registerLazySingleton(() => GetAllWishlists(locator()));
  locator.registerLazySingleton(() => GetWishlistByProductId(locator()));
  locator.registerLazySingleton(() => AddWishlist(locator()));
  locator.registerLazySingleton(() => RemoveWishlist(locator()));
  locator.registerLazySingleton(() => AddCart(locator()));
  locator.registerLazySingleton(() => AddQuantity(locator()));
  locator.registerLazySingleton(() => DeleteAllCarts(locator()));
  locator.registerLazySingleton(() => GetAllCarts(locator()));
  locator.registerLazySingleton(() => GetCartById(locator()));
  locator.registerLazySingleton(() => ReduceQuantity(locator()));
  locator.registerLazySingleton(() => RemoveCart(locator()));
  locator.registerLazySingleton(() => GetAllProvinces(locator()));
  locator.registerLazySingleton(() => GetAllCities(locator()));
  locator.registerLazySingleton(() => GetCost(locator()));
  locator.registerLazySingleton(() => CreateTransaction(locator()));
  locator.registerLazySingleton(() => GetAllTransactions(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CourierRepository>(
    () => CourierRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(remoteDataSource: locator()),
  );

  // datasource
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<BannerRemoteDataSource>(
    () => BannerRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<AddressLocalDataSource>(
    () => AddressLocalDataSourceImpl(),
  );
  locator.registerLazySingleton<AddressRemoteDataSource>(
    () => AddressRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<CourierRemoteDataSource>(
    () => CourierRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TransactionRemoteDataSource>(
    () => TransactionRemoteDataSourceImpl(client: locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DatabaseHelper());
}
