import '../../import.dart';

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
                      Text("Forgot Password?", style: const AppTextTheme(CC.white).display4),
                      sbh(20),
                      Text("Or", style: const AppTextTheme(CC.white).display4),
                      sbh(40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google.png', height: 50, width: 50),
                          sbw(60),
                          Image.asset('assets/images/facebook.png', height: 50, width: 50),
                        ],
                      ),
                      sbh(40),
                      GestureDetector(
                        onTap: () => context.navigate(() => const Signup()),
                        child: Text("Don’t have an account? Sign up now", style: const AppTextTheme(CC.white).display4),
                      ),
                      sbh(20),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
