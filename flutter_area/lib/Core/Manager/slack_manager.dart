import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';
import '../Locator/locator.dart';
import 'user_manager.dart';

class SlackManager {
  String? botToken;

  UserManager userManager = locator<UserManager>();

  Future<bool> updateBotToken(String token) async {
    final http.Response res =
        await http.patch(Uri.parse('$kBaseUrl/slack/update-slack-bot'),
            headers: <String, String>{
              'accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${userManager.accessToken}',
            },
            body: jsonEncode(<String, String>{
              'botToken': token,
            }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200) {
      botToken = token;
      return true;
    }
    return false;
  }
}
