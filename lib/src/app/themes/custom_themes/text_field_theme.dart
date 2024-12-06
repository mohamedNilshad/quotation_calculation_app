
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';

class CTextFieldTheme{
  CTextFieldTheme._();

  ///light theme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.grey,
    suffixIconColor: AppColors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14.0, color: AppColors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14.0, color: AppColors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: AppColors.black.withOpacity(0.8)),
    border: const UnderlineInputBorder(),
    enabledBorder: const UnderlineInputBorder(),
    focusedBorder: const UnderlineInputBorder(),
    errorBorder: const UnderlineInputBorder(),
    focusedErrorBorder: const UnderlineInputBorder(),
  );

  ///dark theme
  static InputDecorationTheme darkInputDecorationTheme =  InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.grey,
    suffixIconColor: AppColors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14.0, color: AppColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14.0, color: AppColors.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: AppColors.white.withOpacity(0.8)),
    border: const UnderlineInputBorder(),
    enabledBorder: const UnderlineInputBorder(),
    focusedBorder: const UnderlineInputBorder(),
    errorBorder: const UnderlineInputBorder(),
    focusedErrorBorder: const UnderlineInputBorder(),
  );
}