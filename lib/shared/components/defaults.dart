import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polywin/network/local/cache_helper.dart';
import 'package:polywin/screens/login_screen.dart';
import 'package:polywin/shared/cubit/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'custom_button_2.dart';

Future navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

void showLoadingDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(20),
        child: SpinKitFadingCircle(
          color: kOrangeColor,
        ),
      ),
    ),
  );
}

void showAlertDialog(
    {BuildContext context,
    Color messageColor = kBlueColor,
    String message,
    String imagePath,
    String buttonText}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xffF8F8F8),
      contentPadding: EdgeInsets.all(40),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          children: [
            Image(image: AssetImage(imagePath)),
            SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: messageColor),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton2(
              label: buttonText,
              onTab: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  );
}

void showAlertDialogWithAction(
    {BuildContext context,
    String message,
    Color messageColor = kBlueColor,
    String imagePath,
    String buttonText,
    Function action}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Color(0xffF8F8F8),
      contentPadding: EdgeInsets.all(40),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: AssetImage(imagePath)),
            SizedBox(
              height: 20,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18, color: messageColor),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton2(label: buttonText, onTab: action)
          ],
        ),
      ),
    ),
  );
}

void logOut(context) {
  CacheHelper.removeData('token');
  CacheHelper.removeData('userType')
      .then((value) => navigateAndFinish(context, LoginScreen()));
  CacheHelper.clearCache();
  // AppCubit.get(context).getParentCategory = null;
  // AppCubit.get(context).getPolywinInvoicesModel = null;
  // AppCubit.get(context).getUserInfoModel = null;
  // AppCubit.get(context).getAllInvoicesModel = null;
}

void launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

Future<bool> showToast({
  @required String text,
  @required Color color,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<void> openGallary(BuildContext context, File file) async {
  var picture =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //emit(PickImageSuccessState());
  file = File(picture.path);
  Navigator.of(context).pop();
}

Future<void> openCamera(BuildContext context, File file) async {
  var picture =
      await ImagePicker.platform.pickImage(source: ImageSource.camera);
  //emit(PickImageSuccessState());
  file = File(picture.path);
  Navigator.of(context).pop();
}

Future<void> showPhotoDialog(BuildContext context, File file) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "هل تريد التقاط الصورة من..؟",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  child: Text(
                    "الأستوديو",
                    style: TextStyle(fontSize: 20),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    openGallary(context, file);
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                InkWell(
                  child: Text(
                    "الكاميرا",
                    style: TextStyle(fontSize: 20),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    openCamera(context, file);
                  },
                ),
              ],
            ),
          ),
        );
      });
}

Future<dynamic> showCustomBottomSheet({BuildContext context, Widget content}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: Container(
                padding: EdgeInsets.all(20),

                //height: MediaQuery.of(context).size.height*0.5,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                //height: 350,
                child: content,
              ),
            ),
          ));
}

// void showPlacePicker(BuildContext context) async {
//   LocationResult result = await Navigator.of(context).push(
//       MaterialPageRoute(builder: (context)  => PlacePicker("AIzaSyCrsTVja4leOLfOxV6EfP1oSyQv_bpj7yg",)));
//   // Handle the result in your way
//   print(result.latLng);
// }
