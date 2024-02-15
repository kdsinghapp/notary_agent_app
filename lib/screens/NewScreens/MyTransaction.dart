import 'package:flutter/material.dart';
import '../../models/DriverPaymentHistoryModel.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/checkoutUI.dart';

class MyTransactions extends StatefulWidget{
  const MyTransactions({super.key,required this.myTransactionList});
  final List<DriverPaymentHistoryResult> myTransactionList;
  @override
  State<StatefulWidget> createState() =>_MyTransactionsState();

}
class _MyTransactionsState extends State<MyTransactions>{

  @override
  initState(){
    super.initState();
    //getAllDriverData();

  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(title: const Text("My Transactions"),),
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              showShowTransactionList()

            ],
          ),
        ),
      );
  }

  /// Show ShowTransaction History List...
  Widget showShowTransactionList() {
    return
    ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount:widget.myTransactionList.length,
      itemBuilder: (context, int index) {
        DriverPaymentHistoryResult item=widget.myTransactionList[index];
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(color: Colors.black87,width: 1)

          ),
          elevation: 1,
          margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
          child: Padding(
            padding: const EdgeInsets.only(left:10,right: 10,top: 15,bottom: 15 ),
            child: Row(
              children: [
                const Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_downward,size: 35,color: Colors.redAccent,))),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: "Amount : \$ ${item.totalAmount}",
                        textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,textAlign: TextAlign.end,),
                      sbh(8),
                      const CustomText(
                        text: "Received form Signing",
                        textColor: Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,textAlign: TextAlign.end,),
                      sbh(8),
                      CustomText(
                        text: " ${item.picklaterdate}",
                        textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.normal,textAlign: TextAlign.start,),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}