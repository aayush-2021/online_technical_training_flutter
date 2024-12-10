// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class User {
  final String id;
  final String name;
  final int age;
  final String dob;
  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.dob,
  });

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? dob,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      dob: dob ?? this.dob,
    );
  }
}

void someFunction() {
  User user = const User(id: '1', name: "Name", age: 20, dob: "20/10/1000");
  User newUser = user.copyWith(id: "2", age: 40);
  // why copyWith ?
}

// * Null Safety 