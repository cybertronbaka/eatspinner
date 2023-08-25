import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingDialog {
  static bool isOpen = false;

  static open(BuildContext context){
    if(isOpen) return;

    isOpen = true;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      barrierDismissible: false,
      builder: (context){
        return const Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }

  static close(BuildContext context){
    if(!isOpen) return;

    context.pop();
    isOpen = false;
  }
}