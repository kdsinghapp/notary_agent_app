import '../../../import.dart';

class AddRate extends StatelessWidget {
  const AddRate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Image.asset('assets/images/logo.png', height: 56)),
        centerTitle: true,
        toolbarHeight: 70,
        leading: const BackButton(),
      ),
      body: GetBuilder(
        init: AddRateController(),
        builder: (AddRateController controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomText(
                      text: "Rate The Agent",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    sbh(25),
                    for (int i = 0; i < controller.keys.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomText(
                                text: "${controller.keys[i]}",
                                textColor: CC.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    sbh(25),
                    AppTextFormField(
                      label: 'Enter',
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 32,
                    child: AppButton(
                      onTap: () {
                        controller.submitPayment(context);
                      },
                      text: "SUBMIT PAYMENT",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
