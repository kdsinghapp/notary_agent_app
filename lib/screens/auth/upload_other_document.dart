import 'package:http/http.dart' as http;
import 'package:notary_agent_app/screens/auth/signup_step3.dart';
import 'package:notary_agent_app/widgets/ShowToast.dart';

import '../../import.dart';
import '../../utils/auth.dart';
import '../../utils/http_methods.dart';
import '../../widgets/dotted_border.dart';

class UploadOtherDocument extends StatefulWidget {
  const UploadOtherDocument({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UploadOtherDocumentState();
  }
}

class _UploadOtherDocumentState extends State<UploadOtherDocument> {
  bool btnLoading = false;
  File? bondFile;
  File? licenseFile;
  File? checkFile;
  Map<String, dynamic> bodyParamsForOtherDocumentationForm = {};
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
            "Upload Other Documents",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: uploadDrivingLicenceImage()));
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
                  if (bondFile != null)
                    Image.file(
                      bondFile!,
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
                          'Click here to upload a \n copy of bond',
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
                              'Upload bond',
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
                  'Copy of Bond (If not required in your state, attach a note in its place.)',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
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
                  if (licenseFile != null)
                    Image.file(
                      licenseFile!,
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
                          'Click here to upload a \n copy of notary license',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        sbh(5),
                        GestureDetector(
                          onTap: () async {
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
                              'Upload license',
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
                  'Copy of notary license is required for agent register.',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
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
                  if (checkFile != null)
                    Image.file(
                      checkFile!,
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
                          'Click here to upload a \n copy of background check',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        sbh(5),
                        GestureDetector(
                          onTap: () async {
                            getImage(2);
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
                              'Upload check',
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
                  'Copy of Background Check required,\n E&0 (If not required in your state, attach a image note in its place.)',
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
              if (bondFile != null &&
                  licenseFile != null &&
                  checkFile != null) {
                List<File> files = [bondFile!, licenseFile!, checkFile!];
                setState(() {
                  btnLoading = true;
                  uploadOtherDocumentsApi(files);
                });
              } else {
                showError(context, 'Select all files...');
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SignUpStep3Page()));
            },
            text: "SAVE",
            color: Colors.indigoAccent,
            loading: btnLoading,
            borderRadius: BorderRadius.circular(25),
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
      print("Image :-${pickedFile.path}");
      switch (i) {
        case 0:
          {
            bondFile = File(pickedFile.path);
          }
          break;
        case 1:
          {
            licenseFile = File(pickedFile.path);
          }
          break;
        case 2:
          {
            checkFile = File(pickedFile.path);
          }
          break;
      }
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Future<void> uploadOtherDocumentsApi(List<File>? selectedFile) async {
    try {
      bodyParamsForOtherDocumentationForm = {
        'agent_id': await getCurrentUserId(),
      };
      print(
          "bodyParamsForOtherDocumentationForm:::::$bodyParamsForOtherDocumentationForm");
      http.Response? response = await editProfileApi(
          bodyParams: bodyParamsForOtherDocumentationForm, image: selectedFile);
      print(
          "upload signup profile images ------------------${response!.statusCode}");
      print("upload signup profile images ------------------${response!.body}");
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      if (jsonData['status'] == '1') {
        showToastMessage(
            'Successfully completed your upload documentation step.');
        context.replace(() => SignUpStep3Page());
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
        url: 'https://dcmdmobilenotary.com/laravel/api/new_agent_quick_step_2',
        images: image,
        imageKey: 'attachment[]'
        //checkResponse: checkResponse,
        );
    print("image response:-" + response!.body.toString());
    return response;
  }
}
