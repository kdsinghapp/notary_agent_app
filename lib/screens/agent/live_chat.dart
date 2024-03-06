import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:notary_agent_app/widgets/custom_appbar.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  final String hubSpotLiveChatUrl =
      'https://dcmdmobilenotary.com/laravel/public/live-chat/index.php'; //'https://app.hubspot.com/chatflow/1234567/1234567';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, title: "Live Chat"),
        body: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebviewScaffold(
                    url: hubSpotLiveChatUrl,
                    appBar: appBar(context: context, title: "Live Chat"),
                  ),
                ));
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepOrangeAccent,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: const Text(
                  'Live Chat',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepOrangeAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ));
  }
}
