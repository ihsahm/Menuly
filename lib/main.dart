import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Provider/themeProvider.dart';
import 'package:e_commerce/Screen/Settings/Contents/RegisterBusiness/licenseImage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Shared/Navigation/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  runApp(Main());
  // var connection = await Connectivity().checkConnectivity();

  // if (connection == ConnectivityResult.none) {
  //   Fluttertoast.showToast(
  //       msg: 'Please check your internet connection and open again',
  //       textColor: ColorsConst.white,
  //       backgroundColor: Colors.grey);
  // } else if (connection == ConnectivityResult.mobile) {
  //   return runApp(MaterialApp(
  //     home: Navigation(),
  //     theme: ThemeData.dark(),
  //     debugShowCheckedModeBanner: false,
  //   ));
  // } else if (connection == ConnectivityResult.wifi) {
  //   return runApp(MaterialApp(
  //     home: Navigation(),
  //     debugShowCheckedModeBanner: false,
  //   ));
  // }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) {
          return LicenseImage();
        }),
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                themeMode: themeProvider.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                // themeMode: ThemeMode.system,
                // theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: Navigation(),
              );
            })
      ],
      //  child:
      //     Consumer<DarkThemeProvider>(builder: (context, themeData, child) {

      //})
    );
  }
}

/*
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';*/