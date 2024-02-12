import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../import.dart';

class Home extends StatefulWidget {
  final bool isPopup;
  const Home({super.key, required this.isPopup});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: CC.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomText(
                              text: "GOOffline",
                              textColor: Colors.white,
                            ),
                            Switch(
                                // This bool value toggles the switch.
                              inactiveTrackColor: Colors.white.withOpacity(0.5),
                              activeTrackColor: Colors.white,
                                activeColor: Colors.white,
                                value: controller.switchh,
                                onChanged: (cc) {
                                  controller.changeSwitch(context, cc);
                                }),
                            CustomText(
                              text: "GoOnline",
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          child:
                          controller.activegps.value == false?
                          InkWell(
                              onTap: (){
                                controller.getUserLocation();
                              },
                              child: Container(
                              )):
                          GoogleMap(
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            markers: controller.markers,
                            // onCameraMove: controller.onCameraMove,
                            initialCameraPosition: CameraPosition(
                                target: controller.initialPos, zoom: 18.0),
                            onMapCreated: controller.onCreated,
                            myLocationEnabled: true,
                            // onCameraIdle: () async {
                            //   controller.getMoveCamera();
                            // },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Visibility(
                            visible: controller.directionVisibility,
                            child: AppButton(
                              onTap: () async{
                               // await controller.getBookingRequest(context);
                                controller.direct(context);
                                controller.changeDirectionVisibility(context);
                              },
                              text: "Direction",
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      // onTap: () => context.navigate(() => AddRequestForm()),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        color: Colors.white,
                        child: CustomText(
                          text:
                              "Signing Request 20 January 2001 1414520 \nTedays Earning \$ 127.00",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                bottom: 0,
                width: context.width,
              ),
            ],
          );
        });
  }
}
