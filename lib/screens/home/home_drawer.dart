import 'package:notary_agent_app/screens/home/home/HelpScreen.dart';

import '../../import.dart';

class HomeDrawer extends StatefulWidget {
  final bool? isPopup;
  const HomeDrawer({super.key,  this.isPopup});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    if(widget.isPopup!=null){
      if(widget.isPopup!)
               print("0");
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return GetBuilder(
      init: HomeDrawerController(),
      builder: (HomeDrawerController controller) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 15),
                child: Image.asset('assets/images/h1.png', height: 56)),
            centerTitle: true,
            toolbarHeight: 70,
            leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: CC.primary,
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                }),
            actions: [
              TextButton(onPressed: () {
                context.navigate(() => HelpScreen());
              },
              child: Text('HELP',style: TextStyle(color: CC.primary),))
            ],
          ),
          body: controller.body,
          drawer: Drawer(
            backgroundColor: Colors.black,
            child: Container(
              child: Column(
                children: [
                  sbh(50),
                  ListTile(
                    onTap: () {},
                    leading: SizedBox(
                        height: 64.0,
                        width: 64.0, // fixed width and height
                        child: Image.asset('assets/images/pro.png')),
                    title: CustomText(text: 'Johan', textColor: Colors.white),
                    subtitle: CustomText(
                        text: 'johan@gmail.com', textColor: Colors.white),
                  ),
                  sbh(5),
                  Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  sbh(5),
                  ListTile(
                    onTap: () {
                      controller.HomeScreen(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/1.png')),
                    title: CustomText(text: 'Home', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.Booking(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/2.png')),
                    title: CustomText(text: 'Booking', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.ChangePasswordScreen(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/2.png')),
                    title: CustomText(
                        text: 'Change Password', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.MyWallet(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/3.png')),
                    title:
                        CustomText(text: 'My wallet', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.Signing(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/3.png')),
                    title: CustomText(
                        text: 'My Signings', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.Shipping(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/4.png')),
                    title: CustomText(
                        text: 'Current Shipping', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.Emergency(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/5.png')),
                    title: CustomText(
                        text: 'Emergency Contact', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.AboutUs(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/6.png')),
                    title:
                        CustomText(text: 'About Us', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.Setting(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/7.png')),
                    title: CustomText(text: 'Setting', textColor: Colors.white),
                  ),
                  ListTile(
                    onTap: () {
                      controller.LogOut(context);
                    },
                    leading: SizedBox(
                        height: 20.0,
                        width: 20.0, // fixed width and height
                        child: Image.asset('assets/images/8.png')),
                    title: CustomText(text: 'Log Out', textColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
