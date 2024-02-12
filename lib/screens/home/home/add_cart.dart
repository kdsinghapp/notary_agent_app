import '../../../import.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Add Your Card"),
      body: GetBuilder(
        init: CardController(),
        builder: (CardController controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomText(
                    text: "Add Your Card",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textColor: Color(0xff555555),
                  ),
                ),
                sbh(40),
                AppTextFormField(
                  placeholder: "Email",
                  validator: Validators.required,
                  onSaved: (val) => controller.name = val!,
                ),
                sbh(20),
                AppTextFormField(
                  placeholder: "Card Number",
                  validator: Validators.required,
                  onSaved: (val) => controller.cardNumber = val!,
                ),
                sbh(20),
                CustomText(
                  text: "Expiration date",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  textColor: Color(0xff777777),
                ),
                sbh(20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        placeholder: "01",
                        validator: Validators.required,
                        onSaved: (val) => controller.cardNumber = val!,
                      ),
                    ),
                    sbw(10),
                    Expanded(
                      child: AppTextFormField(
                        placeholder: "2024",
                        validator: Validators.required,
                        onSaved: (val) => controller.cardNumber = val!,
                      ),
                    ),
                  ],
                ),
                sbh(20),
                AppTextFormField(
                  placeholder: "Security Code",
                  validator: Validators.required,
                  onSaved: (val) => controller.securityCode = val!,
                ),
                sbh(150),
                AppButton(
                  onTap: () {
                    controller.addcard(context);
                  },
                  text: "Add your card",
                  color: CC.primary,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
