// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as location;
//
//
// class LocationScreen extends StatefulWidget {
//   static const String id = "LocationScreen";
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   double longitude;
//   double latitude;
//   String address;
//   final Completer<GoogleMapController> _controller = Completer();
//
//   @override
//   void initState() {
//     getLocation();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: (longitude != null && latitude != null)
//           ? Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   myLocationEnabled: true,
//                   onTap: (location) async {
//                     await translateCoordinatesIntoAddress(
//                         lat: location.latitude, long: location.longitude);
//                   },
//                   initialCameraPosition: CameraPosition(
//                       target: LatLng(latitude, longitude), zoom: 14.4746),
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                   color: Colors.blue,
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           address ?? "",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15)),
//                         child: IconButton(
//                             onPressed: () {
//                               Navigator.pop(context, {
//                                 "address": address,
//                                 "lat": latitude,
//                                 "long": longitude,
//                               });
//                             },
//                             icon: Icon(
//                               Icons.arrow_forward,
//                             )),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
//
//   Future getLocation() async {
//     try {
//       var userLocation = await location.Location().getLocation();
//       longitude = userLocation.longitude;
//       latitude = userLocation.latitude;
//       translateCoordinatesIntoAddress(lat: latitude, long: longitude);
//       setState(() {});
//     } on Exception catch (e) {
//       print('Could not get location: ${e.toString()}');
//     }
//   }
//
//   Future translateCoordinatesIntoAddress({double lat, double long}) async {
//     List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
//     print(
//         "${placeMarks.first.thoroughfare},${placeMarks.first.name},${placeMarks.first.street},${placeMarks.first.administrativeArea},${placeMarks.first.country}");
//     address =
//         "${placeMarks.first.thoroughfare},${placeMarks.first.name},${placeMarks.first.street},${placeMarks.first.administrativeArea},${placeMarks.first.country}";
//     setState(() {});
//   }
// }
