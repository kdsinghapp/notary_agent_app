import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:notary_agent_app/import.dart';

class SignUpStatus extends StatefulWidget {
  const SignUpStatus({super.key});
  @override
  State<SignUpStatus> createState() => _SignUpStatusState();
}

class _SignUpStatusState extends State<SignUpStatus> {
  bool showProgressbar = false;
  bool btnLoading = false;

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
          "Registration Status",
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
              Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Text(
                        '5/5 : UPLOAD DOCUMENTS',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            height: 1,
                            fontSize: 14),
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 10,
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      clipBehavior: Clip.hardEdge,
                      child: LinearProgressBar(
                        maxSteps: 5,
                        progressType: LinearProgressBar
                            .progressTypeLinear, // Use Linear progress
                        currentStep: 4,
                        minHeight: 10,
                        progressColor: Colors.lightBlueAccent,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              sbh(10),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              sbh(10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text(
                    'Driver\'s License',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Under the verification process',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Text(
                      'Uploaded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              sbh(10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text(
                    'Driver Photo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Under the verification process',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Text(
                      'Uploaded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              sbh(10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text(
                    'Copy of bond',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Under the verification process',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Text(
                      'Uploaded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              sbh(10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text(
                    'Copy of notary license',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Under the verification process',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Text(
                      'Uploaded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              sbh(10),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  title: const Text(
                    'Copy of background check required',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  subtitle: const Text(
                    'Under the verification process',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: const Text(
                      'Uploaded',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              sbh(20),
              AppButton(
                onTap: () {},
                text: "NEXT",
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
