import 'package:notary_agent_app/import.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, title: "Profile"),
      body: GetBuilder(
          init: ProfileController(),
          builder: (ProfileController controller) {
            return Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sbh(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    "assets/images/p1.png",
                                    height: 43,
                                    width: 43,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                sbh(10),
                                CustomText(
                                  text: "Home",
                                  fontSize: 12,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    "assets/images/p2.png",
                                    height: 43,
                                    width: 43,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                sbh(10),
                                CustomText(
                                  text: "Earning",
                                  fontSize: 12,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    "assets/images/pp.png",
                                    height: 43,
                                    width: 43,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                sbh(10),
                                CustomText(
                                  text: "Profile",
                                  fontSize: 12,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                    "assets/images/p4.png",
                                    height: 43,
                                    width: 43,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                sbh(10),
                                CustomText(
                                  text: "Signing",
                                  fontSize: 12,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    sbh(20),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black, width: 2),
                          color: Colors.blue),
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "First Name",
                      controller: TextEditingController(text: controller.getFirstName),
                      validator: Validators.required,
                      onSaved: (val) => controller.firstName = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Last Name",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Phone Number",
                      validator: Validators.required,
                      readOnly: true,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Email",
                      readOnly: true,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Country",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "State",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "City",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Address",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppTextFormField(
                      placeholder: "Zip Code",
                      validator: Validators.required,
                      // onSaved: (val) => controller.email = val!,
                    ),
                    sbh(20),
                    AppButton(
                      onTap: () {
                        controller.Edit(context);
                      },
                      text: "EDIT",
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
