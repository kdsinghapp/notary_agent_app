import 'package:http/http.dart' as http;
import 'package:notary_agent_app/screens/auth/upload_other_document.dart';

import '../../import.dart';
import '../../utils/auth.dart';
import '../../utils/http_methods.dart';
import '../../widgets/ShowToast.dart';
import '../../widgets/dotted_border.dart';

class UploadSignUpProfile extends StatefulWidget {
  const UploadSignUpProfile({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UploadSignUpProfileState();
  }
}

class _UploadSignUpProfileState extends State<UploadSignUpProfile> {
  int tabIndex = 0;
  bool btnLoading = false;
  bool checkBox = false;
  File? drivingLicense;
  File? driverProfile;
  Map<String, dynamic> bodyParamsForNormalSignUpForm = {};
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: CC.primary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CC.primary,
          leading: InkWell(
            onTap: () {
              if (tabIndex == 1) {
                setState(() {
                  tabIndex = 0;
                });
              } else {
                context.pop(context);
              }
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.white,
            ),
          ),
          title: const Text(
            "Registration",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: tabIndex == 0
                ? uploadDrivingLicenceImage()
                : uploadDriverImage()));
  }

  Widget uploadDrivingLicenceImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png',
              height: context.width / 4, fit: BoxFit.contain),
          sbh(20),
          DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            dashPattern: const [8, 4],
            strokeWidth: 2,
            radius: const Radius.circular(12),
            //padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(
                children: [
                  if (drivingLicense != null)
                    Image.file(
                      drivingLicense!,
                      height: 200,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  Container(
                    height: 200,
                    width: 300,
                    color: Colors.grey.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.photo_camera,
                          color: Colors.black87,
                          size: 40,
                        ),
                        sbh(5),
                        const Text(
                          'Click here to upload a \n Driver\'s License.',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        sbh(5),
                        GestureDetector(
                          onTap: () async {
                            getImage(0);
                          },
                          child: Container(
                            height: 30,
                            width: 150,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black87, width: 1),
                              color: Colors.white,
                            ),
                            child: const Text(
                              'Upload Photo',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh(20),
                const Text(
                  'Make sure your Driver\'s License is not expired and avoid using flash so that your information is clear and visible.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(20),
                const Text(
                  '* Is current (not expired)',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Matches the vehicle on file with Lyft',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Is not blurry',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Includes all four corners in the photo',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          sbh(60),
          AppButton(
            onTap: () {
              if (drivingLicense != null) {
                setState(() {
                  tabIndex = 1;
                });
              } else {
                showError(context, 'Please select Driver\'s license');
              }
            },
            text: "Next",
            color: Colors.indigoAccent,
            loading: btnLoading,
            borderRadius: BorderRadius.circular(25),
          ),
          sbh(20),
        ],
      ),
    );
  }

  Widget uploadDriverImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png',
              height: context.width / 4, fit: BoxFit.contain),
          sbh(20),
          DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            dashPattern: const [8, 4],
            strokeWidth: 2,
            radius: const Radius.circular(12),
            //padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(
                children: [
                  if (driverProfile != null)
                    Image.file(
                      driverProfile!,
                      height: 200,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
                  Container(
                    height: 200,
                    width: 300,
                    color: Colors.grey.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.photo_camera,
                          color: Colors.black87,
                          size: 40,
                        ),
                        sbh(5),
                        const Text(
                          'Click here to upload a \n photo.',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        sbh(5),
                        GestureDetector(
                          onTap: () {
                            getImage(1);
                          },
                          child: Container(
                            height: 30,
                            width: 150,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.black87, width: 1),
                              color: Colors.white,
                            ),
                            child: const Text(
                              'Add driver photo',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh(20),
                const Text(
                  'Example Driver Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sbh(20),
                Image.asset('assets/images/img_girl.jpg',
                    height: context.width / 2, fit: BoxFit.contain),
                sbh(30),
                const Text(
                  'Driver photo \n requirements',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                sbh(20),
                const Text(
                  '* Put on big smile',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* No hats,sunglasses, or Bluetooth  headsets',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Keep entire head and both shoulders in \n the frame',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* No blurriness',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Good lighting and a solid background',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(5),
                const Text(
                  '* Photo should be oriented horizontally like \n in the example',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                sbh(20),
                Row(
                  children: [
                    Checkbox(
                      value: checkBox,
                      onChanged: (v) {
                        setState(() {
                          checkBox = v!;
                        });
                      },
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                    ),
                    const Text(
                      'I have read the requirements',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          sbh(60),
          AppButton(
            onTap: () {
              if (driverProfile != null && drivingLicense != null) {
                setState(() {
                  btnLoading = true;
                  List<File>? files = [drivingLicense!, driverProfile!];
                  uploadProfileApi(files);
                });
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const UploadOtherDocument()));
              } else {
                showError(context, 'Please select driver profile');
              }
              //controller.signup(context);
            },
            text: "SAVE",
            color: Colors.indigoAccent,
            loading: btnLoading,
            borderRadius: BorderRadius.circular(25),
            disabled: !checkBox,
            //enabled: checkBox,
          ),
          sbh(20),
        ],
      ),
    );
  }

  Future getImage(int i) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (i == 0) {
        print("Image :-${pickedFile.path}");
        drivingLicense = File(pickedFile.path);
      } else {
        driverProfile = File(pickedFile.path);
      }
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future<void> uploadProfileApi(List<File>? selectedFile) async {
    try {
      print("Starting....");
      bodyParamsForNormalSignUpForm = {
        'agent_id': await getCurrentUserId(),
      };
      print("bodyParamsForNormalSignUpForm:::::$bodyParamsForNormalSignUpForm");
      http.Response? response = await editProfileApi(
          bodyParams: bodyParamsForNormalSignUpForm, image: selectedFile);
      print(
          "upload signup profile images ------------------${response!.statusCode}");
      print("upload signup profile images ------------------${response!.body}");
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['status'] == '1') {
        showToastMessage('Successfully completed your upload profile step.');
        context.replace(() => UploadOtherDocument());
      } else {
        print("False" + jsonData['message']);
        showError(context, jsonData['message']);
      }
    } catch (e) {
      print("Error:-" + e.toString());
      showError(context, e);
    }

    setState(() {
      btnLoading = false;
    });
  }

  /// Edit Profile  Api Calling .....
  static Future<http.Response?> editProfileApi(
      {void Function(int)? checkResponse,
      Map<String, dynamic>? bodyParams,
      List<File>? image}) async {
    http.Response? response = await MyHttp.multipart(
        bodyParams: bodyParams,
        url: 'https://dcmdmobilenotary.com/laravel/api/new_agent_quick_step_1',
        images: image,
        imageKey: 'attachment[]'
        //checkResponse: checkResponse,
        );
    print("image response:-" + response!.body.toString());
    return response;
  }
}
