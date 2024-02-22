import 'package:flutter/material.dart';
import 'package:notary_agent_app/apis/errors.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/models/HelpModel.dart';
import 'package:notary_agent_app/screens/NewScreens/OpenStripHere.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;
import '../../../services/apiServices.dart';
import '../../../utils/colors.dart';
import '../../models/LoginModel.dart';
import '../../models/UserProfileModel.dart';
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
  UserProfileModel? userProfileModel;
  @override
  initState(){
    super.initState();
    //getAllDriverData();
    getUserProfile();
  }
  Future<void> getUserProfile() async {
   // try {
      String agent_id = await getCurrentUserId();
      String url = '${ApiUrls.getProfile}?user_id=$agent_id';
      var res = await Webservices.getData(url);
      print("res ------------------${res.body}");
      var jsonResponse = convert.jsonDecode(res.body);
      print("change status url ------------------${url}");
      print("res from login data2 ------------------${jsonResponse}");
      userProfileModel = UserProfileModel.fromJson(jsonResponse);
      if (userProfileModel!.status == "true") {
        if(userProfileModel!.data![0].stripLoginLinkInStripeWebsite==null){
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
      } else {
        print('Failed get driver profile...');
        showError(context, "${userProfileModel!.message}");
      }
    // }catch(e){
    //   print('Catch Error ...${e.toString()}');
    //   showError(context, "${e.toString()}");
    // }

  }
  /*getAllDriverData() async{
    print("Start user name ...");
    userProfileModel= await getDriverDetails();
    print("User Name :-${userProfileModel!.data!.firstName}");
    if(userProfileModel!.data!.stripLoginLinkInStripeWebsite==null){
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

  }  */
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
               // myLauncherURL(userProfileModel!.data![0].stripLoginLinkInStripeWebsite??'');
                context.navigate(()=>OpenStripHere(stripUrl: userProfileModel!.data![0].stripLoginLinkInStripeWebsite??'', userId: userProfileModel!.data![0].id.toString()));
              },
              leading:const  Icon(Icons.add_circle,size: 25,color: Colors.grey,),
              horizontalTitleGap: 0.0,
              title:const  Text("Show Stripe Account Detail",style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black87
              ),) ,
            ):
            ListTile(
              onTap: ()async {
               // myLauncherURL(userProfileModel!.data![0].stripLoginLinkInStripeWebsite??'');
                 await context.navigate(()=>OpenStripHere(stripUrl: userProfileModel!.data![0].stripLoginLinkInStripeWebsite??'', userId: userProfileModel!.data![0].id.toString()));

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