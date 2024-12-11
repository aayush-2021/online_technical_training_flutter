class UserModel {
  String name;
  String email;
  String phone;
  int age;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'age': this.age,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      age: map['age'] as int,
    );
  }
}
