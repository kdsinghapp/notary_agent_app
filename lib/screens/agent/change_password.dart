import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/models/ChangePasswordModel.dart';

import '../../apis/CustomSnackBar.dart';
import '../../utils/auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPass =  TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController conPass =  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool btnLoading=false;

  changePassword() async {
    String userId = await getCurrentUserId();
    try {
      final res = await api().post('change_password', data: {
        "user_id": userId,
        "new_pass": newPass.text.toString(),
        "old_pass": oldPass.text.toString()
      });
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from change password ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      print("data is....${ChangePasswordModel.fromJson(res.data)}");

      final data = ChangePasswordModel.fromJson(res.data);
      print("data is....$data");
      if (data.status == "true") {
       showSnackbar(context,"Password changed successfully");
      } else {
        showSnackbar(context,"Password could't be changed successfully");
      }
    } catch (e) {
      showSnackbar(context,"$e");
      print(e);
    }
    setState(() {
      btnLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Change Password",
        isCentre: true,
        context: context,elevation: 0
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color:CC.primary,
              child: Image.asset(
                "assets/images/logo.png",
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [

                    sbh(MediaQuery.of(context).size.height * 0.05),
                    AppTextFormField(
                      controller: oldPass,
                      placeholder: "Old Password",
                      validator: Validators.required,
                      obscureText: true,
                      //onSaved: (val) => controller.password = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      controller: newPass,
                      placeholder: "New Password",
                      validator: Validators.required,
                      obscureText: true,
                      // onSaved: (val) => controller.newpassword = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      controller: conPass,
                      placeholder: "Conform Password",
                      validator: Validators.required,
                      obscureText: true,
                    ),
                    sbh(60),
                    AppButton(
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          if(newPass.text==conPass.text){

                            setState(() {
                              btnLoading=true;
                              changePassword();
                            });

                          }
                          else{
                            showSnackbar(context, 'new password and confirm password should be same');
                          }
                        } else{
                          showSnackbar(context, 'Enter all field.');
                        }

                      },
                      text: "CHANGE PASSWORD",
                      loading: btnLoading,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
