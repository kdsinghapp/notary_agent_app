import 'package:flutter_html/flutter_html.dart';
import 'package:notary_agent_app/import.dart';

import '../../services/apiServices.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool loading=false;
  Map data={};
  getData()async{
    setState(() {
      loading=true;
    });
    data = await Webservices.getMap(ApiUrls.terms);
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
      appBar: appBar(context: context, title: "Terms and Conditions"),
      body: GetBuilder(
        init: TermsController(),
        builder: (TermsController controller) {
          return loading? const Center(child: CircularProgressIndicator(),): ListView(
            children: [
              Html(data: data['data'][0]['text']) ,
              sbh(50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  onTap: () {
                    controller.ok(context);
                  },
                  text: "OK",
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
