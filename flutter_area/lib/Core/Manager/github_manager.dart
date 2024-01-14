import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';
import '../Locator/locator.dart';
import 'user_manager.dart';

class GithubManager {
  Future<void> signInWithGitHub() async {
    final String url = 'https://github.com/login/oauth/authorize'
        '?client_id=${dotenv.env['GITHUB_CLIENT_ID']}'
        '&scope=repo,user';
    await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: 'http');
  }

  Future<void> signOutFromGitHub() async {
    final UserManager userManager = locator<UserManager>();
    final http.Response response = await http.post(
        Uri.parse(
          '$kBaseUrl/users/github-token',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userManager.accessToken}',
        },
        body: jsonEncode(<String, String>{'githubToken': 'none'}));
    if (response.statusCode == 201) {
      userManager.isGithubLogged = false;
      userManager.connectionsViewModel?.notify();
    }
  }
}
