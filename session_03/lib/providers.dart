// 6 types of Providers

// 1. Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_03/api_call.dart';

final nameProvider = Provider<String>((ref) {
  return 'Aayush';
});

// Use case -> Dependency Injection ( Provide value to a class from outside rather than creating the object in the class itself )

// 2. State Provider
final studentNameProvider = StateProvider<String>((ref) {
  return 'Rahul';
});

// 3. Future Provider / Async Provider
final getNameProvider = FutureProvider<String>((ref) async {
  return Future.delayed(const Duration(seconds: 5), () => 'Aayush');
});

final getProductProvider = FutureProvider((ref) async {
  var product = await getProducts();
  return product;
});

final getProductByIdProvider =
    FutureProvider.family<dynamic, String>((ref, id) async {
  var product = await getProductById(id);
  return product;
});

// 4. State Notifier Provider
// 5. Change Notifier Provider
// 6. Stream Provider












// Dependency Injection Example
class A {}

class Sample {
  Sample(this.a);
  A a;
}
