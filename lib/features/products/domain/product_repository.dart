import 'package:session_05/features/products/domain/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel?> addProduct(ProductModel product);
  Future<ProductModel?> updateProduct(ProductModel product);
  Future<ProductModel?> deleteProduct(int id);
}
