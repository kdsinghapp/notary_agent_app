import '../../import.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: CC.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CC.primary,
        leading: const BackButton(),
        title: const Text("Signup"),
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
          init: SignupController(),
          builder: (SignupController controller) {
            return Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sbh(20),
                    Image.asset('assets/images/logo.png', height: context.width / 2, fit: BoxFit.contain),
                    sbh(40),
                    AppTextFormField(placeholder: "First Name", validator: Validators.required, onSaved: (val) => controller.firstName = val!),
                    sbh(20),
                    AppTextFormField(placeholder: "Last Name", validator: Validators.required, onSaved: (val) => controller.lastName = val!),
                    sbh(20),
                    AppTextFormField(placeholder: "Email", validator: Validators.required, onSaved: (val) => controller.email = val!),
                    sbh(20),
                    AppTextFormField(placeholder: "Phone Number", validator: Validators.required, onSaved: (val) => controller.mobile = val!),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Password",
                      validator: Validators.required,
                      obscureText: true,
                      onSaved: (val) => controller.password = val!,
                    ),
                    // sbh(20),
                    // const AppTextFormField(placeholder: "Promo Code"),
                    sbh(20),
                    GestureDetector(
                      onTap: () => controller.checkBox = !controller.checkBox,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(inputRadius)),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Checkbox(value: controller.checkBox, onChanged: (v) => controller.checkBox = v!),
                            sbw(10),
                            Expanded(
                              child: Text(
                                "Terms of use and the data is processed on the terms of the Priacy Policy for the purpose specified in the questions are",
                                style: const AppTextTheme(CC.grey1).heading6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    sbh(60),
                    AppButton(
                      onTap: () => controller.signup(context),
                      text: "Signup",
                      color: CC.buttonGrey,
                      loading: controller.loading,
                      disabled: !controller.checkBox,
                    ),
                    sbh(20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
