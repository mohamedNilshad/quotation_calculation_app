import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';

class HelperFunctions {

  static ScaffoldFeatureController customSnackBar(
      {required BuildContext context,
      required String message,
      Color bgColor = AppColors.error,
      double height = 30,
      Duration duration = const Duration(microseconds: 4000),
      SnackBarAction? actionButton}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      backgroundColor: bgColor,
      content: Text(
        message,
        style: const TextStyle(color: AppColors.white),
      ),
      duration: (actionButton != null) ? const Duration(minutes: 1) : duration,
      action: actionButton,
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double screenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static bool isIOS(){
    return Platform.isIOS;
  }

  static bool isAndroid(){
    return Platform.isAndroid;
  }
}
