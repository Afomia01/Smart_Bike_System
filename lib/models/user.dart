class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String password;

  UserModel({required this.uid, required this.name, required this.phone, required this.email, required this.password});

  // Convert User object to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    };
  }

  // Create User object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
    );
  }
}
