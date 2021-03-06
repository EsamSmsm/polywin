import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:map_picker/map_picker.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import '../constants.dart';
import 'location_helper.dart';

class LocationPickerScreen extends StatefulWidget {
  LocationPickerScreen({
    Key key,
  }) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  @override
  void initState() {
    getMyCurrentLocation();
    super.initState();
  }

  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  // static Position position;
  //
  double longitude, latitude;
  CameraPosition cameraPosition;
  Future<void> getMyCurrentLocation() async {
    var userLocation = await location.Location().getLocation();
    longitude = userLocation.longitude;
    latitude = userLocation.latitude;
    setState(() {});
  }

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textController.text),
      ),
      body: latitude == null || longitude == null
          ? SizedBox()
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                MapPicker(
                  // pass icon widget
                  iconWidget: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50,
                  ),

                  //add map picker controller
                  mapPickerController: mapPickerController,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    // hide location button
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: true,
                    mapType: MapType.normal,
                    //  camera position
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMoveStarted: () {
                      // notify map is moving
                      mapPickerController.mapMoving();
                      textController.text = "checking ...";
                    },
                    onCameraMove: (cameraPosition) {
                      this.cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () async {
                      // notify map stopped moving
                      mapPickerController.mapFinishedMoving();
                      //get address name from camera position
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        cameraPosition.target.latitude,
                        cameraPosition.target.longitude,
                      );

                      // update the ui with the address
                      textController.text =
                          '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                      setState(() {});
                    },
                  ),
                ),
                // Positioned(
                //   top: MediaQuery.of(context).viewPadding.top + 20,
                //   width: MediaQuery.of(context).size.width - 50,
                //   height: 50,
                //   child: TextFormField(
                //     maxLines: 3,
                //     textAlign: TextAlign.center,
                //     readOnly: true,
                //     decoration: const InputDecoration(
                //         contentPadding: EdgeInsets.zero,
                //         border: InputBorder.none),
                //     controller: textController,
                //   ),
                // ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      child: const Text(
                        "??????????",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFFFFFFFF),
                          fontSize: 19,
                          // height: 19/19,
                        ),
                      ),
                      onPressed: () {
                        print(
                            "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                        print("Address: ${textController.text}");
                        AppCubit.get(context).lat =
                            cameraPosition.target.latitude;
                        AppCubit.get(context).lang =
                            cameraPosition.target.longitude;
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(kBlueColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
