import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/mk_print.dart';

class CallbackGithubView extends StatefulWidget {
  const CallbackGithubView({super.key});

  @override
  CallbackGithubViewState createState() => CallbackGithubViewState();
}

class CallbackGithubViewState extends State<CallbackGithubView> {
  String? token;

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  // Fonction asynchrone pour récupérer le code
  Future<void> getAccessToken() async {
    final Uri uri = Uri.base;
    final String? code = uri.queryParameters['code'];

    mkPrint('Uri: $uri');
    mkPrint('Code: $code');
    if (code != null) {
      final http.Response response = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
        body: jsonEncode(<String, String>{
          'client_id': dotenv.env['GITHUB_CLIENT_ID']!,
          'client_secret': dotenv.env['GITHUB_CLIENT_SECRET']!,
          'code': code,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          // ignore: avoid_dynamic_calls
          token = jsonDecode(response.body)['access_token'] as String;
        });
        mkPrint(token);
      } else {
        mkPrint('Échec de la requête : ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Spacer(),
          Center(
              child: Text('Callback Github',
                  style: Theme.of(context).textTheme.titleLarge)),
          SizedBox(height: 100.0.ratioH()),
          Center(
            child: token != null
                ? Text('Token: $token')
                : const CircularProgressIndicator(),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
