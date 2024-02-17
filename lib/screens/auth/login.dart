import 'package:url_launcher/url_launcher.dart';

import '../../import.dart';
import '../agent/forgot_password.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: CC.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CC.primary,
        leading: const BackButton(),
        title: const Text("Login"),
      ),
      bottomNavigationBar:Container(
         padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child:   GestureDetector(
          onTap: () {
            //context.navigate(() => const Signup());
            signUpLaunchUrl();
          },
          child: Text("Don’t have an account? Sign up now", style: const AppTextTheme(CC.white).display4,
            textAlign:TextAlign.center ,),
        ),
      ) ,
      body: GetBuilder(
          init: LoginController(),
          builder: (LoginController controller) {
            return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sbh(20),
                      Image.asset('assets/images/logo.png', width: context.width - 60, fit: BoxFit.contain),
                      sbh(40),
                      AppTextFormField(
                        placeholder: "Email",
                        validator: Validators.required,
                        onSaved: (val) => controller.email = val!,
                      ),
                      sbh(20),
                      AppTextFormField(
                        placeholder: "Password",
                        validator: Validators.required,
                        obscureText: true,
                        onSaved: (val) => controller.password = val!,
                      ),
                      sbh(60),
                      AppButton(onTap: () => controller.login(context), text: "Login", color: CC.buttonGrey, loading: controller.loading),
                      sbh(26),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          const ForgotPassword()));
                        },
                          child: Container(
                            height: 40, width: double.infinity,
                              alignment: Alignment.center,
                              child: Text("Forgot Password?", style: const AppTextTheme(CC.white).display4))),
                     /* sbh(20),
                      Text("Or", style: const AppTextTheme(CC.white).display4),
                      sbh(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png', height: 50, width: 50),
                          sbw(60),
                          Image.asset('assets/images/facebook.png', height: 50, width: 50),
                        ],
                      ),  */
                      //sbh(40),

                      sbh(20),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
  Future<void> signUpLaunchUrl() async {
    final Uri url = Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
