import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_03/user.dart';

final userStateProvider = StateProvider<User>((ref) {
  return const User(id: "2", name: "Rahul", age: 24, dob: "10/10/1000");
});

// State Notifier Provider

// 1. State class - User
// 2. StateNotifier class
class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(const User(id: "2", name: "Rahul", age: 24, dob: "10/10/1000"));

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void update({String? id, String? name, int? age, String? dob}) {
    state = state.copyWith(
      id: id,
      name: name,
      age: age,
      dob: dob,
    );
  }

  void updateAge(int age) {
    state = state.copyWith(age: age);
  }

  int doubleAge() {
    return state.age * 2;
  }
}

// 3. StateNotifierProvider
final userStateNotifierProvider =
    StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
