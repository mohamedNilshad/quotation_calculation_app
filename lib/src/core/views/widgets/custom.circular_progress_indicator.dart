import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/sizes.dart';

class CCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final Color color;
  const CCircularProgressIndicator({super.key, this.radius = Sizes.buttonHeight, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: radius,
        width: radius,
        alignment: Alignment.center,
        child: CircularProgressIndicator(color: color),
      ),
    );
  }
}
