import 'dart:convert';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:psn_time_tracker/pages/games/games_page.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageDesktop extends StatefulWidget {
  LoginPageDesktop({super.key});

  @override
  State<LoginPageDesktop> createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final controller = WebviewController();
  bool _isWebviewSuspended = false;
  String? currentUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken(context);
    initWebView();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  

  checkToken(BuildContext context) async {
    bool hasToken = await context.read<AuthRepository>().checkToken();
    if (hasToken) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (routeContext) => GamesPage()));
    }
  }

  Future<void> initWebView() async {
    try {
      await controller.initialize();
      controller.url.listen((event) {
        currentUrl = event;
      });
      controller.loadingState.listen((event) async {
        if (currentUrl != null) {
          if (currentUrl!.startsWith("https://store.playstation.com")) {
            final cookie =
                await controller.executeScript("""document.cookie""");
            if (cookie.contains("isSignedIn=true;")) {
              controller
                  .loadUrl("https://ca.account.sony.com/api/v1/ssocookie");
            }
          }
        }
        if (event == LoadingState.navigationCompleted) {
          if (currentUrl != null) {
            if (currentUrl!.startsWith("https://store.playstation.com")) {
              final cookie =
                  await controller.executeScript("""document.cookie""");
              if (!cookie.contains("isSignedIn=true;")) {
                controller.executeScript(
                    """document.querySelector("[data-qa='web-toolbar#signin-button']").click()""");
              }
            }
            if (currentUrl!.contains("ssocookie")) {
              final tokenData = await controller.executeScript("""
          document.querySelector("body > div.cm-editor.ͼ1.ͼ3.ͼ4.ͼ6.ͼ5 > div.cm-scroller > div.cm-content.cm-lineWrapping").innerText
""");
              dynamic token = jsonDecode(tokenData);
              await context.read<AuthRepository>().saveToken(token['npsso']);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (routeContext) => GamesPage()));
            }
          }
        }
      });
      await controller.loadUrl("https://store.playstation.com");

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'WebView permission requested',
          style: TextStyle(color: Colors.white),
        ),
        content: Text('WebView has requested permission \'$kind\'',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Open Devtool",
        onPressed: () async {
          controller.openDevTools();
        },
        child: Icon(Icons.settings),
      ),
      body: SafeArea(
          child: controller.value.isInitialized
              ? Webview(
                  controller,
                  permissionRequested: _onPermissionRequested,
                )
              : Center(child: Text("loading"))),
    );
  }
}
