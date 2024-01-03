import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';

class UserManager {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;
  String? githubToken;

  AuthStateEnum state = AuthStateEnum.splash;

  Future<(bool, String?)> signUp(
      String email, String password, String username, String fullName) async {
    try {
      final http.Response res = await http.post(
          Uri.parse('$kBaseUrl/auth/register'),
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
    final http.Response res = await http.post(Uri.parse('$kBaseUrl/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'Access-Control-Allow-Origin': '*'
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
    // ignore: avoid_dynamic_calls
    return (false, _parseErrorMessage(jsonBody['message']));
  }

  Future<bool> loginWithGoogle(
      String accessToken, String completeName, String email) async {
    final http.Response res = await http.post(
        Uri.parse('$kBaseUrl/auth/google-login'),
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

  Future<bool> getCurrentUser(String accessToken) async {
    final http.Response res = await http.get(
      Uri.parse('$kBaseUrl/users/me'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      _storeData(jsonBody, haveToken: true);
      return true;
    }
    return false;
  }

  Future<void> _storeData(dynamic jsonBody, {bool haveToken = false}) async {
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    try {
      final SharedPreferences prefs = await prefsF;
      final Map<String, dynamic> body = jsonBody as Map<String, dynamic>;
      if (!haveToken) {
        final Map<String, dynamic> user = body['user'] as Map<String, dynamic>;
        username = user['username'] as String?;
        fullName = user['fullName'] as String;
        email = user['email'] as String;
        accessToken = body['accessToken'] as String;
        prefs.setString('accessToken', accessToken!);
      } else {
        username = body['username'] as String?;
        fullName = body['fullName'] as String;
        email = body['email'] as String;
        accessToken = prefs.getString('accessToken');
      }
    } catch (e) {
      mkPrint('Error: $e');
    }
  }

  Future<bool> createDraft(String name, String email) async {
    try {
      final http.Response res =
          await http.post(Uri.parse('$kBaseUrl/action-reaction/mvp'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $accessToken',
              },
              body: jsonEncode(<String, String>{'name': name, 'email': email}));
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

enum AuthStateEnum { authenticated, unauthenticated, splash }
