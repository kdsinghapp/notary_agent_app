import 'package:url_launcher/url_launcher.dart';

import '../../import.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: CC.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset('assets/images/logo.png',
                    height: context.height / 2,
                    width: context.width - 50,
                    fit: BoxFit.contain),
                sbh(10),
                Text('AGENTS', style: const AppTextTheme(CC.white).heading2),
                sbh(20)
              ],
            ),
            Column(
              children: [
                AppButton(
                    onTap: () => context.navigate(() => const Login()),
                    text: "Login",
                    color: CC.buttonGrey),
                sbh(30),
                AppButton(onTap: () {
                  signUpLaunchUrl();
                }, text: "Signup", color: CC.buttonGrey),
                sbh(50),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> signUpLaunchUrl() async {
    final Uri url = Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
