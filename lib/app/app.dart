import 'package:eatspinner/app/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class EatSpinnerApp extends StatefulWidget {
  const EatSpinnerApp({super.key});

  @override
  State<StatefulWidget> createState() => _EatSpinnerAppState();
}


class _EatSpinnerAppState extends State<EatSpinnerApp>{

  @override
  void initState() {
    addNotificationHandlers();
    super.initState();
  }

  void addNotificationHandlers(){
    OneSignal.User.pushSubscription.addObserver((state) {
      print(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      // final data = event.notification.additionalData;
      // print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $data');
      // if(data == null) return;
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work

      // / notification.display() to display after preventing default
      event.notification.display();
    });
  }

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