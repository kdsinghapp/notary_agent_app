import 'package:flutter/material.dart';
import 'package:notary_agent_app/apis/errors.dart';
import 'package:notary_agent_app/models/HelpModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/apiServices.dart';
import '../../../utils/colors.dart';
import '../../models/LoginModel.dart';
import '../../utils/auth.dart';
import '../../widgets/custom_appbar.dart';

class AddStripeXpress extends StatefulWidget {
  const AddStripeXpress({Key? key}) : super(key: key);

  @override
  State<AddStripeXpress> createState() => _AddStripeXpressState();
}

class _AddStripeXpressState extends State<AddStripeXpress> {
  bool pageLoading=true;
  bool presentData=true;
  bool haveAccount=false;
  HelpModel? helpModel;
  late List<bool> questionStatusList ;
  LoginModel? userProfileModel;
  @override
  initState(){
    super.initState();
    getAllDriverData();

  }
  getAllDriverData() async{
    print("Start user name ...");
    userProfileModel= await getDriverDetails();
    print("User Name :-"+userProfileModel!.data!.firstName!);
    if(userProfileModel!.data!.stripLoginLinkInStripeWebsite!.isEmpty){
      setState(() {
        haveAccount=false;
        pageLoading=false;
      });
    }else{
      setState(() {
        haveAccount=true;
        pageLoading=false;
      });
    }

    //getMyPaymentHistory(userProfileModel!.data!.id.toString());

  }
  getHelpApi()async {
    try {
      final data = await Webservices.getMap(ApiUrls.helpMe);
      print("res from api ========$data");
      helpModel = HelpModel.fromJson(data);
      if (helpModel!.status == '1') {
        questionStatusList = List<bool>.generate(helpModel!.data!.length, (int index) => false, growable: true);
        setState(() {
          pageLoading = false;
          presentData = true;

        });
      } else {
        setState(() {
          pageLoading = false;
          presentData = false;
        });
      }
    }catch(e){
      showError(context, e.toString());
      setState(() {
        pageLoading = false;
        presentData = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context, title: "Stripe Express"),
        body:pageLoading?
            const Center(child: CircularProgressIndicator()):
        Column(
          children: [
            Container(
              height: 45,
              color: Colors.grey.withOpacity(0.5),
              alignment: Alignment.centerLeft,
              margin:const  EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 20,right: 20),
              child:const  Text("Connect With Stripe",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black87),) ,
            ),
            haveAccount?ListTile(
              onTap: (){
                myLauncherURL(userProfileModel!.data!.stripLoginLinkInStripeWebsite??'');
              },
              leading:const  Icon(Icons.add_circle,size: 25,color: Colors.grey,),
              horizontalTitleGap: 0.0,
              title:const  Text("Show Stripe Account Detail",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black87
              ),) ,
            ):
            ListTile(
              onTap: (){
                //myLauncherURL(userProfileModel!.data!.stripLoginLinkInStripeWebsite??'');
              },
              leading:const Icon(Icons.add_circle,size: 25,color: Colors.grey,),
              horizontalTitleGap: 0.0,
              title:const Text("Add Merchant Account",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black87
              ),) ,
            ),
          ],
        )
    );
  }
  myLauncherURL(String myUrl) async {
    final Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}