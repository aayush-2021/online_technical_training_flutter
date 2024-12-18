import 'package:session_05/core/api_client.dart';
import 'package:session_05/core/check_connection.dart';
import 'package:session_05/features/products/domain/product_model.dart';
import 'package:session_05/features/products/domain/product_repository.dart';

// Get the data from the datasource depending on codition (for example: Internet Connection)

class ProductRepoImpl extends ProductRepository {
  final ApiClient apiClient;
  ProductRepoImpl(this.apiClient);

  @override
  Future<ProductModel?> addProduct(ProductModel product) async {
    if (await checkInternetConnection()) {
      // Api call
      var result = await apiClient.post('products', data: product.toJson());
      return ProductModel.fromJson(result);
    } else {
      // call to Local DB
    }
    return null;
  }

  @override
  Future<ProductModel?> deleteProduct(int id) async {
    if (await checkInternetConnection()) {
      // Api call
      var result = await apiClient.delete('products/$id');
      return ProductModel.fromJson(result);
    } else {
      // call to Local DB
    }
    return null;
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    if (await checkInternetConnection()) {
      // Api call
      var result = await apiClient.get('products');
      List<ProductModel>.from(
          (result as List).map((e) => ProductModel.fromJson(e)));
    } else {
      // call to Local DB
    }
    return [];
  }

  @override
  Future<ProductModel?> updateProduct(ProductModel product) async {
    if (await checkInternetConnection()) {
      // Api call
      var result = await apiClient.post('products/${product.id}',
          data: product.toJson());
      return ProductModel.fromJson(result);
    } else {
      // call to Local DB
    }
    return null;
  }
}
