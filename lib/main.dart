import 'package:eatspinner/app/_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Journal:
// 1. Damn, OneSignal is all over the place. It calls extra data for new notifications as custom_data in backend and additionalData in frontend. Very inconsistent.
// 2. Supabase is lit! but the only problem with it is cache. It doesn't have any support of caches. So have to built 1 ourselves.
// 3. Other features like sms and notifications are third party but it is ok.

void main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONE_SIGNAL_APP_ID']!);
  OneSignal.Notifications.requestPermission(true);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
    // debug: true
  );
  runApp(const EatSpinnerApp());
}
