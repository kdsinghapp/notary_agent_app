import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notary_agent_app/apis/CustomSnackBar.dart';
import 'package:notary_agent_app/models/updateOnlineStatus.dart';
import 'package:notary_agent_app/screens/agent/dummy.dart';

import '../import.dart';
import '../models/bookingRequestModel.dart';
import '../utils/auth.dart';

class HomeController extends GetxController {
  bool _switchh = true;

  bool get switchh => _switchh;
  bool directionVisibility = false;
  var UserId;
    //Location location = new Location();
  BookingRequestResult? _bookingRequestResult;
  // var _serviceEnabled;
  //  late PermissionStatus _permissionGranted;

  Future<void> changeDirectionVisibility(BuildContext context) async{
    directionVisibility = false;
    refresh();
  }

  Future<void> changeSwitch(BuildContext context, val) async {
    _switchh = val;
    refresh();
    try {
      final res = await api().post('update_online_status',
          data: {"status": _switchh ? "ONLINE" : "OFFLINE", "id": UserId});
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from login data1 ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      final data = UpdateOnlineStatus.fromJson(res.data);
      if (data.status == "true") {
        showSnackbar(context, 'Succcess');
      } else {
        print("can't login");
        showError(context, "can't login");
      }
    } catch (e) {
      refresh();
      showError(context, e);
    }
  }

  late LatLng _gpsactual;
  LatLng _initialposition = LatLng(-12.122711, -77.027475);
  var activegps = true.obs;

  late GoogleMapController _mapController;

  LatLng get gpsPosition => _gpsactual;

  LatLng get initialPos => _initialposition;
  final Set<Marker> _markers = Set();

  Set<Marker> get markers => _markers;

  GoogleMapController get mapController => _mapController;

  @override
  void onInit() {
     getUserLocation();
   // locateMe();
    getUserId();
    getBookingRequest();
    // getCurrentLocation();
    // TODO: implement onInit
    super.onInit();
  }

  getUserId() async {
    UserId = await getCurrentUserId();
    print("uIS-------------$UserId");
  }


  // void locateMe() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   await location.getLocation().then((res) {
  //         _initialposition = LatLng(res.latitude as double, res.longitude as double);
  //         print(
  //             "the latitude is: ${res.latitude as double} and th longitude is: ${res.longitude as double} ");
  //         _addMarker(_initialposition);
  //         _mapController.moveCamera(CameraUpdate.newLatLng(_initialposition));
  //
  //   });
  // }

  void getUserLocation() async {
    print("location -------------1--------------");
    if (!(await Geolocator.isLocationServiceEnabled())) {
      print("location -------------2--------------");
      print("please enable the location servics");
      activegps.value = false;
    } else {
      activegps.value = true;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _initialposition = LatLng(position.latitude, position.longitude);
      print(
          "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
      _addMarker(_initialposition);
      _mapController.moveCamera(CameraUpdate.newLatLng(_initialposition));
    }
  }


  getBookingRequest() async {
    try {
      final res =
          await api().post('get_current_booking', data: {"user_id": await getCurrentUserId()});
      // final resdata = UpdateOnlineStatus.fromJson(res as Map<String, dynamic>);
      // print("resdata is....${resdata.data}");
      print("res from login data1 ------------------${res.data}");
      print("status ------------------${res.data['status']}");

      print("data is....${BookingRequestModel.fromJson(res.data)}");

      final data = BookingRequestModel.fromJson(res.data);
      print("data is....$data");
      if (data.status == "true") {
        directionVisibility = true;
        _bookingRequestResult = data.data;
        refresh();
      } else {
        print("can't login");
      }
    } catch (e) {
      print(e);
      print("error is coming");
    }
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarker(LatLng location) {
    _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
            title: _initialposition.toString(), snippet: "My current location"),
        icon: BitmapDescriptor.defaultMarker));
  }

  void onCameraMove(CameraPosition position) async {
    print("position.target...${position.target}");
    position = CameraPosition(target: initialPos, zoom: 30);
    _initialposition = position.target;
  }

  Future<void> direct(
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return HomeScreenPopup(
            bookingRequestResult: _bookingRequestResult,
          );
          // return TripPopup ();
          //return DoneDialog();
          //return CustomDialog();
        });
    ;
  }

  final Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(22.7177, 75.8545), // Set initial map coordinates
    zoom: 14.0, // Set initial zoom level
  ).obs;

  // final RxSet<Marker> markers = <Marker>{}.obs;

  // Implement methods for map interactions or data fetching
  // For example:
  Future<void> fetchMapData() async {
    // Fetch map data from an API
    // Update the model with the fetched data
    // Update the reactive properties (cameraPosition, markers) accordingly
  }

  Future<void> continueBtn(BuildContext context) async {
    refresh();
    // context.pop();
    displayDialog(
      context,
      "Signing started",
      "OK",
      "107, 1st Floor Sapphire House, Sapna Sangeeta Main Road, Snehagat Agrasen Square, Snehnagar, Indore, Madhya Pradesh 452001, India Date 2021-02-04 1905",
      true,
      () {
        context.pop();
        context.navigate(() => AddRate());
      },
    );
    // displayDialog(
    //     context, "NotaryClient", "OK", "Thanks for your Business", false);
    // context.navigate(() => AddRate());
  }

// Future<void> changeDirectionVisibility(BuildContext context) async {
//   directionVisibility = !directionVisibility;
//   refresh();
//   // context.pop();
//
//   // displayDialog(
//   //     context, "NotaryClient", "OK", "Thanks for your Business", false);
//   // context.navigate(() => AddRate());
// }
}
