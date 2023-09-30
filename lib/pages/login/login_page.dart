import 'dart:convert';

import 'package:api_repository/api_repository.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:games_repository/games_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:psn_time_tracker/blocs/games_bloc/games_bloc.dart';
import 'package:psn_time_tracker/blocs/profile_bloc/profile_bloc.dart';
import 'package:psn_time_tracker/pages/games/games_page.dart';
import 'package:trophies_repository/trophies_repository.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  late WebViewPlusController controller;

  checkToken(BuildContext context) async {
    bool hasToken = await context.read<AuthRepository>().checkToken();
    if (hasToken) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (routeContext) => GamesPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebViewPlus(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        checkToken(context);
        this.controller = controller;
        controller.loadUrl("https://store.playstation.com");
      },
      onProgress: (progress) async {
        if (progress == 100) {
          final url = await controller.webViewController.currentUrl();
          if (url != null && url.startsWith("https://store.playstation.com")) {
            final cookie = await controller.webViewController
                .runJavascriptReturningResult("document.cookie");
            if (cookie.contains("isSignedIn=true;")) {
              controller
                  .loadUrl("https://ca.account.sony.com/api/v1/ssocookie");
            } else {
              controller.webViewController.runJavascript(
                  """document.querySelector("[data-qa='web-toolbar#signin-button']").click()""");
            }
          }
          if (url != null && url.startsWith("https://ca.account.sony.com")) {
            final tokenData = await controller.webViewController
                .runJavascriptReturningResult("document.body.innerText");

            dynamic token = jsonDecode(jsonDecode(tokenData));
            await context.read<AuthRepository>().saveToken(token['npsso']);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (routeContext) => GamesPage()));
          }
        }
      },
    ));
  }
}
