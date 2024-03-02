import 'package:intl/intl.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/screens/auth/signup_step4.dart';
import 'package:notary_agent_app/utils/constant_string.dart';

class SignUpStep3Page extends StatefulWidget {
  const SignUpStep3Page({super.key});
  @override
  State<StatefulWidget> createState() => _SignUpStep3State();
}

class _SignUpStep3State extends State<SignUpStep3Page> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController payeeCodeController = TextEditingController();
  TextEditingController fatcaCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController businessInfoController = TextEditingController();
  TextEditingController accountInfoController = TextEditingController();
  TextEditingController securityNumberController = TextEditingController();
  TextEditingController indentyNumberController = TextEditingController();
  TextEditingController usaPersonNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController signatureController = TextEditingController();
  bool showProgressbar = false;
  bool btnLoading = false;
  int selectIndex = 0;
  List<String> checkBoxList = [
    'Individual/sole proprietor',
    'C Corporation',
    'S Corporation',
    'Partnership',
    'Trust/estate or single-member LLC',
    'Limited liability company',
    'Other'
  ];

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
          "Your Business Details",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png',
                  height: context.width / 4, fit: BoxFit.contain),
              sbh(20),
              AppTextFormField(
                placeholder: "Full Name",
                label: 'FULL NAME (AS SHOWN ON YOUR INCOME TAX RETURN). ',
                labelColor: Colors.white,
                validator: Validators.required,
                controller: fullNameController,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter name here",
                label:
                    'BUSINESS NAME/DISREGARDED ENTITY NAME, IF DIFFERENT FROM ABOVE',
                labelColor: Colors.white,
                validator: Validators.required,
                controller: businessNameController,
              ),
              sbh(15),
              const Text(
                checkBoxTitle,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white),
              ),
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'FEDERAL TAX CLASSIFICATION',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 3.0),
                  itemCount: checkBoxList.length,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SizedBox
                          Expanded(
                            flex: 6,
                            child: Text(
                              checkBoxList[index],
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                  color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), //Text
                          Expanded(
                            flex: 1,
                            child: Checkbox(
                              value: selectIndex == index,
                              onChanged: (bool? value) {
                                setState(() {
                                  selectIndex = index;
                                });
                              },
                            ),
                          ), //Checkbox
                        ], //<Widget>[]
                      ),
                    );
                  }),
              RichText(
                text: const TextSpan(
                  text: 'Note:- ',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  children: [
                    TextSpan(
                        text: step3Note,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.white)),
                  ],
                ),
              ),
              sbh(10),
              const Text(
                'Exemptions (codes apply only to certain entities, not individuals)',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white),
              ),
              sbh(10),
              AppTextFormField(
                placeholder: "Enter code here",
                labelColor: Colors.white,
                label: 'EXEMPT PAYEE CODE',
                validator: Validators.required,
                controller: payeeCodeController,
                keyboardType: TextInputType.text,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter code here",
                labelColor: Colors.white,
                label: 'EXEMPTION FROM FATCA REPORTING CODE',
                validator: Validators.required,
                controller: fatcaCodeController,
                keyboardType: TextInputType.text,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter address here",
                labelColor: Colors.white,
                label: 'ADDRESS (NUMBER, STREET, AND APT. OR SUITE NO.)',
                validator: Validators.required,
                controller: addressController,
                keyboardType: TextInputType.text,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter city here",
                labelColor: Colors.white,
                label: 'CITY',
                validator: Validators.required,
                controller: cityController,
                keyboardType: TextInputType.text,
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
                placeholder: "Enter information here",
                labelColor: Colors.white,
                label: 'REQUESTER’S NAME AND ADDRESS',
                validator: Validators.required,
                controller: businessInfoController,
                keyboardType: TextInputType.text,
                maxLines: 3,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter information here",
                labelColor: Colors.white,
                label: 'LIST ACCOUNT NUMBER(S) HERE',
                validator: Validators.required,
                controller: accountInfoController,
                keyboardType: TextInputType.text,
              ),
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Part I Taxpayer Identification Number (TIN)',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(10),
              const Text(
                stet3TIN,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white),
              ),
              sbh(15),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter number here",
                      labelColor: Colors.white,
                      label: 'SOCIAL SECURITY NUMBER',
                      controller: securityNumberController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AppTextFormField(
                      placeholder: "Enter number here",
                      labelColor: Colors.white,
                      label: 'IDENTIFICATION NUMBER',
                      controller: indentyNumberController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              sbh(10),
              RichText(
                text: const TextSpan(
                  text: 'Note:- ',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  children: [
                    TextSpan(
                        text: step3Note2,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.white)),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
              sbh(15),
              AppTextFormField(
                placeholder: "Enter name here",
                labelColor: Colors.white,
                label: 'NAME OF UNITED STATES PERSON',
                controller: usaPersonNameController,
                validator: Validators.required,
                keyboardType: TextInputType.text,
              ),
              sbh(15),
              AppTextFormField(
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
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'General Instructions',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(10),
              const Text(
                step3GeneralInstructions,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              sbh(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Purpose of Form',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              sbh(10),
              const Text(
                step3PurposeOfForm,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white),
                textAlign: TextAlign.justify,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpStep4Page()));
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
    );
  }
}
