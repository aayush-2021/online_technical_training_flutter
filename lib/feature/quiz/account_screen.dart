import 'package:flutter/material.dart';
import 'package:quiz_app/core/local_db.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                await DatabaseHelper.instance.insertSampleData();
              },
              child: const Text("Inser Sample Data"),
            ),
          ],
        ),
      ),
    );
  }
}
