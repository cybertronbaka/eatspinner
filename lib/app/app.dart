import 'package:eatspinner/app/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EatSpinnerApp extends StatelessWidget {
  const EatSpinnerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Eat Spinner',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          foregroundColor: Color(0xFF3D3D3C),
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500
          )
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFFCACACA),
          thickness: 1
        )
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Colors.black,
        //   onPrimary: Colors.white,
        //   secondary: Colors.white,
        //   onSecondary: Colors.black,
        //   error: Colors.red,
        //   onError: Colors.white,
        //   background: Colors.white,
        //   onBackground: Colors.black,
        //   surface: Colors.white,
        //   onSurface: Colors.black,
        // ),
        // useMaterial3: true
      ),
      routerConfig: router,
    );
  }
}