import 'package:flutter/gestures.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:notary_agent_app/screens/auth/upload_signup_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../import.dart';
import '../agent/privacy.dart';
import '../agent/terms.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: CC.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CC.primary,
        leading: InkWell(
          onTap: () {
            context.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Registration",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                    Image.asset('assets/images/logo.png',
                        height: context.width / 2, fit: BoxFit.contain),
                    sbh(20),
                    AppTextFormField(
                        placeholder: "First Name",
                        validator: Validators.required,
                        onSaved: (val) => controller.firstName = val!),
                    sbh(20),
                    AppTextFormField(
                        placeholder: "Last Name",
                        validator: Validators.required,
                        onSaved: (val) => controller.lastName = val!),
                    sbh(20),
                    AppTextFormField(
                        placeholder: "Email",
                        validator: Validators.required,
                        onSaved: (val) => controller.email = val!),
                    // sbh(20),
                    // AppTextFormField(placeholder: "Phone Number", validator: Validators.required, onSaved: (val) => controller.mobile = val!),
                    sbh(20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: IntlPhoneField(
                        validator: (valid) {
                          return 'Phone Number';
                        },
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          hintText: 'Phone Number',
                          floatingLabelStyle:
                              const TextStyle(color: Color(0xFF9B9B9B)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(inputRadius)),
                          fillColor: Colors.white,
                          filled: true,
                          labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                        ),
                        initialCountryCode: 'IN',
                        onSaved: (phone) {
                          controller.mobile =
                              '${phone!.countryCode}${phone.number}';
                          print("Phone:-" + phone.countryCode.toString());
                        },
                        onChanged: (phone) {
                          controller.mobile =
                              '${phone.countryCode}${phone.number}';
                          print("Phone:-" + phone.completeNumber);
                        },
                        onCountryChanged: (countryCode) {},
                      ),
                    ),
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(inputRadius)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Checkbox(
                                value: controller.checkBox,
                                onChanged: (v) => controller.checkBox = v!),
                            sbw(10),
                            Expanded(
                                child:
                                    // Text("Terms of use and the data is processed on the terms of the Priacy Policy for the purpose specified in the questions are",
                                    //   style: const AppTextTheme(CC.grey1).heading6,),
                                    myRichText(context)),
                          ],
                        ),
                      ),
                    ),
                    sbh(60),
                    AppButton(
                      onTap: () {
                        //controller.signup(context);
                        //signUpLaunchUrl();
                        context.navigate(() => const UploadSignUpProfile());
                      },
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

  Widget myRichText(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.grey, fontSize: 16.0);
    TextStyle linkStyle = const TextStyle(
        color: Colors.indigoAccent,
        fontSize: 16.0,
        fontWeight: FontWeight.bold);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(
              text: 'Terms of use',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Terms of Service"');
                  context.navigate(() => const TermsScreen());
                }),
          const TextSpan(
              text: ' and the data is processed on the terms of the '),
          TextSpan(
              text: 'Privacy Policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Privacy Policy"');
                  context.navigate(() => const PrivacyScreen());
                }),
          const TextSpan(
              text: ' for the purpose specified in the questions are'),
        ],
      ),
    );
  }

  Future<void> signUpLaunchUrl() async {
    final Uri url =
        Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
