import '../../import.dart';
import '../../models/CurrentShippingModel.dart';
import '../../utils/auth.dart';

class CurrentShipping extends StatefulWidget {
  const CurrentShipping({Key? key}) : super(key: key);

  @override
  State<CurrentShipping> createState() => _CurrentShippingState();
}

class _CurrentShippingState extends State<CurrentShipping> {

  CurrentShippingResult ? currentShippingResult;

  Future<void> getCurrentShipping() async {
      try {
        var userid =  await getCurrentUserId();
        print("user id is.....$userid");
        var res = await api().post('get_current_booking', data: {
          "user_id":userid,
        });
        print("res----from request----$res");
        final data = CurrentShippingModel.fromJson(res.data);
        currentShippingResult = data.data;
        setState(() {

        });
        print("currentShippingResult is.....${currentShippingResult}");
        // context.pop();
      } catch (e) {
        showError(context, e);
      }
  }

  @override
  // ignore: must_call_super
  initState() {
    getCurrentShipping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.all(2),
            child: CustomText(
              text: 'Current Shipping',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
            )),
        centerTitle: false,
        toolbarHeight: 70,
        leading: const BackButton(),
      ),
      body: currentShippingResult==null?Container():Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/images/express.png',
                    height: 75,
                    width: 75,
                    fit: BoxFit.contain,
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Total Price \$${currentShippingResult!.rideFare} \n rush',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      // CustomText(text: 'rush'),
                    ],
                  ),
                  // trailing: Icon(Icons.more_vert),
                ),
                sbh(20),
                SpaceRow(
                  heading: 'Express:',
                  value: '${currentShippingResult!.booktype}',
                ),
                SpaceRow(
                  heading: 'Weekend Charge:',
                  value: '\$${currentShippingResult!.weekend}',
                ),
                SpaceRow(
                  heading: 'After Hour Charge:',
                  value: '\$${currentShippingResult!.overnight}',
                ),
                SpaceRow(
                  heading: 'Rush Service::',
                  value: '\$${currentShippingResult!.rushCharge}',
                ),
                SpaceRow(
                  heading: 'Signing Location :',
                  value: '${currentShippingResult!.picuplocation}'
                ),
                SpaceRow(
                  heading: 'Rush Number of Witness:',
                  value: '${currentShippingResult!.numberOfWitness}',
                ),
                SpaceRow(
                  heading: 'Type of Signing:',
                  value: '${currentShippingResult!.typeOfSigningName}',
                ),
                SpaceRow(
                  heading: 'Location Type:',
                  value: '${currentShippingResult!.locationType}',
                ),
                SpaceRow(
                  heading: 'Number of Signing:',
                  value: '${currentShippingResult!.numberOfSigning}',
                ),
                SpaceRow(
                  heading: 'Date Time:',
                  value: '${currentShippingResult!.picklaterdate}',
                ),
                SpaceRow(
                  heading: 'Name:',
                  value: '${currentShippingResult!.name}',
                ),
                SpaceRow(
                  heading: 'Real Estate Signing:',
                  value: '${currentShippingResult!.realstateSigning}',
                ),
                SpaceRow(
                  heading: 'Email to print:',
                  value: '${currentShippingResult!.emailtoprit}',
                ),
                SpaceRow(
                  heading: 'Scan and Email:',
                  value: '${currentShippingResult!.scanandemail}',
                ),
                sbh(30),
                AppButton(
                  onTap: () {
                    // controller.checkout(context);
                    Navigator.pop(context);
                  },
                  text: "PAID",
                  color: CC.primary,
                )
              ]),
        ),
      ),
    );
  }
}
