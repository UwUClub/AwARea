import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Utils/constants.dart';

class SlackManager {
  String? slackBotToken;

  Future<bool> registerSlackBotToken(String slackBotToken) async {
    final http.Response res =
        await http.post(Uri.parse('$kBaseUrl/auth/slack-bot-register'),
            headers: <String, String>{
              'accept': 'application/json',
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'slackBotToken': slackBotToken,
            }));
    final dynamic jsonBody = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 201) {
      slackBotToken = jsonBody['slackBotToken'] as String;
      return true;
    }
    return false;
  }
}
