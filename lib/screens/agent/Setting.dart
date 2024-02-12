import 'package:notary_agent_app/controllers/setting_controller.dart';
import 'package:notary_agent_app/import.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Setting"),
      body: GetBuilder(
        init: SettingController(),
        builder: (SettingController controller) {
          return Column(
            children: [
              sbh(20),
              ListTile(
                onTap: () {
                  controller.terms(context);
                },
                leading: SizedBox(
                    height: 20.0,
                    width: 20.0, // fixed width and height
                    child: Image.asset('assets/images/terms.png')),
                title: CustomText(
                  text: 'Terms and Conditions',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.privacy(context);
                },
                leading: SizedBox(
                    height: 20.0,
                    width: 20.0, // fixed width and height
                    child: Image.asset('assets/images/terms.png')),
                title: CustomText(
                  text: 'Privacy Policy',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.contactus(context);
                },
                leading: SizedBox(
                    height: 20.0,
                    width: 20.0, // fixed width and height
                    child: Image.asset('assets/images/msgcall.png')),
                title: CustomText(
                  text: 'Contact Us',
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
