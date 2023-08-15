import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EsToast {
  static void showError(String msg){
    print('ERROR: $msg');
    Fluttertoast.showToast(
        msg: 'Error: $msg',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

  static void showSuccess(String msg){
    print('Success: $msg');
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }
}