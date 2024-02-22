import 'package:flutter/material.dart';
import 'package:notary_agent_app/import.dart';
import 'package:quickly/quickly.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apis/CustomSnackBar.dart';
import '../../apis/interceptor.dart';
import '../../models/DriverPaymentHistoryModel.dart';
import '../../models/LoginModel.dart';
import '../../models/getTransactionModel.dart';
import '../../utils/auth.dart';
import '../../utils/colors.dart';
import '../../utils/util_funcs.dart';
import '../../widgets/checkoutUI.dart';
import '../../widgets/custom_appbar.dart';
import '../NewScreens/AddStripeXpress.dart';
import '../NewScreens/MyTransaction.dart';
import 'MySignings.dart';

class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({Key? key}) : super(key: key);

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  bool pageLoading=true;
  bool showProgressbar=true;
  bool presentData=true;
  int myTotalBalance=0;
  LoginModel? userProfileModel;
  DriverPaymentHistoryModel? driverPaymentHistoryModel;
  List<DriverPaymentHistoryResult>? driverPaymentHistoryResults;


  @override
  initState(){
    super.initState();
    getAllDriverData();

  }
  getAllDriverData() async{
    print("Start user name ...");
    userProfileModel= await getDriverDetails();
    print("User Name :-${userProfileModel!.data!.firstName}");
    getMyPaymentHistory(userProfileModel!.data!.id.toString());

  }
  getMyPaymentHistory(String myId) async {
    try {
      final res = await api().post('get_drivers_payment_history',
          data: {"driver_id":myId});
      // print("res  data2 ------------------${res.data}");
      final data = DriverPaymentHistoryModel.fromJson(res.data);
      if (data.status == "1") {
        driverPaymentHistoryModel=data;
        driverPaymentHistoryResults = data.result;
        for(int i=0;i<driverPaymentHistoryResults!.length;i++){
            myTotalBalance+=int.parse(driverPaymentHistoryResults![i].totalAmount!);
        }
        setState(() {
          pageLoading=false;
          presentData=true;
          showProgressbar=false;
        });
      } else {
        setState(() {
          pageLoading=false;
          presentData=false;
          showProgressbar=true;
        });
        showError(context, "${data.message}");
      }
    } catch (e) {
      setState(() {
        pageLoading=false;
        presentData=false;

      });
      showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "My Wallet", elevation: 0,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  context.navigate(() => const MySignings());
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent
                  ),
                  margin: const EdgeInsets.only(right: 2),
                  child: const Text("My Signings",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                   textAlign: TextAlign.center,),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: (){
                  context.navigate(() => const AddStripeXpress());

                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  child: const Text("Next Pay Check",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center,),
                ),
              ),
            ),
          ],
        ),
      ),
      body:pageLoading?
      const Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          height: 40,width: 50,
                          child: Image.asset('assets/icons/wallet1.png',height: 40, width: 50, fit: BoxFit.fill)
                      ),
                    ),
                    sbh(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your current balance',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),),
                        Text('\$ ${myTotalBalance}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),)
                      ],
                    ),
                    const Divider(thickness: 1,color: Colors.black87,),
                    GestureDetector(
                      onTap: (){
                        if(driverPaymentHistoryResults!.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              MyTransactions(myTransactionList:driverPaymentHistoryResults!,)));
                        }

                      },
                      child: Container(
                        height: 40,width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color:Colors.indigo,width: 1)
                        ),
                        child: const Center(
                          child: Text('See All Transactions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.indigo),),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              sbh(20),
              presentData?
              showPaymentHistoryList():const Text("There are not present any transaction history.",style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.normal,color: Colors.redAccent,),textAlign: TextAlign.center,),
              sbh(70),

            ],
          ),
        ),
      ),
    );
  }
  /// Show PaymentHistory List...
  Widget showPaymentHistoryList() {
    return showProgressbar ?
    Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        enabled: showProgressbar,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                margin: const EdgeInsets.only(top: 5,bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 1,),
                    borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15,
                      margin: const EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  Container(
                        height: 20,
                        width: 70,
                        margin: const EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black
                        ),
                      ),
                    ),
                    Container(
                      height: 15,width: 230,
                      margin: const EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child:  Container(
                        height: 15,
                        width: 100,
                        margin: const EdgeInsets.only(left: 5, right: 5,bottom: 5,top: 5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.black
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
        )
    ) :
    ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount:driverPaymentHistoryResults!.length>5?5:driverPaymentHistoryResults!.length,
      itemBuilder: (context, int index) {
        DriverPaymentHistoryResult item=driverPaymentHistoryResults![index];
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "${item.picuplocation}",
                  textColor: Colors.black87,fontSize: 13,fontWeight: FontWeight.normal,textAlign: TextAlign.start,),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    text: "\$ ${item.totalAmount}",
                    textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,textAlign: TextAlign.end,),
                ),
                CustomText(
                  text: "${item.picklaterdate}",
                  textColor: Colors.black87,fontSize: 13,fontWeight: FontWeight.normal,textAlign: TextAlign.start,),
                Align(
                  alignment:  Alignment.centerRight,
                  child: CustomText(
                    text: "Signing Amount",
                    textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,textAlign: TextAlign.end,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  myLauncherURL(String myUrl) async {
    final Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
