import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

Future<void> signInWithGitHub() async {
  final String url = 'https://github.com/login/oauth/authorize'
      '?client_id=${dotenv.env['GITHUB_CLIENT_ID']}'
      '&scope=repo,user';
  await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'http');
}
