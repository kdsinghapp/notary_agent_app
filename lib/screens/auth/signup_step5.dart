import 'package:flutter/gestures.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/screens/auth/signup_status.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpStep5Page extends StatefulWidget {
  const SignUpStep5Page({super.key});
  @override
  State<SignUpStep5Page> createState() => _SignUpStep4State();
}

class _SignUpStep4State extends State<SignUpStep5Page> {
  TextEditingController by1Controller = TextEditingController();
  TextEditingController by2Controller = TextEditingController();
  TextEditingController title1Controller = TextEditingController();
  TextEditingController title2Controller = TextEditingController();
  TextEditingController contractorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController signatureController = TextEditingController();
  bool showProgressbar = false;
  bool btnLoading = false;
  bool checkBoxStatus = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Notary Agent Agreement",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png',
                  height: context.width / 4, fit: BoxFit.contain),
              sbh(10),
              Align(
                  alignment: Alignment.centerLeft, child: myRichText(context)),
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'COMPANY',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Live Notaries Technologies Corp.\n4401-A Connecticut Ave., NW\nSuite #777\nWashington, DC 20008',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter contractor here",
                label: 'INDEPENDENT CONTRACTOR',
                labelColor: Colors.white,
                validator: Validators.required,
                controller: contractorController,
                keyboardType: TextInputType.text,
                maxLines: 3,
              ),
              sbh(15),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter name here",
                      label: 'BY',
                      labelColor: Colors.white,
                      validator: Validators.required,
                      controller: by1Controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter title here",
                      label: 'TITLE ',
                      labelColor: Colors.white,
                      validator: Validators.required,
                      controller: title1Controller,
                    ),
                  ),
                ],
              ),
              sbh(15),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter name here",
                      label: 'BY',
                      labelColor: Colors.white,
                      validator: Validators.required,
                      controller: by2Controller,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter title here",
                      label: 'TITLE ',
                      labelColor: Colors.white,
                      validator: Validators.required,
                      controller: title2Controller,
                    ),
                  ),
                ],
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "",
                labelColor: Colors.white,
                label: 'Signature',
                validator: Validators.required,
                controller: signatureController,
                keyboardType: TextInputType.text,
              ),
              sbh(20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'EXHIBIT A',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter description here",
                label: 'DESCRIPTION OF THE SERVICES TO BE PERFORMED',
                labelColor: Colors.white,
                controller: descriptionController,
                keyboardType: TextInputType.text,
              ),
              sbh(20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(inputRadius)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Checkbox(
                        value: checkBoxStatus,
                        onChanged: (v) {
                          setState(() {
                            checkBoxStatus = v!;
                          });
                        }),
                    sbw(5),
                    const Expanded(
                      child: Text(
                        'I have read the notary agreement thoroughly. I am satisfied with all the points of the agreement.',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            height: 1,
                            color: Colors.black87),
                      ),
                    )
                  ],
                ),
              ),
              sbh(20),
              AppButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpStatus()));
                },
                text: "SUBMIT",
                color: Colors.indigoAccent,
                loading: btnLoading,
                disabled: !checkBoxStatus,
                borderRadius: BorderRadius.circular(25),
              ),
              sbh(20),
            ],
          ),
        ),
      ),
    );
  }

  Widget myRichText(BuildContext context) {
    TextStyle defaultStyle =
        const TextStyle(color: Colors.white, fontSize: 14.0);
    TextStyle linkStyle = const TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 14.0,
        fontWeight: FontWeight.bold);
    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          const TextSpan(text: 'Read notary agreement at '),
          TextSpan(
              text: 'https://dcmdmobilenotary.com/laravel/register_agent_new',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  openNotaryWebSide();
                }),
        ],
      ),
    );
  }

  Future<void> openNotaryWebSide() async {
    final Uri url =
        Uri.parse('https://dcmdmobilenotary.com/laravel/register_agent_new');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
