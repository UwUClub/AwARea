import 'package:flutter_web_auth/flutter_web_auth.dart';

const String clientId = 'd373b5fe2e411c74b948';
const String accessToken = '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';

Future<void> signInWithGitHub() async {
  // URL de l'authentification
  const String url = 'https://github.com/login/oauth/authorize'
      '?client_id=$clientId'
      '&scope=repo,user';
  await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'http');

  // Parser le token
  // ignore: avoid_dynamic_calls
  // Utiliser le token pour accéder à l'API GitHub
}
