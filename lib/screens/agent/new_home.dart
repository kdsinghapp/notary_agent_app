import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/models/getTransactionModel.dart';

import '../../utils/auth.dart';

class NewHomeScreen extends StatelessWidget {
   NewHomeScreen({Key? key}) : super(key: key);

  List<GetTransactionResult> getTransactionResult =[];

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Image.asset('assets/images/h1.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: CC.primary,
            ),
            onPressed: () {
              // scaffoldKey.currentState!.openDrawer();
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            // leading: Image.asset(
                            //   "assets/images/car.png",
                            //   height: 30,
                            //   width: 30,
                            //   fit: BoxFit.contain,
                            // ),
                            title: Text(
                                '107, 1st Floor, Sapphire House, Sapna Sang 2021 02 04 19:05 '),
                            trailing: CustomText(
                              text: "\$208",fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          ListTile(
                            title: Text(
                                '2021-01-22',style: TextStyle(fontSize: 14),),
                            trailing: CustomText(
                              text: "Signing Amount",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Container(width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.001,
                          color: Colors.grey,)
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
