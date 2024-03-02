import 'package:notary_agent_app/import.dart';

import '../../apis/CustomSnackBar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  bool btnLoading = false;

  callingForgotPassword() async {
    try {
      final res = await api().post('forgot_password', data: {
        "email": email.text.toString(),
      });
      print("res from forgot password ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      // final data = ChangePasswordModel.fromJson(res.data);
      // print("data is....$data");
      if (res.data['status'] == "1") {
        showSnackbar(context,
            "Please check your email box.Your new password have sended to this email id.");
        Navigator.pop(context);
      } else {
        showSnackbar(context, "Password could't be changed successfully");
      }
    } catch (e) {
      showSnackbar(context, "$e");
      print(e);
    }
    setState(() {
      btnLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CC.primary,
      appBar: appBar(title: "Forgot Password", context: context, elevation: 0),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sbh(MediaQuery.of(context).size.height * 0.05),
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              sbh(MediaQuery.of(context).size.height * 0.05),
              sbh(20),
              const Text(
                'After successfully completed forgot password .\n Please check your email box.',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              sbh(20),
              AppTextFormField(
                controller: email,
                placeholder: "Email id",
                validator: Validators.required,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              sbh(150),
              AppButton(
                onTap: () {
                  if (email.text.isNotEmpty) {
                    setState(() {
                      btnLoading = true;
                      callingForgotPassword();
                    });
                  } else {
                    showError(context, 'Enter valid email.');
                  }
                },
                text: "FORGOT PASSWORD",
                color: CC.buttonGrey,
                loading: btnLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
