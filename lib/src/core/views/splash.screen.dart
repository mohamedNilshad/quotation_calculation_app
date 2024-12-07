import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotation_calculation/src/app/route/route.constants.dart';
import 'package:quotation_calculation/src/core/constants/app_colors.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/utils/helpers/helper_functions.dart';
import 'package:quotation_calculation/src/features/home/view_models/quotations.view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _setData() async {
    await context.read<QuotationViewModel>().fetchQuotationNo(context);
    Navigator.pushNamedAndRemoveUntil(
      context, RouteConstants.homeScreen, (route) => false,
    );
  }

  @override
  void initState() {
    Future.microtask(()=>_setData());
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.brandLabel,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.white,
              ),
            ),
            Text(
              'App',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
