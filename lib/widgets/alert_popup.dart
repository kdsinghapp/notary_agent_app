import 'package:notary_agent_app/import.dart';

displayDialog(BuildContext context, String title, String btnText, String para,
    bool isMsg, Function() onTap) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          // title: ,
          content: Container(
            height: isMsg ? 315 : 170,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                sbh(15),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                      child: CustomText(
                    text: '${title}',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                sbh(15),
                if (isMsg)
                  Column(
                    children: [
                      CustomText(
                        text: "John smith",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textColor: Color(0xff555555),
                      ),
                      sbh(15),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/express.png'),
                      ),
                      sbh(15),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomText(
                    text: "${para}",
                    // "107, 1st Floor Sapphire House, Sapna Sangeeta Main Road, Snehagat Agrasen Square, Snehnagar, Indore, Madhya Pradesh 452001, India Date 2021-02-04 1905",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: Color(0xff555555),
                    textAlign: TextAlign.center,
                  ),
                ),
                // sbh(15),
                AppButton(
                  onTap: onTap,
                  text: "Ok",
                  color: Colors.white,
                  textColor: Colors.black,
                )
              ],
            ),
          ),
          // actions: <Widget>[
          //   Center(
          //     child: new TextButton(
          //       child: new Text('${btnText}'),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //     ),
          //   )
          // ],
        );
      });
}
