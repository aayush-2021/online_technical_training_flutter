import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/form_page.dart';
import 'package:firebase/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchProvider = StateProvider<String>((ref) {
  return '';
});

final ageDescendingProvider = StateProvider<bool>((ref) {
  return false;
});

class UserListPage extends ConsumerWidget {
  UserListPage({super.key});
  final searchController = TextEditingController();

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getUsersList(
      WidgetRef ref) async {
    // String sortBy = ref.watch(ageSortProvider) ? "asc" : "desc";

    if (ref.watch(searchProvider).isEmpty) {
      return FirebaseFirestore.instance
          .collection('users')
          .orderBy('age', descending: ref.watch(ageDescendingProvider))
          .get();
    }

    return FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: ref.watch(searchProvider))
        .orderBy('age', descending: ref.watch(ageDescendingProvider))
        // isLessThanOrEqualTo: ref.watch(searchProvider)
        // arrayContainsAny: [ref.watch(searchProvider)],
        // whereIn: [ref.watch(searchProvider)],
        .get();
  }
  // TODO: share the `in` equivalent in the code..

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FormPage(
                          editFlag: true,
                        )),
              )
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // * -- Search Bar --
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search by name',
                    ),
                    controller: searchController,
                    onChanged: (value) {
                      ref
                          .read(searchProvider.notifier)
                          .update((state) => value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .watch(ageDescendingProvider.notifier)
                        .update((state) => !state);
                  
                  },
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          // * -- Users List  --
          FutureBuilder<QuerySnapshot>(
            future: _getUsersList(ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching users.'));
              }
              final users = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text("Name: ${user['name']}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone: ${user['phone']}"),
                            Text("Age: ${user['age']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
