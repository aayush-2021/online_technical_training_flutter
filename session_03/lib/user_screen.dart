import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_03/user_provider.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(userStateNotifierProvider).name,
              style: const TextStyle(fontSize: 40),
            ),
            Text(
              ref.watch(userStateNotifierProvider).age.toString(),
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                ref
                    .watch(userStateNotifierProvider.notifier)
                    .updateName('Ritesh');
              },
              child: const Text("Update User"),
            ),
            ElevatedButton(
              onPressed: () {
                ref.watch(userStateNotifierProvider.notifier).updateAge(20);
                int result =
                    ref.watch(userStateNotifierProvider.notifier).doubleAge();
                print("Result: $result");
              },
              child: const Text("Update Age"),
            ),
          ],
        ),
      ),
    );
  }
}
