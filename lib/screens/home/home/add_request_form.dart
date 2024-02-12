import '../../../import.dart';

class AddRequestForm extends StatelessWidget {
  const AddRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffdad6d6),
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Image.asset('assets/images/logo.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: const BackButton(),
      ),
      body: GetBuilder(
          init: NotaryFormController(),
          builder: (NotaryFormController controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextFormField(
                      label: "Select Date (25 Extra Weekend charge)",
                      onTap: () {},
                    ),
                    sbh(20),
                    AppTextFormField(
                      label: "Select Time (25 Extra Weekend charge)",
                      onTap: () {},
                    ),
                    sbh(20),
                    AppTextFormField(
                      label: "Enter Signing Location",
                      maxLines: 4,
                      onTap: () {},
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.my_location_sharp),
                      ),
                    ),
                    sbh(20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropDown(
                              label: "Witness",
                              itemList: [
                                {"name": "Yes", "id": "Yes"},
                                {"name": "No", "id": "No"},
                              ],
                            ),
                          ),
                          sbw(15),
                          Expanded(
                            child: DropDown(
                              label: "State",
                              itemList: [
                                {"name": "first", "id": "1"},
                                {"name": "second", "id": "2"},
                                {"name": "third", "id": "3"},
                                {"name": "fourth", "id": "4"},
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    sbh(20),
                    DropDown(
                      label: "Type of Signing",
                      itemList: [
                        {"name": "Yes", "id": "Yes"},
                        {"name": "No", "id": "No"},
                      ],
                    ),
                    sbh(20),
                    DropDown(
                      label: "Location Type",
                      itemList: [
                        {"name": "Yes", "id": "Yes"},
                        {"name": "No", "id": "No"},
                      ],
                    ),
                    sbh(20),
                    DropDown(
                      label: "Number of Signing",
                      itemList: [
                        {"name": "Yes", "id": "Yes"},
                        {"name": "No", "id": "No"},
                      ],
                    ),
                    sbh(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            label: "Name",
                            onTap: () {},
                          ),
                        ),
                        sbw(20),
                        Expanded(
                          child: AppTextFormField(
                            label: "Phone",
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                    sbh(20),
                    AppTextFormField(
                      label: "Email",
                      onTap: () {},
                    ),
                    sbh(20),
                    DropDown(
                      label: "Real Estate Signing",
                      itemList: [
                        {"name": "Yes", "id": "Yes"},
                        {"name": "No", "id": "No"},
                      ],
                    ),
                    sbh(20),
                    Text(
                      "DISCLAIMER",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                    sbh(20),
                    Container(
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
                              child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'understand that notary agents are independent agent and I have read the ',
                                    style: TextStyle(
                                        color: CC.black,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: ' Term of Conditions !',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: ' and',
                                    style: TextStyle(
                                        color: CC.black,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: ' Privacy policy',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w600)),
                                TextSpan(
                                    text: ' .',
                                    style: TextStyle(color: CC.black)),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    sbh(20),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: AppButton(
                        onTap: () {
                          controller.Booknow(context);
                        },
                        text: "BOOK NOW",
                        color: Colors.red,
                      ),
                    ),
                    sbh(20),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
