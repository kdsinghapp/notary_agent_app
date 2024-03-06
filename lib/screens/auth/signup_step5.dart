import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/screens/auth/signup_status.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/auth.dart';
import '../../widgets/ShowToast.dart';

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
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController signatureController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool showProgressbar = false;
  bool btnLoading = false;
  bool checkBoxStatus = false;
  Map<String, dynamic> bodyParamsForSubmitSignUpStep5Form = {};
  final GlobalKey<FormState> formKey = GlobalKey();

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/logo.png',
                    height: context.width / 4, fit: BoxFit.contain),
                sbh(10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: myRichText(context)),
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
                AppTextFormField(
                  placeholder: "Enter address here",
                  label: 'INDEPENDENT CONTRACTOR ADDRESS',
                  labelColor: Colors.white,
                  validator: Validators.required,
                  controller: addressController,
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
                  placeholder: "dd-mm-yyyy",
                  labelColor: Colors.white,
                  label: 'Agreement Date',
                  validator: Validators.required,
                  controller: dateController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                    child: const Icon(
                      Icons.date_range,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        btnLoading = true;
                        callingSubmitSignUpStep5Form();
                      });
                    } else {
                      showError(context, 'Please complete all fields ...');
                    }
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

  Future<void> callingSubmitSignUpStep5Form() async {
    try {
      bodyParamsForSubmitSignUpStep5Form = {
        'agent_id': await getCurrentUserId(),
        'aggrement_date': dateController.text.toString(),
        'Name_of_Independent_Contractor': contractorController.text.toString(),
        'Address_of_Independent_Contractor': addressController.text.toString(),
        'Doc1venue': 'Some venue',
        'Independent_Contractor': 'Yes',
        'By': by1Controller.text.toString(),
        'By_': by2Controller.text.toString(),
        'Title': title1Controller.text.toString(),
        'Title_': title2Controller.text.toString(),
        'Signature': signatureController.text.toString(),
        'Description_of_the_services_to_be_performed':
            descriptionController.text.toString()
      };
      print(
          "bodyParamsForSubmitSignUpStep5Form:::::$bodyParamsForSubmitSignUpStep5Form");
      var res = await api().post('new_agent_quick_step_5',
          data: bodyParamsForSubmitSignUpStep5Form);
      print("res from signUp step5 ------------------${res.data}");
      print("status ------------------${res.data['status']}");
      if (res.data['status'] == '1') {
        showToastMessage('Successfully completed your agreement step.');
        context.replace(() => SignUpStatus());
      } else {
        showError(context, res.data['message']);
      }
    } catch (e) {
      showError(context, e.toString());
    }
    setState(() {
      btnLoading = false;
    });
  }
}
