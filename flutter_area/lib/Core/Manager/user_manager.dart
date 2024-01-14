import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';

class UserManager extends ChangeNotifier {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;
  bool? isGoogleLogged;
  bool? isGithubLogged;

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
        storeData(jsonBody);
        return (true, null);
      }
      // ignore: avoid_dynamic_calls
      return (false, parseErrorMessage(jsonBody['message']));
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
      storeData(jsonBody);
      return (true, null);
    }
    // ignore: avoid_dynamic_calls
    return (false, parseErrorMessage(jsonBody['message']));
  }

  Future<bool> getCurrentUser(String accessToken) async {
    try {
      final http.Response res = await http.get(
        Uri.parse('$kBaseUrl/users/me'),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      mkPrint(res.statusCode);
      if (res.statusCode == 200) {
        final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
        await storeData(jsonBody, haveToken: true);
        return true;
      }
    } catch (e) {
      mkPrint('Error: $e');
    }
    return false;
  }

  Future<void> logout() async {
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefsF;
    prefs.remove('accessToken');
    username = null;
    fullName = null;
    email = null;
    accessToken = null;
    state = AuthStateEnum.splash;
  }

  Future<void> storeData(dynamic jsonBody, {bool haveToken = false}) async {
    final Future<SharedPreferences> prefsF = SharedPreferences.getInstance();
    try {
      final SharedPreferences prefs = await prefsF;
      final Map<String, dynamic> body = jsonBody as Map<String, dynamic>;
      if (!haveToken) {
        accessToken = body['accessToken'] as String;
        prefs.setString('accessToken', accessToken!);
      } else {
        accessToken = prefs.getString('accessToken');
      }
      if (body['user'] != null && body['user']['username'] != null) {
        final Map<String, dynamic> user = body['user'] as Map<String, dynamic>;
        username = user['username'] as String?;
        fullName = user['fullName'] as String;
        email = user['email'] as String;
        isGoogleLogged = user['isLoggedInGoogle'] as bool;
        isGithubLogged = user['isLoggedInGithub'] as bool;
      }
      print('$isGoogleLogged $isGithubLogged');
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

  String? parseErrorMessage(dynamic msg) {
    if (msg is String) {
      return msg;
    }
    if (msg is List) {
      return msg.join(', ');
    }
    return null;
  }

  void notify() {
    notifyListeners();
  }
}

enum AuthStateEnum { authenticated, unauthenticated, splash }
