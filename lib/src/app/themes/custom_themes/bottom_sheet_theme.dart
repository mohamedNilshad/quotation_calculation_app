
import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';

class CBottomSheetTheme{
  CBottomSheetTheme._();

  ///light theme
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AppColors.white,
    modalBackgroundColor: AppColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
  );

  ///dark theme
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: AppColors.black,
      modalBackgroundColor: AppColors.black,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))
  );
}