import 'dart:async';

import 'package:eatspinner/app/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  static bool _blockStream = false;
  static bool _gotInitialUri = false;
  static StreamSubscription<Uri?>? _subscription;

  static void handleOnRunning(BuildContext context){
    _blockStream = false;
    _subscription = uriLinkStream.listen((initialUri) {});
    _subscription!.onData((data) {
      if(_blockStream) return;

      print('_---------------From Stream');
      final route = _handleDeepLinks(data);
      if(route == null) return;

      context.push(route);
    });
  }

  static void blockRunning(){
    _blockStream = true;
  }

  static Future<String?> handleOnStart() async{
    if(_gotInitialUri) return null;

    _gotInitialUri = true;
    try {
      // Get the initial URI when the app is opened
      Uri? initialUri = await getInitialUri();
      return _handleDeepLinks(initialUri);
    } catch (error) {
      print("Error while initializing uni_links: $error");
    }
    return null;
  }

  static String? _handleDeepLinks(Uri? uri){
    if (uri != null) {
      final newUri = Uri.parse(uri.toString().replaceAll('/#', '?'));
      print('****************************************URI:::: ${newUri.toString()}');
      print('****************************************DATA:::: ${newUri.queryParameters}');
      if (newUri.scheme == 'com.example.eatspinner' && newUri.host == 'resetpassword') {
        print('***********ERROR? : ${newUri.queryParameters['error']}');
        if(newUri.queryParameters['error'] != null){
          return Routes.notFound;
        }
        return Routes.resetPassword;
      }
    }
  }
}