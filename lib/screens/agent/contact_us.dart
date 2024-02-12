import 'package:notary_agent_app/controllers/contact_us.dart';
import 'package:notary_agent_app/import.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Contact Us"),
      body: GetBuilder(
        init: ContactUsController(),
        builder: (ContactUsController controller) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(30),
                    child: Image.asset("assets/images/contactusss.png")),
                sbh(MediaQuery.of(context).size.height * 0.05),
                AppTextFormField(
                  placeholder: "Name",
                  validator: Validators.required,
                  obscureText: true,
                  onSaved: (val) => controller.name = val!,
                ),
                sbh(20),
                AppTextFormField(
                  placeholder: "Email",
                  validator: Validators.required,
                  obscureText: true,
                  onSaved: (val) => controller.email = val!,
                ),
                sbh(20),
                AppTextFormField(
                  placeholder: "Message",
                  validator: Validators.required,
                  obscureText: true,
                  onSaved: (val) => controller.msg = val!,
                ),
                sbh(60),
                AppButton(
                  onTap: () {
                    controller.submit(context);
                  },
                  text: "SUBMIT",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
