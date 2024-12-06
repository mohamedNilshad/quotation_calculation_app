import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';

class CCheckboxTheme{
  CCheckboxTheme._();

  ///light theme
  static CheckboxThemeData lightCheckboxThemeTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return AppColors.white;
      }else{
        return AppColors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return AppColors.primary;
      }else{
        return Colors.transparent;
      }
    }),
  );

  ///dark theme
  static CheckboxThemeData darkCheckboxThemeTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    checkColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return AppColors.black;
      }else{
        return AppColors.white;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states){
      if(states.contains(WidgetState.selected)){
        return AppColors.primary;
      }else{
        return Colors.transparent;
      }
    }),
  );
}