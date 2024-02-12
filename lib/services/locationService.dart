import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:geocoding/geocoding.dart' as geoCode;
import 'package:geolocator/geolocator.dart' as geoCode;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
GoogleMapController? controller;
Completer<GoogleMapController> controllerCompleter = Completer();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
bool loading=false;
LatLng initialposition = LatLng(-12.122711, -77.027475);
Set<Marker> markers={};
String butText="Request Now";
// String address='fetching address ...';
LocationData? currentLocation;
LatLng _markerLocation = LatLng(0.0, 0.0);
String location = "Search";
String googleApikey = "AIzaSyB90Ml5dpDCKI5-WuAGnkT-EHyCJrUR7ao";
// LatLng startLocation =  LatLng(22.234,75.24546);
LatLng? endLocation;// Initial marker location
final ValueNotifier<String> address = ValueNotifier<String>('');
final ValueNotifier<LatLng> startLocation = ValueNotifier<LatLng>(LatLng(22.234,75.24546));

void onMapCreated(GoogleMapController controller) {
  controller = controller;
}

void _onMarkerDragEnd(LatLng position) {
  // setState(() {
    _markerLocation = position;
  // });
  print('New Marker Position: $position');
}
getCurrentLocation()async{
  // setState(() {
    loading=true;
  // });
  var location = Location();
  try {
    currentLocation = await location.getLocation();
    print("current location -----------${currentLocation!.latitude}"
        "\n${currentLocation!.longitude}");
    startLocation.value=LatLng(currentLocation!.latitude!,currentLocation!
        .longitude!);
    //getAddressFromCoordinates(currentLocation!.latitude!,currentLocation!.longitude!);
    // setState(() {
      _markerLocation=   LatLng(currentLocation!.latitude!,currentLocation!.longitude!);
      markers.add(
        Marker(
          markerId: MarkerId('tapped_location'),
          position: _markerLocation,
          infoWindow: InfoWindow(title: 'Tapped Location'),
        ),
      );
    // });
    // setState(() {
      initialposition = LatLng(currentLocation!.latitude!,currentLocation!.longitude!);

    // });


  } catch (e) {
    // setState(() {
      loading=false;
    // });
    print('Error: $e');
  }
}
/*
Future<void> getAddressFromCoordinates(double latitude, double longitude) async {
  // address='fetching address ...';
  try {
    List<geoCode.Placemark> placemarks = await geoCode
        .placemarkFromCoordinates
      (latitude, longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      geoCode.Placemark place = placemarks[0];
      // setState(() {
        address.value = "${place.street}, ${place.locality}, ${place
            .postalCode}, ${place.country}";
        loading=false;

      // });
    } else {
      // setState(() {
        address.value = 'No address found';
        loading=false;
      // });
    }
  } catch (e) {
    print('Error: $e');
    // setState(() {
      address.value = 'Failed to get address';
      loading=false;
    // });
  }
}   */

Future<void> onMapTapped(LatLng location) async {
 // await getAddressFromCoordinates(location.latitude, location.longitude) ;

  // setState(()  {

    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId('tapped_location'),
        position: location,
        infoWindow: InfoWindow(title: 'Tapped Location'),
      ),
    );
  // });
  print('Tapped Location: $location');
}
void addCustomMarker() {
  print("addCustomMarker");
  // Creating a custom marker icon
  BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio: 2.5),
    'assets/icons/quic_car_.png', // Replace with your custom marker image path
  ).then((BitmapDescriptor customIcon) {
    // setState(() {
    markers.add(
      Marker(
        markerId: MarkerId('custom_marker'),
        position: LatLng(22.7196, 75.8577), // Custom marker position
        icon: customIcon,
        infoWindow: InfoWindow(title: 'Custom Marker'),
      ),
    );
    // });
  });
}



/*
Future<Uint8List> getBytesFromAsset(String path, int width) async {

  ByteData data = await rootBundle.load(path);

  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);

  ui.FrameInfo fi = await codec.getNextFrame();

  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

}
setUpMarker() async {

  const currentLocationCamera = LatLng(37.42796133580664, -122.085749655962);



  markers .add(Marker(

    markerId: MarkerId("${currentLocationCamera.latitude}"),

    position: LatLng(

        currentLocationCamera.latitude, currentLocationCamera.longitude),

    icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(

        'assets/icons/quic_car_.png', 70)),

  ));

}*/
