import 'dart:convert';

class User {
  String user;
  String password;
  List modelData;
  String image;

  User({
    required this.user,
    required this.password,
    required this.modelData,
    required this.image,
  });

  static User fromMap(Map<String, dynamic> user) {
    return new User(
      user: user['user'],
      password: user['password'],
      modelData: jsonDecode(user['model_data']),
      image: user['image'],
    );
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'model_data': jsonEncode(modelData),
      'image': image,
    };
  }
}
