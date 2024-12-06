
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotation_calculation/src/app/route/route.constants.dart';
import 'package:quotation_calculation/src/app/route/route.dart';
import 'package:quotation_calculation/src/app/themes/theme.dart';
import 'package:quotation_calculation/src/core/constants/app_strings.dart';
import 'package:quotation_calculation/src/core/utils/helpers/helper_functions.dart';
import 'package:quotation_calculation/src/features/home/view_models/Items.view_model.dart';

class App extends StatefulWidget {
  const App({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (HelperFunctions.isDarkMode(context) && HelperFunctions.isAndroid()) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemViewModel>(create: (_) => ItemViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: App.navigatorKey,
        title: AppStrings.brandLabel,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: RouteConstants.splashScreen,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
