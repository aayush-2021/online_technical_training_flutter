import 'package:dio/dio.dart';

Future getProducts() async {
  Dio dio = Dio();
  var result = await dio.get('https://fakestoreapi.com/products');
  return result.data;
}

Future getProductById(String id) async {
  Dio dio = Dio();
  var result = await dio.get('https://fakestoreapi.com/products/$id');
  return result.data;
}
