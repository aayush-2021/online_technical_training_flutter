import 'package:firebase/user_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  final bool editFlag;

  const FormPage({super.key, this.editFlag = false});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  @override
  initState() {
    getUserDetails();
    super.initState();
  }

  Future<void> getUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    _nameController.text = data.data()?["name"] ?? '';
    _phoneController.text = data.data()?["phone"] ?? '';
    _ageController.text = data.data()?["age"].toString() ?? '';
  }

  Future<void> _addUserDetails(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'name': _nameController.text.trim(),
            'phone': _phoneController.text.trim(),
            'age': int.parse(_ageController.text.trim()),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Details Saved Successfully!')),
          );

          // Navigate to User List Page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserListPage()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              widget.editFlag == false ? "Add Details" : "Update Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value!.isEmpty ? "Name is required" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                validator: (value) =>
                    value!.isEmpty ? "Phone is required" : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (value) => value!.isEmpty ? "Age is required" : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _addUserDetails(context),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
