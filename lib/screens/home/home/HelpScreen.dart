import 'package:flutter/material.dart';
import 'package:notary_agent_app/apis/errors.dart';
import 'package:notary_agent_app/models/HelpModel.dart';

import '../../../services/apiServices.dart';
import '../../../utils/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
   bool pageLoading=true;
   bool presentData=true;
   HelpModel? helpModel;
  late List<bool> questionStatusList ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHelpApi();

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
      appBar: AppBar(
        backgroundColor: CC.primary,
        elevation: 0,
        title:const Text('HELP'),
        toolbarHeight: 70,
        automaticallyImplyLeading: true,
      ),
      body:pageLoading?
          const Center(
            child: CircularProgressIndicator(),
          ):
      presentData?
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child:
          Column(
            children: [
              const Text('Getting started with Notary Mobility',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: helpModel!.data!.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    HelpData item=helpModel!.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding:EdgeInsets.all(8.0),
                                child:  Icon(Icons.featured_play_list_rounded,color: CC.primary,size: 25,),
                              ),
                              Expanded(
                                child: Text(item.helpQuestion!,style: const TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.bold
                                ),),
                              ),
                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    questionStatusList[index]=!questionStatusList[index];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(questionStatusList[index]?Icons.keyboard_arrow_up:
                                  Icons.keyboard_arrow_down,size: 25,color: CC.primary,),
                                ),
                              ),
                            ],
                          ),
                          /* ListTile(
                            leading:
                          Icon(Icons.featured_play_list_rounded,color: CC.primary,),
                            // Image.asset(
                            //   "assets/images/car.png",
                            //   height: 30,
                            //   width: 30,
                            //   fit: BoxFit.contain,
                            // ),
                            title: Text("What equipment should I recieve to get notary work"),
                            trailing:
                            Icon(questionStatusList[index]?Icons.keyboard_arrow_up:
                            Icons.keyboard_arrow_down,size: 25,color: Colors.indigoAccent,),
                          ),*/

                          questionStatusList[index]?
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Text(item.helpAnswer!,
                              style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                          ):const SizedBox(height: 2,),
                          const SizedBox(height: 5,),
                          Container(width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.001,
                              color: Colors.grey),

                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ):
          const Center(
            child: Text("There are not present any question",style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent
            ),),
          )
    );
  }
}
