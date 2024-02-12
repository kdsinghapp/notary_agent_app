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
                sbh(50),
                Text('Driver', style: const AppTextTheme(CC.white).heading4),
              ],
            ),
            Column(
              children: [
                AppButton(
                    onTap: () => context.navigate(() => const Login()),
                    text: "Login",
                    color: CC.buttonGrey),
                sbh(30),
                AppButton(onTap: () {}, text: "Signup", color: CC.buttonGrey),
                sbh(50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
