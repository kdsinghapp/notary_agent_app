import 'package:notary_agent_app/import.dart';

class CheckOutScreeen extends StatelessWidget {
  const CheckOutScreeen({Key? key}) : super(key: key);

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
      body: GetBuilder(
          init: CheckOutController(),
          builder: (CheckOutController controller) {
            return Container(
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
                              text: 'Total Price \$95.00 \n rush',
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
                        value: '\$0',
                      ),
                      SpaceRow(
                        heading: 'Weekend Charge:',
                        value: '\$0',
                      ),
                      SpaceRow(
                        heading: 'After Hour Charge:',
                        value: '\$0',
                      ),
                      SpaceRow(
                        heading: 'Rush Service::',
                        value: '\$0',
                      ),
                      SpaceRow(
                        heading: 'Signing Location :',
                        value:
                            '107, 1st Floor, Sapphire House, Sapna Sangeeta Main Road, Snehnagar, Agrasen Square, Snehnagar, Indore, Madhya Dvarash 457001 India',
                      ),
                      SpaceRow(
                        heading: 'Rush Number of Witness:',
                        value: 'No',
                      ),
                      SpaceRow(
                        heading: 'Type of Signing:',
                        value: 'Adpotion',
                      ),
                      SpaceRow(
                        heading: 'Location Type:',
                        value: 'Residential',
                      ),
                      SpaceRow(
                        heading: 'Number of Signing:',
                        value: '3',
                      ),
                      SpaceRow(
                        heading: 'Date Time:',
                        value: '2021-02-04 19:05',
                      ),
                      SpaceRow(
                        heading: 'Name:',
                        value: 'keshav',
                      ),
                      SpaceRow(
                        heading: 'Real Estate Signing:',
                        value: 'No',
                      ),
                      SpaceRow(
                        heading: 'Email to print:',
                        value: '\$0',
                      ),
                      SpaceRow(
                        heading: 'Scan and Email:',
                        value: '\$0',
                      ),
                      sbh(30),
                      AppButton(
                        onTap: () {
                          // controller.checkout(context);
                          Navigator.pop(context);
                        },
                        text: "NOT PAID",
                        color: CC.primary,
                      )
                    ]),
              ),
            );
          }),
    );
  }
}
