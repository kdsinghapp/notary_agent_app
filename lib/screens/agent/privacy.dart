import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../services/apiServices.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/custom_appbar.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool loading=false;
  Map data={};
  getData()async{
    setState(() {
      loading=true;
    });
    data = await Webservices.getMap(ApiUrls.privacy);
    print("res from api ========$data");
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Privacy Policy"),
      body:loading? const Center(child: CircularProgressIndicator(),):
      ListView(
        children: [
          Html(data: data['data'][0]['text']) ,
          sbh(50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: "OK",
            ),
          )
        ],
      )
    );
  }
}
