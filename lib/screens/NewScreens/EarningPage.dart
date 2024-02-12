import 'package:flutter/material.dart';
import 'package:notary_agent_app/models/DriverPaymentHistoryModel.dart';
import 'package:shimmer/shimmer.dart';
import '../../apis/CustomSnackBar.dart';
import '../../apis/interceptor.dart';
import '../../utils/auth.dart';
import '../../widgets/checkoutUI.dart';

class EarningPage extends StatefulWidget{
    const EarningPage({super.key});
  @override
  State<StatefulWidget> createState() =>_EarningState();

}
class _EarningState extends State<EarningPage>{
  bool showProgressbar=true;
  bool presentData=true;
  DriverPaymentHistoryModel? driverPaymentHistoryModel;
  List<DriverPaymentHistoryResult>? driverPaymentHistoryResults;


  @override
  initState(){
    super.initState();
    getMyPaymentHistory();
  }

  getMyPaymentHistory() async {
    try {
      final res = await api().post('get_drivers_payment_history',
          data: {"driver_id": await getCurrentUserId()});
     // print("res  data2 ------------------${res.data}");
      final data = DriverPaymentHistoryModel.fromJson(res.data);
      if (data.status == "1") {
        driverPaymentHistoryModel=data;
        driverPaymentHistoryResults = data.result;
        setState(() {
          presentData=true;
          showProgressbar=false;
        });
      } else {
        setState(() {
          presentData=false;
        });
        showSnackbar(context, "${data.message}");
      }
    } catch (e) {
      setState(() {
        presentData=false;
      });
      showError(context, e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.grey,),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomText(
                      text: "Today",
                      textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: "Earning Amount",
                          textColor: Colors.black87,fontSize: 14,fontWeight: FontWeight.normal,),
                        CustomText(
                          text:showProgressbar?'\$ 0': "\$ ${driverPaymentHistoryModel!.toDayEarning!.toString()}",
                          textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child:  CustomText(
                        text: "Signing Amount",
                        textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,textAlign: TextAlign.end,),
                    ),
                  ],
                ),
              ),
              presentData?
              showPaymentHistoryList():const Text("There are not present any earnings.",style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.normal,color: Colors.redAccent,),textAlign: TextAlign.center,)
            ],
          ),
        ),
        Positioned(
          bottom: 0,right: 0,left: 0,
          child:  Container(
            height: 50,
              padding: const EdgeInsets.only(left: 10,right: 10),
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(color: Colors.grey,thickness: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "This Week",
                        textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),
                      CustomText(
                        text: showProgressbar?"\$ 0.0":"\$ ${driverPaymentHistoryModel!.weeklyEarning.toString()}",
                        textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,),
                    ],
                  ),
                ],
              )),)

      ],
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
      itemCount:driverPaymentHistoryResults!.length,
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

}