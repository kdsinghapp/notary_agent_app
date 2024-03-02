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
      'https://app.hubspot.com/chatflow/1234567/1234567';

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
        )
        /*WebView(
        initialUrl: hubSpotLiveChatUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),*/
        );
  }
}

/* final String accessToken = 'pat-na1-e41113d8-014f-47e3-96a0-32e5a4d58f01';
  final String inboxId = '3';

  List<dynamic> messages = [];

  Future<void> sendMessageToHubSpot(String message) async {
    final String endpoint =
        'https://api.hubapi.com/conversations/v1/conversations/$inboxId/messages';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    Map<String, dynamic> body = {
      "text": message,
    };

    final response = await http.post(Uri.parse(endpoint),
        headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      print("Message sent successfully!");
    } else {
      print("Failed to send message. Error: ${response.statusCode}");
    }
  }

  Future<void> fetchMessages() async {
    final String endpoint =
        'https://api.hubapi.com/conversations/v1/conversations/$inboxId/messages';

    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(Uri.parse(endpoint), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> messagesData = json.decode(response.body)['results'];
      setState(() {
        messages = messagesData
            .map((message) => message['body'])
            .toList()
            .reversed
            .toList();
      });
    } else {
      print("Failed to fetch messages. Error: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch messages initially
    fetchMessages();
    // Periodically fetch messages every 5 seconds
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      fetchMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                sendMessageToHubSpot(
                    'Hello, this is a test message from Flutter app!');
              },
              child: Text('Send Message to HubSpot Live Chat'),
            ),
          ),
        ],
      ),
    );
  }
}   */
