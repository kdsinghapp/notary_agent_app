import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CC.primary,
        elevation: 0,
        title:Text('HELP'),
        toolbarHeight: 70,
        automaticallyImplyLeading: true,
        actions: [
          TextButton(onPressed: () {  },
              child: Text('HELP',style: TextStyle(color: CC.primary),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child:
          Column(
            children: [
              Text('Getting started with Notary Mobility',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading:
                          Icon(Icons.featured_play_list_rounded,color: CC.primary,),
                            // Image.asset(
                            //   "assets/images/car.png",
                            //   height: 30,
                            //   width: 30,
                            //   fit: BoxFit.contain,
                            // ),
                            title: Text("What equipment should I recieve to get notary work"),
                          ),
                          Container(width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.001,
                              color: Colors.grey)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
