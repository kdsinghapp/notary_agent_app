// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
//
// class TrackingPage extends StatefulWidget {
//   const TrackingPage({Key? key}) : super(key: key);
//
//   @override
//   State<TrackingPage> createState() => _TrackingPageState();
// }
//
// class _TrackingPageState extends State<TrackingPage> {
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
//   static const LatLng destination = LatLng(37.33429383, -122.06600055);
//
//   LocationData? currentLocation;
//   void getCurrentLocation(){
//     Location location = Location();
//     location.getLocation().then((location) => currentLocation);
//
//   }
//   List<LatLng> polylineCoordinates = [];
//   void getPolyPoints() async{
//     PolylinePoints polylinePoints = PolylinePoints();
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyB90Ml5dpDCKI5-WuAGnkT-EHyCJrUR7ao", PointLatLng(sourceLocation.latitude, sourceLocation.longitude), PointLatLng(destination.latitude, destination.longitude));
//
//  if(result.points.isNotEmpty){
//    result.points.forEach((PointLatLng point) {
//      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//      setState(() {
//
//      });
//    });
//  }
//   }
//
//
//   @override
//   void initState() {
//     getPolyPoints();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Track order'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition:
//             CameraPosition(target: sourceLocation, zoom: 10.5),
//         polylines: {
//           Polyline(polylineId: PolylineId('route'),
//           points: polylineCoordinates,
//           color: Colors.blue,
//           width: 6)
//         },
//         markers: {
//           Marker(markerId: MarkerId("source"),
//           position: sourceLocation),
//           Marker(markerId: MarkerId("destination"),
//               position: destination)
//         },
//       ),
//     );
//   }
// }
