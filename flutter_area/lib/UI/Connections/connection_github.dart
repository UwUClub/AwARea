import 'dart:convert';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

const String clientId = 'd373b5fe2e411c74b948';
const String clientSecret = '155580817cc512a05837beb6d7bdf6e8d080f265';
const String accessToken = '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';

Future<String> signInWithGitHub() async {
  // URL de l'authentification
  const String url = 'https://github.com/login/oauth/authorize'
      '?client_id=$clientId'
      '&scope=repo,user';

  final String result =
      await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'http');

  final String? code = Uri.parse(result).queryParameters['code'];

  // Obtenir le token
  final http.Response response = await http.post(
    Uri.parse('https://github.com/login/oauth/access_token'),
    headers: <String, String>{
      'Accept': 'application/json',
    },
    body: <String, String?>{
      'client_id': clientId,
      'client_secret': clientSecret,
      'code': code,
    },
  );

  // Parser le token
  // ignore: avoid_dynamic_calls
  final String token = jsonDecode(response.body)['access_token'] as String;
  return token;
  // Utiliser le token pour accéder à l'API GitHub
}
