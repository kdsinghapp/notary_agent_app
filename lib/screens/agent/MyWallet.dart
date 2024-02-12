import 'package:flutter/material.dart';
import '../../apis/interceptor.dart';
import '../../models/getTransactionModel.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../widgets/checkoutUI.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {

  List<GetTransactionResult> getTransactionResult =[];

  Future<void> GetTransaction() async {
    try {
      var userid =  await getCurrentUserId();
      print("user id is.....$userid");
      var res = await api().post('get_transaction', data: {
        "user_id":userid,
      });
      print("res----from request----$res");
      final data = GetTransactionModel.fromJson(res.data);
      getTransactionResult = data.data;
      setState(() {
      });
      print("getTransactionResult is.....${getTransactionResult}");
      // context.pop();
    } catch (e) {
      showError(context,e);
    }
  }

  @override
  // ignore: must_call_super
  initState() {
    GetTransaction();
  }
  @override
  Widget build(BuildContext context) {
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
              getTransactionResult==null?Container():
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: getTransactionResult.length,
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
                                getTransactionResult[index].dropofflocation),
                            trailing: CustomText(
                              text: "\$${getTransactionResult[index].amount}",fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              '${getTransactionResult[index].dateTime}',style: TextStyle(fontSize: 14),),
                            trailing: CustomText(
                              text: "Signing Amount",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Container(width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.001,
                            color: Colors.grey)
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
