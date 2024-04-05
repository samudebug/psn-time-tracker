import 'dart:convert';
import 'dart:io';

import 'package:api_repository/api_repository.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/games/games_page.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  late WebViewPlusController controller;

  checkToken(BuildContext context) async {
    bool hasToken = await context.read<AuthRepository>().checkToken();
    if (hasToken) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (routeContext) => GamesPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WebViewPlus(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) async {
        await checkToken(context);
        this.controller = controller;
        controller.loadUrl("https://store.playstation.com");
      },
      onPageStarted: (url) async {
        if (url != null && url.startsWith("https://store.playstation.com")) {
          final cookie = await controller.webViewController
              .runJavascriptReturningResult(
                  """if (document.cookie.includes("isSignedIn=true;")) {
                                                  window.location.assign("https://ca.account.sony.com/api/v1/ssocookie");
                                                }
                                              document.cookie""");
          if (cookie.contains("isSignedIn=true;")) {
            controller.loadUrl("https://ca.account.sony.com/api/v1/ssocookie");
          } else {
            controller.webViewController.runJavascript(
                """document.querySelector("[data-qa='web-toolbar#signin-button']").click()""");
          }
        }
      },
      onProgress: (progress) async {
        final url = await controller.webViewController.currentUrl();
        if (url != null && url.startsWith("https://store.playstation.com")) {
          final cookie = await controller.webViewController
              .runJavascriptReturningResult(
                  """if (document.cookie.includes("isSignedIn=true;")) {
                                                  window.location.assign("https://ca.account.sony.com/api/v1/ssocookie");
                                                }
                                              document.cookie""");
          if (cookie.contains("isSignedIn=true;")) {
            controller.loadUrl("https://ca.account.sony.com/api/v1/ssocookie");
          }
        }
        if (progress == 100) {
          if (url != null && url.startsWith("https://store.playstation.com")) {
            final cookie = await controller.webViewController
                .runJavascriptReturningResult(
                    """if (document.cookie.includes("isSignedIn=true;")) {
                                                  window.location.assign("https://ca.account.sony.com/api/v1/ssocookie");
                                                }
                                              document.cookie""");
            if (cookie.contains("isSignedIn=true;")) {
              controller
                  .loadUrl("https://ca.account.sony.com/api/v1/ssocookie");
            } else {
              controller.webViewController.runJavascript(
                  """document.querySelector("[data-qa='web-toolbar#signin-button']").click()""");
            }
          }
          if (url != null && url.contains("ssocookie")) {
            final tokenData = await controller.webViewController
                .runJavascriptReturningResult("document.body.innerText");
           if (Platform.isAndroid) {
             dynamic token = jsonDecode(jsonDecode(tokenData));
            await context.read<AuthRepository>().saveToken(token['npsso']);
           } else if (Platform.isIOS) {
            dynamic token = jsonDecode(tokenData);
            await context.read<AuthRepository>().saveToken(token['npsso']);
           }
            Navigator.of(context).push(
                MaterialPageRoute(builder: (routeContext) => GamesPage()));
          }
        }
      },
    ));
  }
}
