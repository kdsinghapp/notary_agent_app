import 'package:notary_agent_app/import.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Payment"),
      body: GetBuilder(
        init: PaymentController(),
        builder: (PaymentController controller) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          "If you not confirm in 5 minutes the signing request is cancelled automatically",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      textColor: Color(0xff555555),
                    ),
                    sbh(20),
                    CustomText(
                      text: "Choose a way to pay",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      textColor: Color(0xff555555),
                    ),
                    sbh(20),
                    ListTile(
                      leading: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_outline_outlined,
                          size: 40,
                        ),
                      ),
                      title: Text(
                        'Add New Card',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xff555555)),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    sbh(5),
                    Container(
                      height: 1,
                      color: Color(0xff777777),
                    ),
                    sbh(20),
                    ListTile(
                      leading: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tristate: true,
                        value: true,
                        onChanged: (newValue) {},
                        activeColor: Colors.red,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Visa **** ****5858\nJohan\nExpires 4/2023',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            textColor: Color(0xff555555),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      child: Column(
                        children: [
                          CustomText(
                            text: "You will be charged: \$95.00",
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          sbh(10),
                          AppButton(
                            onTap: () {
                              controller.continueBtn(context);
                            },
                            text: "CONTINUE",
                            color: Colors.red,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
