import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/mk_print.dart';

const String clientId = 'd373b5fe2e411c74b948';
const String clientSecret = '155580817cc512a05837beb6d7bdf6e8d080f265';

class CallbackGithubView extends StatefulWidget {
  const CallbackGithubView({super.key});

  @override
  CallbackGithubViewState createState() => CallbackGithubViewState();
}

class CallbackGithubViewState extends State<CallbackGithubView> {
  String? token;
  static String clientId = 'd373b5fe2e411c74b948';
  static String clientSecret = '155580817cc512a05837beb6d7bdf6e8d080f265';

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
        },
        body: jsonEncode(<String, String>{
          'client_id': clientId,
          'client_secret': clientSecret,
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
        // Gérer l'erreur
        mkPrint('Échec de la requête : ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Afficher une page de confirmation ou rediriger l'utilisateur
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
