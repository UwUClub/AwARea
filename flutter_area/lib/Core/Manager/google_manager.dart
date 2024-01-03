import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';
import '../../Utils/mk_print.dart';
import '../Locator/locator.dart';
import 'user_manager.dart';

class GoogleManager {
  final UserManager _userManager = locator<UserManager>();

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
      _userManager.storeData(jsonBody);
      return true;
    }
    return false;
  }

  Future<bool> createDraft(String name, String email) async {
    try {
      final http.Response res =
          await http.post(Uri.parse('$kBaseUrl/action-reaction/mvp'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer ${_userManager.accessToken}',
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
