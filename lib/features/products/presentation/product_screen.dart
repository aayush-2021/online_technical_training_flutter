import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:session_05/core/api_client.dart';
import 'package:session_05/features/products/data/product_repo_impl.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  late ProductRepoImpl productRepo;

  @override
  void initState() {
    super.initState();
    productRepo = ProductRepoImpl(ref.read(apiClientProvider));
    productRepo.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}


// Stateless Widget -> ConsumerWidget
// Statefull Widget -> ConsumerStatefulWidget