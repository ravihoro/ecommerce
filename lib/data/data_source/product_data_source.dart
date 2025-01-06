import 'package:ecommerce/core/constants.dart';
import 'package:ecommerce/core/helper_functions.dart';
import 'package:http/http.dart' as http;

abstract class ProductDataSource {
  Future<List<String>> getCategories();

  Future<List<Map<String, dynamic>>> getAllProducts();

  Future<List<Map<String, dynamic>>> getProductsByCategory(String category);
}

class RemoteProductDataSource implements ProductDataSource {
  final http.Client _client;

  const RemoteProductDataSource(this._client);

  @override
  Future<List<Map<String, dynamic>>> getAllProducts() {
    return getCall(
      _client,
      BASE_URL,
      (json) => List<Map<String, dynamic>>.from(json),
    );
  }

  @override
  Future<List<String>> getCategories() {
    return getCall(
      _client,
      "$BASE_URL/categories",
      (json) => List<String>.from(json),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) {
    return getCall(
      _client,
      "$BASE_URL/category/$category",
      (json) => List<Map<String, dynamic>>.from(json),
    );
  }
}
