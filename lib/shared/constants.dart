import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polywin/network/local/cache_helper.dart';

const Color kOrangeColor = Color(0xffF26F21);
const Color kBlueColor = Color(0xff19ABDF);
const Color kYellowColor = Color(0xffFFA41B);
const Color kDarkBlueColor = Color(0xff0D5670);
const Gradient kAppGradient =
    LinearGradient(colors: [Color(0xff19ABDF), Color(0xffF26F21)]);
BoxDecoration kCustomBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3)]);

const String kBaseURL = 'https://polywinegypt.com/';

String kToken = '';
int kUserType = CacheHelper.getData('userType');
