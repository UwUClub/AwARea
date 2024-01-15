import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';
import '../Locator/locator.dart';
import 'user_manager.dart';

class GoogleManager {
  Future<GoogleSignInAccount?> openGoogleAuthPopup() async {
    const List<String> scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/gmail.addons.current.action.compose',
      'https://www.googleapis.com/auth/gmail.compose',
    ];

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );
    final GoogleSignInAccount? res = await googleSignIn.signIn();
    return res;
  }

  Future<bool> loginWithGoogle(
      String googleToken, String completeName, String email) async {
    final http.Response res = await http.post(
        Uri.parse('$kBaseUrl/auth/google-login'),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'accessToken': googleToken,
          'completeName': completeName,
          'email': email
        }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      final UserManager userManager = locator<UserManager>();
      userManager.storeUser(jsonBody['user'] as Map<String, dynamic>);
      userManager.storeAccessToken(jsonBody['accessToken'] as String);
      userManager.connectionsViewModel?.notify();
      return true;
    }
    return false;
  }

  Future<void> setGoogleToken(String googleToken) async {
    final UserManager userManager = locator<UserManager>();
    final http.Response res =
        await http.post(Uri.parse('$kBaseUrl/users/google-token'),
            headers: <String, String>{
              'accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${userManager.accessToken}',
            },
            body: jsonEncode(<String, String>{'googleToken': googleToken}));
    if (res.statusCode != 201) {
      return;
    }
    userManager.isGoogleLogged = googleToken != 'none';
    userManager.connectionsViewModel?.notify();
  }

  Future<bool> createDraft(String name, String email) async {
    try {
      final UserManager userManager = locator<UserManager>();
      final http.Response res =
          await http.post(Uri.parse('$kBaseUrl/action-reaction/mvp'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${userManager.accessToken}',
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
}
