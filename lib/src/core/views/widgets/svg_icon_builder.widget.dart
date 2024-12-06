import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/sizes.dart';

class CSvgIconBuilder extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final Color? color;
  final double width;
  final double height;

  const CSvgIconBuilder({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.width = Sizes.iconMd,
    this.height = Sizes.iconMd,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    if(color == null) {
      iconColor = isSelected ? AppColors.selectedIcon : AppColors.lightUnSelectedIcon;
    } else{
      iconColor = color!;
    }
    return SvgPicture.asset(
      icon,
      width: width,
      height: height,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}
