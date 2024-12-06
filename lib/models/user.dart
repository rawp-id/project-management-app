import 'package:project_app/services/api.dart';

class User {
  final ApiService apiService = ApiService();

  int? id;
  String? username;
  String? password;
  String? role;
  int? isLdapUser;
  String? name;
  String? email;
  String? avatarPath;

  User({
    this.id,
    this.username,
    this.password,
    this.role,
    this.isLdapUser,
    this.name,
    this.email,
    this.avatarPath,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      isLdapUser: json['is_ldap_user'],
      name: json['name'],
      email: json['email'],
      avatarPath: json['avatar_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'is_ldap_user': isLdapUser,
      'name': name,
      'email': email,
      'avatar_path': avatarPath,
    };
  }

  Future<List<User>> getUser() async {
    final result = await apiService.getUserByName();

    // print(result.runtimeType);
    // print(result);

    if (result is Map<String, dynamic>) {
      return [User.fromJson(result)];
    } else if (result is List) {
      return result.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
