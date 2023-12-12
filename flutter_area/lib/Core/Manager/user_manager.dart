import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserManager {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;

  void signUp() {
    print('signup');
  }

  void login(String usernameOrEmail, String password) {
    print('login $usernameOrEmail $password');
    http
        .post(Uri.parse('http://localhost:8080/auth/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'usernameOrEmail': usernameOrEmail,
              'password': password
            }))
        .then((http.Response res) {
      if (res.statusCode == 201) {
        final Map<String, dynamic> body =
            jsonDecode(res.body) as Map<String, dynamic>;
        final Map<String, dynamic> user = body['user'] as Map<String, dynamic>;
        username = user['username'] as String;
        fullName = user['fullName'] as String;
        email = user['email'] as String;
        accessToken = body['accessToken'] as String;
        print('login success $username $fullName $email $accessToken');
      } else {
        print('login failed');
      }
    });
  }
}
