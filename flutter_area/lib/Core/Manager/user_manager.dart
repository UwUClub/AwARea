import 'dart:convert';
import 'package:http/http.dart' as http;


class UserManager {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;
  String? githubToken;

  Future<(bool, String?)> signUp(
      String email, String password, String username, String fullName) async {
    final http.Response res = await http.post(
        Uri.parse('http://localhost:8080/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'username': username,
          'fullName': fullName
        }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      _storeData(jsonBody);
      return (true, null);
    }
    return (false, _parseErrorMessage(jsonBody['message']));
  }

  Future<(bool, String?)> login(String usernameOrEmail, String password) async {
    final http.Response res = await http.post(
        Uri.parse('http://localhost:8080/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'usernameOrEmail': usernameOrEmail,
          'password': password
        }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      _storeData(jsonBody);
      return (true, null);
    }
    return (false, _parseErrorMessage(jsonBody['message']));
  }

  Future<bool> loginWithGoogle(
      String accessToken, String completeName, String email) async {
    final http.Response res = await http.post(
        Uri.parse('http://localhost:8080/auth/google-login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'accessToken': accessToken,
          'completeName': completeName,
          'email': email
        }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      _storeData(jsonBody);
      return true;
    }
    return false;
  }

  void _storeData(dynamic jsonBody) {
    final Map<String, dynamic> body = jsonBody as Map<String, dynamic>;
    final Map<String, dynamic> user = body['user'] as Map<String, dynamic>;
    username = user['username'] as String?;
    fullName = user['fullName'] as String;
    email = user['email'] as String;
    accessToken = body['accessToken'] as String;
  }

  Future<(bool, String?)> _storeGithubToken(void) async {
    
    githubToken = token;
  }

  String? _parseErrorMessage(dynamic msg) {
    if (msg is String) {
      return msg;
    }
    if (msg is List) {
      return msg.join(', ');
    }
    return null;
  }
}
