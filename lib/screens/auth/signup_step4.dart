import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/utils/constant_string.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpStep4Page extends StatefulWidget {
  const SignUpStep4Page({super.key});
  @override
  State<SignUpStep4Page> createState() => _SignUpStep4State();
}

class _SignUpStep4State extends State<SignUpStep4Page> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController suiteController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController signingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController issueDateController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController signatureController = TextEditingController();
  TextEditingController rName1Controller = TextEditingController();
  TextEditingController rName2Controller = TextEditingController();
  TextEditingController rName3Controller = TextEditingController();
  TextEditingController rPhone1Controller = TextEditingController();
  TextEditingController rPhone2Controller = TextEditingController();
  TextEditingController rPhone3Controller = TextEditingController();
  TextEditingController rEmail1Controller = TextEditingController();
  TextEditingController rEmail2Controller = TextEditingController();
  TextEditingController rEmail3Controller = TextEditingController();
  TextEditingController rComment1Controller = TextEditingController();
  TextEditingController rComment2Controller = TextEditingController();
  TextEditingController rComment3Controller = TextEditingController();
  bool showProgressbar = false;
  bool btnLoading = false;
  List<bool> selectTimeStatusList = List.generate(9, (index) => false);
  List<String> checkBoxList = [
    '6:00 AM - 8:00 AM',
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
    '6:00 PM - 8:00 PM',
    '8:00 PM - 10:00 PM',
    '10:00 PM - 12:00 PM'
  ];
  Map<String, dynamic> bodyParamsForSubmitSignUpStep4Form = {};
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
          "Application Form",
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Dear Prospective Live Notaries Technologies Corporation Signing Agent',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(10),
                const Text(
                  step4header1,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
                sbh(10),
                Align(
                    alignment: Alignment.centerLeft,
                    child: myRichText(context)),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Respectfully,\n\nFarshid Sepehri\nCEO\nLive Notaries Technologies Corporation',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter first name",
                        label: 'FIRST NAME',
                        labelColor: Colors.white,
                        validator: Validators.required,
                        controller: firstNameController,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter last name",
                        label: 'LAST NAME',
                        labelColor: Colors.white,
                        validator: Validators.required,
                        controller: lastNameController,
                      ),
                    ),
                  ],
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mailing Address',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter street here",
                        label: 'STREET',
                        labelColor: Colors.white,
                        validator: Validators.required,
                        controller: streetController,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter suite here",
                        label: 'SUITE',
                        labelColor: Colors.white,
                        validator: Validators.required,
                        controller: suiteController,
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
                        placeholder: "Enter state here",
                        labelColor: Colors.white,
                        label: 'STATE',
                        validator: Validators.required,
                        controller: stateController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter zip code here",
                        labelColor: Colors.white,
                        label: 'ZIP CODE',
                        validator: Validators.required,
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
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
                        placeholder: "Enter city here",
                        labelColor: Colors.white,
                        label: 'CITY',
                        validator: Validators.required,
                        controller: cityController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter county here",
                        labelColor: Colors.white,
                        label: 'COUNTY',
                        validator: Validators.required,
                        controller: countryController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact Information',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(10),
                Container(
                  decoration: const BoxDecoration(
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
                      phoneController.text =
                          '${phone!.countryCode}${phone.number}';
                      print("Phone:-" + phone.countryCode.toString());
                    },
                    onChanged: (phone) {
                      phoneController.text =
                          '${phone.countryCode}${phone.number}';
                      print("Phone:-" + phone.completeNumber);
                    },
                    onCountryChanged: (countryCode) {},
                  ),
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter email here",
                  label: 'EMAIL ADDRESS',
                  labelColor: Colors.white,
                  validator: Validators.required,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'LICENSES AND COMMISSIONS',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter number here",
                  label: 'NOTARY LICENSE OR COMMISSION NUMBER ',
                  labelColor: Colors.white,
                  validator: Validators.required,
                  controller: licenseNumberController,
                  keyboardType: TextInputType.text,
                ),
                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "dd-mm-yyyy",
                        labelColor: Colors.white,
                        label: 'ISSUED DATE',
                        validator: Validators.required,
                        controller: issueDateController,
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
                                issueDateController.text =
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
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "dd-mm-yyyy",
                        labelColor: Colors.white,
                        label: 'EXPIRATION DATE',
                        validator: Validators.required,
                        controller: expirationDateController,
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
                                expirationDateController.text =
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
                    ),
                  ],
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PLEASE SPECIFY THE TIMES YOU ARE AVAILABLE',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 3.0),
                    itemCount: checkBoxList.length,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2)),
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox
                            Expanded(
                              flex: 6,
                              child: Text(
                                checkBoxList[index],
                                style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.normal,
                                    height: 1,
                                    color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ), //Text
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                value: selectTimeStatusList[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectTimeStatusList[index] = value!;
                                  });
                                },
                              ),
                            ), //Checkbox
                          ], //<Widget>[]
                        ),
                      );
                    }),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AREAS OF SERVICE',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please list all States and Zip Codes or States covered.',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter state here",
                        labelColor: Colors.white,
                        label: 'STATE',
                        validator: Validators.required,
                        controller: stateController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter zip code here",
                        labelColor: Colors.white,
                        label: 'ZIP CODE',
                        validator: Validators.required,
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
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
                        placeholder: "Enter state here",
                        labelColor: Colors.white,
                        label: 'STATE',
                        validator: Validators.required,
                        controller: stateController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter zip code here",
                        labelColor: Colors.white,
                        label: 'ZIP CODE',
                        validator: Validators.required,
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
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
                        placeholder: "Enter state here",
                        labelColor: Colors.white,
                        label: 'STATE',
                        validator: Validators.required,
                        controller: stateController,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter zip code here",
                        labelColor: Colors.white,
                        label: 'ZIP CODE',
                        validator: Validators.required,
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter signings here",
                  labelColor: Colors.white,
                  label: 'NOTARY SIGNINGS',
                  validator: Validators.required,
                  controller: signingController,
                  keyboardType: TextInputType.text,
                ),
                sbh(10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'References \nPlease provide at least 3 references that can attest to your professionalism and knowledge. Please be sure to only include references that can be contacted by Imzah Inc. Signings.',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),
                sbh(10),
                const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),

                /// Person 1......
                sbh(5),
                AppTextFormField(
                  placeholder: "Enter name here",
                  labelColor: Colors.white,
                  label: 'NAME',
                  controller: rName1Controller,
                  keyboardType: TextInputType.name,
                ),
                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter phone here",
                        labelColor: Colors.white,
                        label: 'CONTACT NUMBER',
                        controller: rPhone1Controller,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter email here",
                        labelColor: Colors.white,
                        label: 'EMAIL ADDRESS',
                        controller: rEmail1Controller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter comment here",
                  labelColor: Colors.white,
                  label: 'COMMENTS',
                  controller: rComment1Controller,
                  keyboardType: TextInputType.name,
                ),
                sbh(10),
                const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),

                /// Person 2......
                sbh(5),
                AppTextFormField(
                  placeholder: "Enter name here",
                  labelColor: Colors.white,
                  label: 'NAME',
                  controller: rName2Controller,
                  keyboardType: TextInputType.name,
                ),
                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter phone here",
                        labelColor: Colors.white,
                        label: 'CONTACT NUMBER',
                        controller: rPhone2Controller,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter email here",
                        labelColor: Colors.white,
                        label: 'EMAIL ADDRESS',
                        controller: rEmail2Controller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter comment here",
                  labelColor: Colors.white,
                  label: 'COMMENTS',
                  controller: rComment2Controller,
                  keyboardType: TextInputType.name,
                ),
                sbh(10),
                const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),

                /// Person 3......
                sbh(5),
                AppTextFormField(
                  placeholder: "Enter name here",
                  labelColor: Colors.white,
                  label: 'NAME',
                  controller: rName3Controller,
                  keyboardType: TextInputType.name,
                ),
                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter phone here",
                        labelColor: Colors.white,
                        label: 'CONTACT NUMBER',
                        controller: rPhone3Controller,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter email here",
                        labelColor: Colors.white,
                        label: 'EMAIL ADDRESS',
                        controller: rEmail3Controller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                sbh(15),
                AppTextFormField(
                  placeholder: "Enter comment here",
                  labelColor: Colors.white,
                  label: 'COMMENTS',
                  controller: rComment3Controller,
                  keyboardType: TextInputType.name,
                ),

                sbh(20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thank you, if you have any questions, please email: info@notarymobility.com',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        height: 1,
                        color: Colors.white),
                  ),
                ),

                sbh(15),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "Enter full name here",
                        labelColor: Colors.white,
                        label: 'FULL NAME',
                        validator: Validators.required,
                        controller: fullNameController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppTextFormField(
                        placeholder: "dd-mm-yyyy",
                        labelColor: Colors.white,
                        label: 'DATE',
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
                AppButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                    } else {
                      showError(context, 'Please complete all field ...');
                    }
                  },
                  text: "SUBMIT",
                  color: Colors.indigoAccent,
                  loading: btnLoading,
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
          const TextSpan(text: 'Learn more at '),
          TextSpan(
              text: 'http://www.notarymobility.com',
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
    final Uri url = Uri.parse('http://www.notarymobility.com');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> callingSubmitSignUpStep4Form() async {
    bodyParamsForSubmitSignUpStep4Form = {
      'id': 'userId',
      'first_name': firstNameController.text.toString(),
      'last_name': lastNameController.text.toString(),
      'street': streetController.text.toString(),
      'suite': suiteController.text.toString(),
      'country': countryController.text.toString(),
      'city': cityController.text.toString(),
      'zipcode': zipCodeController.text.toString(),
      'state': stateController.text.toString(),
      // 'mobile': businessInfoController.text.toString(),
      // 'account_info': accountInfoController.text.toString(),
      // 'social_security': securityNumberController.text.toString(),
      // 'identyNumber': indentyNumberController.text.toString(),
      // 'usa_person': usaPersonNameController.text.toString(),
      'date': dateController.text.toString(),
      'signature': signatureController.text.toString(),
    };
    print(
        "bodyParamsForSubmitSignUpStep3Form:::::$bodyParamsForSubmitSignUpStep4Form");
    var res =
        await api().post('signup4', data: bodyParamsForSubmitSignUpStep4Form);

    setState(() {
      btnLoading = false;
    });
  }
}
