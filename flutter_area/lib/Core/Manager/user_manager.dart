import 'dart:convert';

import 'package:http/http.dart' as http;

class UserManager {
  String? username;
  String? fullName;
  String? email;
  String? accessToken;

  void signUp(String email, String password, String username, String fullName) {
    print('signup $email $password $username $fullName');
    http
        .post(Uri.parse('http://localhost:8080/auth/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
              'username': username,
              'fullName': fullName
            }))
        .then((http.Response res) {
      print(res.body);
      if (res.statusCode == 201) {
        _storeData(jsonDecode(res.body));
        print('signUp success $username $fullName $email $accessToken');
      } else {
        print('signUp failed');
      }
    });
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
        _storeData(jsonDecode(res.body));
        print('login success $username $fullName $email $accessToken');
      } else {
        print('login failed');
      }
    });
  }

  void _storeData(dynamic jsonBody) {
    final Map<String, dynamic> body = jsonBody as Map<String, dynamic>;
    final Map<String, dynamic> user = body['user'] as Map<String, dynamic>;
    username = user['username'] as String;
    fullName = user['fullName'] as String;
    email = user['email'] as String;
    accessToken = body['accessToken'] as String;
  }
}
