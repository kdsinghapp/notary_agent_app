
import '../../import.dart';
import '../../widgets/dotted_border.dart';
class UploadSignUpProfile extends StatefulWidget{
  const UploadSignUpProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
      return _UploadSignUpProfileState();
  }
}

class _UploadSignUpProfileState extends State<UploadSignUpProfile> {
  int tabIndex=0;
   bool btnLoading=false;
   bool checkBox=false;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: CC.primary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CC.primary,
        leading:InkWell(
          onTap: (){
            if(tabIndex==1){
              setState(() {
                tabIndex=0;
              });
            }else{
              context.pop(context);
            }

          },
          child: const Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),
        ),
        title: const Text("Registration"),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: tabIndex==0?uploadProfileImage():uploadDriverImage())

    );
  }

  Widget uploadProfileImage(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png', height: context.width / 4, fit: BoxFit.contain),
          sbh(20),
          DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            dashPattern: const [8, 4],
            strokeWidth: 2,
            radius:const Radius.circular(12),
            //padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 200,
                width: 300,
                color: Colors.grey.withOpacity(0.8),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo_camera,color: Colors.black87,size: 40,),
                    sbh(5),
                    const Text('Click here to upload a \n photo.',style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,),
                    sbh(5),
                    Container(
                      height: 30,
                      width: 150,
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black87,width: 1),
                        color: Colors.white,
                      ),
                      child: const Text('Upload Photo',style: TextStyle(color: Colors.black87,fontSize: 16), textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh(20),
                const Text('To prevent delays, make sure your vehicle \n registration',style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.start,),
                sbh(20),
                const Text('* Is current (not expired)',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Matches the vehicle on file with Lyft',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Is not blurry',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Includes all four corners in the photo',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),

              ],
            ),
          ),
          sbh(60),
          AppButton(
            onTap: () {
              //controller.signup(context);
              //signUpLaunchUrl();
              setState(() {
                tabIndex=1;
              });
            },
            text: "SAVE",
            color:Colors.indigoAccent,
            loading: btnLoading,
            borderRadius: BorderRadius.circular(25),
          ),
          sbh(20),
        ],
      ),
    );
  }
  Widget uploadDriverImage(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/logo.png', height: context.width / 4, fit: BoxFit.contain),
          sbh(20),
          DottedBorder(
            borderType: BorderType.RRect,
            color: Colors.white,
            dashPattern: const [8, 4],
            strokeWidth: 2,
            radius:const Radius.circular(12),
            //padding: EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                height: 200,
                width: 300,
                color: Colors.grey.withOpacity(0.8),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.photo_camera,color: Colors.black87,size: 40,),
                    sbh(5),
                    const Text('Click here to upload a \n photo.',style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,),
                    sbh(5),
                    Container(
                      height: 30,
                      width: 150,
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black87,width: 1),
                        color: Colors.white,
                      ),
                      child: const Text('Add driver photo',style: TextStyle(color: Colors.black87,fontSize: 16), textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sbh(20),
            const Text('Example Driver Photo',style: TextStyle(color: Colors.white,fontSize: 20,
              fontWeight: FontWeight.bold,),),
                sbh(20),
              Image.asset('assets/images/img_girl.jpg',height: context.width / 2, fit: BoxFit.contain),

              sbh(30),
                const Text('Driver photo \n requirements',style: TextStyle(color: Colors.white,fontSize: 20,
                    fontWeight: FontWeight.bold,), textAlign: TextAlign.start,),
                sbh(20),
                const Text('* Put on big smile',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* No hats,sunglasses, or Bluetooth  headsets',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Keep entire head and both shoulders in \n the frame',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* No blurriness',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Good lighting and a solid background',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(5),
                const Text('* Photo should be oriented horizontally like \n in the example',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),
                sbh(20),
                Row(
                  children: [
                    Checkbox(
                        value: checkBox,
                        onChanged: (v) {
                          setState(() {
                            checkBox=v!;
                          });},
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                        ),
                    const Text('I have read the requirements',style: TextStyle(color: Colors.white), textAlign: TextAlign.start,),

                  ],
                ),
              ],
            ),
          ),
          sbh(60),
          AppButton(
            onTap: () {
              //controller.signup(context);
              //signUpLaunchUrl();
            },
            text: "SAVE",
            color:Colors.indigoAccent,
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
}