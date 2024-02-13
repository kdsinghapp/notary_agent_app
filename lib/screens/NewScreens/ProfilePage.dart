import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:notary_agent_app/import.dart';
import 'package:notary_agent_app/models/LoginModel.dart';
import '../../apis/CustomSnackBar.dart';
import '../../models/UserProfileModel.dart';
import '../../services/apiServices.dart';
import '../../utils/auth.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../../utils/http_methods.dart';
import '../../widgets/ShowToast.dart';
import '../../widgets/checkoutUI.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() =>_ProfileState();

}
class _ProfileState extends State<ProfilePage>{
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  bool showProgressbar=false;
  bool isSelectedFile=false;
  bool btnLoading=false;
  bool pageLoading=true;
  File? selectedFile;
  UserProfileModel? userProfileModel;
  LoginModel? editProfileModel;
  Map<String, dynamic> bodyParamsForSubmitChangeProfileForm = {};

  @override
  initState(){
    super.initState();
    getUserProfile();

  }
  Future<void> getUserProfile() async {
    String agent_id=await getCurrentUserId();
    String url = '${ApiUrls.getProfile}?user_id=$agent_id';
    var res = await Webservices.getData(url);
    var jsonResponse = convert.jsonDecode(res.body);
    print("change status url ------------------${url}");
    print("res from login data2 ------------------${jsonResponse}");
    userProfileModel= UserProfileModel.fromJson(jsonResponse);
    if (userProfileModel!.status == "true") {
      print('Successfully get driver profile...');
      firstNameController.value=TextEditingValue(text: userProfileModel!.data![0].firstName??'');
      lastNameController.value=TextEditingValue(text: userProfileModel!.data![0].lastName??'');
      emailController.value=TextEditingValue(text: userProfileModel!.data![0].email??'');
      phoneController.value=TextEditingValue(text: userProfileModel!.data![0].mobile??'');
      addressController.value=TextEditingValue(text: userProfileModel!.data![0].address??'');
      setState(() {
        pageLoading=false;
      });

    } else {
      print('Failed get driver profile...');
      showSnackbar(context,"${userProfileModel!.message}");
    }

  }
  @override
  Widget build(BuildContext context) {
    return pageLoading?
       const Center(child: CircularProgressIndicator(),):
    Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height:80,width: 80,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(40.0),
                      child:isSelectedFile?
                      Image.file(selectedFile!, fit:BoxFit.cover,width:80,height: 80,):
                      CachedNetworkImage(
                        imageUrl:'${userProfileModel!.data![0].image}',height: 80, width: 80, fit: BoxFit.cover,
                        placeholder: (BuildContext context, String url) =>Image.asset('assets/images/profile.png',height: 80, width: 80, fit: BoxFit.contain,),
                        errorWidget: (BuildContext context, String url, dynamic error) => Image.asset('assets/images/profile.png',height: 80, width: 80, fit: BoxFit.contain,),
                      ),
                    ),),
                  Positioned(
                      top: 0,right: 0,
                      child: GestureDetector(
                          onTap: (){
                            getImage();
                          },
                          child: Container(
                              height: 24,width: 24,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: const Icon(Icons.edit_outlined,size: 25,color: Colors.black54,))
                      )
                  )
                ],
              ),
              sbh(5),
              RatingBar.builder(
                initialRating:userProfileModel!.data![0].review??3.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 10,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              sbh(5),
              CustomText(
                text: "\$ ${userProfileModel!.data![0].wallet??'0'}",
                textColor: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold,textAlign: TextAlign.center,),

              sbh(20),
              AppTextFormField(
                placeholder: "First Name",
                validator: Validators.required,
                controller: firstNameController,

              ),
              sbh(20),
              AppTextFormField(
                placeholder: "Last Name",
                validator: Validators.required,
                controller: lastNameController,
              ),
              sbh(20),
              AppTextFormField(
                placeholder: "Email",
                validator: Validators.required,
                controller: emailController,
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
              ),
              sbh(20),
              AppTextFormField(
                placeholder: "Phone Nu.",
                validator: Validators.required,
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,right: 0,left: 0,
          child:  Container(
              height: 50,
              padding: const EdgeInsets.only(left: 10,right: 10),
              decoration: const BoxDecoration(
                  color: Colors.white
              ),
              child:AppButton(
                onTap: (){
                 setState(() {
                   btnLoading=true;
                   callingSubmitChangeProfileForm();
                 });
                },
                text:'UPDATE',
                loading:btnLoading ,
              )),)

      ],
    );
  }



  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      isSelectedFile=true;
    } else {
      selectedFile=null;
      isSelectedFile=false;
      print('No image selected.');
    }
    setState(() {

    });
  }

  Future<void> callingSubmitChangeProfileForm() async {
    bodyParamsForSubmitChangeProfileForm = {
      'id':userProfileModel!.data![0].id.toString(),
      'first_name':firstNameController.text.toString(),
      'last_name':lastNameController.text.toString(),
      'mobile':phoneController.text.toString(),
      'address':addressController.text.toString()
    };
    print("bodyParamsForSubmitChangeProfileForm:::::$bodyParamsForSubmitChangeProfileForm");
    editProfileModel = await editProfileApi(
        bodyParams: bodyParamsForSubmitChangeProfileForm,image:selectedFile );
    if (editProfileModel!.status=="true") {
      print("Edit Profile  Successfully Complete....");
      updateUserDetails(editProfileModel!.toJson());
      showToastMessage(editProfileModel!.message!);
    }else{
      print("Edit Profile Failed....");
      showToastMessage(editProfileModel!.message!);
    }
    setState(() {
      btnLoading=false;
    });
  }

  /// Edit Profile  Api Calling .....
  static Future<LoginModel?> editProfileApi({
    void Function(int)? checkResponse,
    Map<String, dynamic>? bodyParams,
    File? image
  }) async {
    LoginModel? editProfileModel;
    http.Response? response = await MyHttp.multipart(
        bodyParams: bodyParams,
        url: 'https://dcmdmobilenotary.com/laravel/api/update_profile',
        image: image,
        imageKey: 'image'
      //checkResponse: checkResponse,
    );
    if (response != null) {
      editProfileModel = LoginModel.fromJson(jsonDecode(response.body));
      return editProfileModel;
    }
    return null;
  }


}