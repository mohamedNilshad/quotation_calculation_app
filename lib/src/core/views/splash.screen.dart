import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/route/route.constants.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/utils/helpers/helper_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context, RouteConstants.homeScreen, (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: HelperFunctions.screenWidth(context),
        height: HelperFunctions.screenHeight(context),
        alignment: Alignment.center,
        color: AppColors.primary,
        child: Text(
          AppStrings.brandLabel,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
