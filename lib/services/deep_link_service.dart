import 'dart:async';

import 'package:eatspinner/app/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  bool _blockStream = false;
  bool _gotInitialUri = false;
  StreamSubscription<Uri?>? _subscription;
  String key = '';

  Future<void> handleOnRunning(BuildContext context, String newKey) async {
    while(key != '') {
      print('Waiting for $key to be released for $newKey');
    }

    print('_---------------HANDLE ON RUNNING on $newKey');
    key = newKey;
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

  Future<void> blockRunning(String newKey) async {
    print('_---------------BLOCK RUNNING on $newKey and key == newKey -> ${key == newKey}');
    if(key == newKey){
      _blockStream = true;
      key = '';
      print('_---------------BLOCK RUNNING on $newKey');
    }
  }

  Future<String?> handleOnStart() async{
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

  String? _handleDeepLinks(Uri? uri){
    if (uri != null) {
      final newUri = Uri.parse(uri.toString().replaceAll('/#', '?'));
      if (newUri.scheme == 'com.example.eatspinner' && newUri.host == 'resetpassword') {
        print('***********ERROR? : ${newUri.queryParameters['error']}');
        if(newUri.queryParameters['error'] != null){
          return Routes.notFound;
        }
        return Routes.resetPassword;
      }
    }
    return null;
  }
}