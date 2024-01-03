import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:http/http.dart' as http;

import '../../Utils/Extensions/color_extensions.dart';
import '../../Utils/Extensions/double_extensions.dart';
import '../../Utils/mk_print.dart';

class CallbackGithubView extends StatefulWidget {
  const CallbackGithubView({super.key});

  @override
  CallbackGithubViewState createState() => CallbackGithubViewState();
}

class CallbackGithubViewState extends State<CallbackGithubView> {
  String? token;
  bool? isSignedIn;

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  // Fonction asynchrone pour récupérer le code
  Future<void> getAccessToken() async {
    final Uri uri = Uri.base;
    final String? code = uri.queryParameters['code'];

    if (code != null) {
      final http.Response response = await http.post(
        Uri.parse('https://github.com/login/oauth/access_token'),
        headers: <String, String>{
          'Accept': 'application/json',
        },
        body: <String, String>{
          'client_id': dotenv.env['GITHUB_CLIENT_ID']!,
          'client_secret': dotenv.env['GITHUB_CLIENT_SECRET']!,
          'code': code,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          // ignore: avoid_dynamic_calls
          token = jsonDecode(response.body)['access_token'] as String;
          isSignedIn = true;
        });
        mkPrint(token);
      } else {
        mkPrint('Échec de la requête : ${response.statusCode}');
        setState(() => isSignedIn = false);
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
              child: Text(AppLocalizations.of(context)!.connectionGithub,
                  style: Theme.of(context).textTheme.titleLarge)),
          SizedBox(height: 100.0.ratioH()),
          Center(
            child: token != null
                ? Icon(CupertinoIcons.checkmark_alt_circle_fill,
                    color: Theme.of(context).colorScheme.redColor,
                    size: 100.0.ratioH())
                : SizedBox(
                    height: 100.0.ratioH(),
                    width: 100.0.ratioH(),
                    child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.redColor)),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
