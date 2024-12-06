import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = 'https://manage.kriingg.com/jsonrpc.php';
  final String? username;
  final String? password;

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  ApiService({this.username, this.password});

  Future<bool> auth(String username, String password) async {
    try {
      String encodedAuth = base64Encode(utf8.encode('$username:$password'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": "getMyProjects",
        "id": 1,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('error')) {
            throw Exception('Error: ${jsonResponse['error']}');
          }
          await _storage.write(key: 'username', value: username);
          await _storage.write(key: 'password', value: password);
          print('Credentials saved securely');
          return true;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  // Future<dynamic> sendRequest(String method,
  //     {Map<String, dynamic>? params}) async {
  //   try {
  //     String? storedUsername = username ?? await _storage.read(key: 'username');
  //     String? storedPassword = password ?? await _storage.read(key: 'password');

  //     print(params.runtimeType);

  //     if (storedUsername == null || storedPassword == null) {
  //       throw Exception('User not logged in.');
  //     }

  //     String encodedAuth =
  //         base64Encode(utf8.encode('$storedUsername:$storedPassword'));

  //     final requestBody = {
  //       "jsonrpc": "2.0",
  //       "method": method,
  //       "id": 1,
  //       "params": params ?? {},
  //     };

  //     print(requestBody.runtimeType);

  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Basic $encodedAuth",
  //       },
  //       body: json.encode(requestBody),
  //     );

  //     // print('Response: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final dynamic jsonResponse = json.decode(response.body);
  //       if (jsonResponse is Map<String, dynamic>) {
  //         if (jsonResponse.containsKey('error')) {
  //           throw Exception('Error: ${jsonResponse['error']}');
  //         }
  //         final result = jsonResponse['result'];
  //         print('Result type: ${result.runtimeType}');
  //         if (result is Map<String, dynamic>) {
  //           return result; // Or modify to match the expected type
  //         } else if (result is List<dynamic>) {
  //           return result;
  //         } else {
  //           throw Exception('Unexpected result type: ${result.runtimeType}');
  //         }
  //       } else {
  //         throw Exception('Unexpected response format');
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to connect to the server: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     rethrow;
  //   }
  // }

  Future<dynamic> sendRequest(String method,
      {Map<String, dynamic>? params}) async {
    try {
      String? storedUsername = username ?? await _storage.read(key: 'username');
      String? storedPassword = password ?? await _storage.read(key: 'password');

      if (storedUsername == null || storedPassword == null) {
        throw Exception('User not logged in.');
      }

      String encodedAuth =
          base64Encode(utf8.encode('$storedUsername:$storedPassword'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": method,
        "id": 1,
        "params": params ?? {},
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('error')) {
            throw Exception('Error: ${jsonResponse['error']}');
          }
          final result = jsonResponse['result'];
          if (result is Map<String, dynamic> || result is List<dynamic>) {
            return result;
          } else {
            throw Exception('Unexpected result type: ${result.runtimeType}');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<dynamic> getUserByName() async {
    try {
      String? storedUsername = username ?? await _storage.read(key: 'username');
      String? storedPassword = password ?? await _storage.read(key: 'password');

      // print(storedUsername);

      if (storedUsername == null || storedPassword == null) {
        throw Exception('User not logged in.');
      }

      String encodedAuth =
          base64Encode(utf8.encode('$storedUsername:$storedPassword'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": "getUserByName",
        "id": 1,
        "params": {
          "username": storedUsername,
        },
      };

      // print(requestBody);

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      // print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('error')) {
            throw Exception('Error: ${jsonResponse['error']}');
          }
          final result = jsonResponse['result'];
          if (result is Map<String, dynamic> || result is List<dynamic>) {
            return result;
          } else {
            throw Exception('Unexpected result type: ${result.runtimeType}');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<dynamic> getProjectById(int? id) async {
    try {
      String? storedUsername = username ?? await _storage.read(key: 'username');
      String? storedPassword = password ?? await _storage.read(key: 'password');

      // print(storedUsername);

      if (storedUsername == null || storedPassword == null) {
        throw Exception('User not logged in.');
      }

      String encodedAuth =
          base64Encode(utf8.encode('$storedUsername:$storedPassword'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": "getProjectById",
        "id": 1,
        "params": {"project_id": id},
      };

      // print(requestBody);

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      // print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('error')) {
            throw Exception('Error: ${jsonResponse['error']}');
          }
          final result = jsonResponse['result'];
          if (result is Map<String, dynamic> || result is List<dynamic>) {
            return result;
          } else {
            throw Exception('Unexpected result type: ${result.runtimeType}');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<dynamic> getTaskByProject(int? id) async {
    try {
      String? storedUsername = username ?? await _storage.read(key: 'username');
      String? storedPassword = password ?? await _storage.read(key: 'password');

      // print(storedUsername);

      if (storedUsername == null || storedPassword == null) {
        throw Exception('User not logged in.');
      }

      String encodedAuth =
          base64Encode(utf8.encode('$storedUsername:$storedPassword'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": "getAllTasks",
        "id": 1,
        "params": {"project_id": id, "status_id": 1},
      };

      // print(requestBody);

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      // print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          if (jsonResponse.containsKey('error')) {
            throw Exception('Error: ${jsonResponse['error']}');
          }
          final result = jsonResponse['result'];
          if (result is Map<String, dynamic> || result is List<dynamic>) {
            return result;
          } else {
            throw Exception('Unexpected result type: ${result.runtimeType}');
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<Future> request(String method, Array? params) async {
    try {
      String? storedUsername = username ?? await _storage.read(key: 'username');
      String? storedPassword = password ?? await _storage.read(key: 'password');

      if (storedUsername == null || storedPassword == null) {
        throw Exception('User not logged in.');
      }

      String encodedAuth =
          base64Encode(utf8.encode('$storedUsername:$storedPassword'));

      final requestBody = {
        "jsonrpc": "2.0",
        "method": method,
        "id": 1,
        "params": params,
      };

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $encodedAuth",
        },
        body: json.encode(requestBody),
      );

      // print('Response: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to connect to the server: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }

  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
    print('Credentials saved securely');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
    print('Logged out successfully');
  }

  Future<bool> isLoggedIn() async {
    String? username = await _storage.read(key: 'username');
    String? password = await _storage.read(key: 'password');
    return username != null && password != null;
  }

  Future<String> getUsername() async {
    return await _storage.read(key: 'username') ?? '';
  }
}
