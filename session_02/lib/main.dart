import 'package:flutter/material.dart';
import 'package:session_02/app_router.dart';
import 'package:go_router/go_router.dart';

class Sample {
  void someFunction() {
    print(4 + 5);
    // does some operation
  }
}

void main() {
  var sample = Sample();
  sample.someFunction();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
      // home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: const SizedBox(),
      //   title: const Text("Home Screen"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  DetailsRoute(name: 'Razak').push(context);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) => const DetailsScreen(),
                  //   ),
                  // );
                },
                child: const Text("Go to 2nd Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Screen"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text("Name : $name"),
              ),
              ElevatedButton(
                onPressed: () {
                  Details2Route().push(context);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) => const DetailsScreen2(),
                  //   ),
                  // );
                },
                child: const Text("Go to Details Screen 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  // Navigator.of(context).pop();
                },
                child: const Text("Go back"), // Go back to the Home Screen
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsScreen2 extends StatelessWidget {
  const DetailsScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Screen 2 "),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text("Details Screen 2"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text("Go back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
