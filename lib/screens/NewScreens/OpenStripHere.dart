import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert' as convert;
import '../../widgets/custom_appbar.dart';

class OpenStripHere extends StatefulWidget {
  const OpenStripHere({Key? key,required this.stripUrl,required this.userId}) : super(key: key);
  final String stripUrl;
  final String userId;

  @override
  State<OpenStripHere> createState() => _OpenStripHereState();
}

class _OpenStripHereState extends State<OpenStripHere> {
  WebViewController webController = WebViewController();
  @override
  initState(){
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            print("url:-$url");
            print("url:-https://dcmdmobilenotary.com/laravel/returns?user_id=${widget.userId}}");
            if (url.contains(
                'https://dcmdmobilenotary.com/laravel/returns?user_id=${widget.userId}')) {

                 Future.delayed(const Duration(milliseconds: 500), () {
                   Navigator.pop(context);
                 });
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.stripUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.stripUrl));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appBar(context: context, title: "Strip Account"),
      body: WebViewWidget(
        controller: webController,
      ),
    );
  }


}