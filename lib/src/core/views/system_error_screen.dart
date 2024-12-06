import 'package:flutter/material.dart';
import 'package:quotation_calculation/src/app/route/route.constants.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';

class CustomSystemErrorScreen extends StatelessWidget {
  const CustomSystemErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.appUnrecognisedError,
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstants.splashScreen,
                  ModalRoute.withName('/'),
                );
              },
              child: const Text("Go back"),
            ),
          ],
        ),
      ),
    ));
  }
}
