import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_03/providers.dart';
import 'package:session_03/user_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserScreen(),
    );
  }
}

var list = [{}, {}, {}, {}, {}, {}, {}, {}, {}];

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Screen"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(getProductProvider).when(
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                id: data[index]['id'],
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          image: data[index]['image'],
                          price: data[index]['price'],
                          title: data[index]['title'],
                          description: data[index]['description'],
                          category: data[index]['category'],
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return const Text("Something went wrong");
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Screen"),
      ),
      body: SafeArea(
        child: ref.watch(getProductByIdProvider(id.toString())).when(
              data: (data) {
                return ProductCard(
                  title: data['title'],
                  description: data['description'],
                  price: data['price'],
                  image: data['image'],
                  category: data['category'],
                );
              },
              error: (error, stackTrace) => const Text("Something went wrong!"),
              loading: () => const CircularProgressIndicator(),
            ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
  });
  final String title;
  final String description;
  final String image;
  final num price;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Image
          Image.network(
            image,
            width: 80,
          ),
          const SizedBox(width: 12),
          // Column
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "\$ ${price.toString()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        description,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      category,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentName = ref.watch(studentNameProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: ref.watch(getNameProvider).when(
                  data: (name) {
                    return Text(
                      "My name: $name",
                      style: const TextStyle(fontSize: 30),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Text(
                      "Got some error",
                      style: TextStyle(fontSize: 30),
                    );
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  ref.read(studentNameProvider.notifier).update(
                    (state) {
                      return value;
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // update the student name..
                },
                child: const Text("Change Name"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getName() async {
  var name = await Future.delayed(const Duration(seconds: 2), () => '');
  return name;
}

// Example of passing Subtype as an argument
class ParentClass {}

class ChildClass extends ParentClass {}

class Sample {
  Sample(this.parentClass);
  ParentClass parentClass;
}

var sample = Sample(ChildClass());
