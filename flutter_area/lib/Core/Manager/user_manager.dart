import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

import '../../Utils/mk_print.dart';

class UserManager {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;
  String? githubToken;

  Future<(bool, String?)> signUp(
      String email, String password, String username, String fullName) async {
    try {
      final http.Response res = await http.post(
          Uri.parse('http://localhost:8080/auth/register'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json',
            'Access-Control-Allow-Origin': '*'
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
      // ignore: avoid_dynamic_calls
      return (false, _parseErrorMessage(jsonBody['message']));
    } catch (e) {
      mkPrint('Error: $e');
      return (false, e.toString());
    }
  }

  Future<(bool, String?)> login(String usernameOrEmail, String password) async {
    final http.Response res = await http.post(
        Uri.parse('http://localhost:8080/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode(<String, String>{
          'usernameOrEmail': usernameOrEmail,
          'password': password
        }));
    mkPrint(res.body);
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      _storeData(jsonBody);
      return (true, null);
    }
    // ignore: avoid_dynamic_calls
    return (false, _parseErrorMessage(jsonBody['message']));
  }

  Future<bool> loginWithGoogle(
      String accessToken, String completeName, String email) async {
    final http.Response res = await http.post(
        Uri.parse('http://localhost:8080/auth/google-login'),
        headers: <String, String>{
          'accept': 'application/json',
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

  Future<bool> createDraft(String name, String email) async {
    try {
      final http.Response res = await http.post(
          Uri.parse('http://localhost:8080/action-reaction/mvp'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Bearer': accessToken!,
          },
          body: jsonEncode(<String, String>{'name': name, 'email': email}));
      mkPrint(res.body);
      if (res.statusCode == 201) {
        return true;
      }
    } catch (e) {
      mkPrint('Error: $e');
    }
    return false;
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
