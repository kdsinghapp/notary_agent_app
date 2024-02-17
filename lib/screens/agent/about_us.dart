import 'package:notary_agent_app/import.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "About Us"),
      body: GetBuilder(
          init: AboutUsController(),
          builder: (AboutUsController controller) {
            return Container(
                padding: EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbh(20),
                    const CustomText(
                      text: "More Information",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    sbh(20),
                    ListTile(
                      onTap: () {
                        myLauncherURL('https://dcmdmobilenotary.com/laravel/');
                      },
                      leading: SizedBox(
                          height: 20.0,
                          width: 20.0, // fixed width and height
                          child: Image.asset('assets/images/clip.png')),
                      title:const  CustomText(
                        text: 'http://www.notarymobility.com',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        myLauncherURL('mailto:admin@notarymobility.com');
                      },
                      leading: SizedBox(
                          height: 20.0,
                          width: 20.0, // fixed width and height
                          child: Image.asset('assets/images/mail.png')),
                      title: const CustomText(
                        text: 'admin@notarymobility.com',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        myLauncherURL('https://www.google.com/maps/search/?api=1&query=38.945760,-77.063920');
                      },
                      leading: SizedBox(
                          height: 20.0,
                          width: 20.0, // fixed width and height
                          child: Image.asset('assets/images/pinn.png')),
                      title: const CustomText(
                        text:
                            '4401-A Connecticut Ave Suite #777 Washington, DC. 20008',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ));
          }),
    );
  }


  myLauncherURL(String myUrl) async {
    final Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
