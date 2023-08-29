import 'package:eatspinner/services/_all.dart';
import 'package:eatspinner/states/_all.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAction {
  final VoidCallback callback;
  final Widget widget;
  final String title;

  const ProfileAction({
    required this.title,
    required this.callback,
    required this.widget
  });
}

enum ProfileMainActionMode {
  none, addToContact, accept, rejectedByMe, rejectedByOther, requestAlreadySent, alreadyFriends
}

extension ProfileMainActionModeExt on ProfileMainActionMode {
  String labelText() {
    switch(this){
      case ProfileMainActionMode.none:
        return '';
      case ProfileMainActionMode.requestAlreadySent:
        return 'Request Already Sent';
      case ProfileMainActionMode.accept:
        return 'Accept';
      case ProfileMainActionMode.rejectedByMe:
        return 'Rejected';
      case ProfileMainActionMode.rejectedByOther:
        return 'Rejected';
      case ProfileMainActionMode.addToContact:
        return 'Add to Contacts';
      case ProfileMainActionMode.alreadyFriends:
        return 'Friends';
    }
  }

  bool canSendMessage() {
    return this == ProfileMainActionMode.alreadyFriends;
  }

  VoidCallback? callback(BuildContext context, ProfileController controller){
    switch(this){
      case ProfileMainActionMode.none:
        return null;
      case ProfileMainActionMode.requestAlreadySent:
        return null;
      case ProfileMainActionMode.accept:
        return (){
          LoadingDialog.open(context);
          controller.acceptRequest().then((value){
            LoadingDialog.close(context);
          });
        };
      case ProfileMainActionMode.rejectedByMe:
        return null;
      case ProfileMainActionMode.rejectedByOther:
        return null;
      case ProfileMainActionMode.addToContact:
        return (){
          LoadingDialog.open(context);
          controller.addToContact().then((value){
            LoadingDialog.close(context);
          });
        };
      case ProfileMainActionMode.alreadyFriends:
        return null;
    }
  }

  List<ProfileAction> moreActions(BuildContext context, ProfileController controller){
    switch(this){
      case ProfileMainActionMode.none:
        return [];
      case ProfileMainActionMode.requestAlreadySent:
        return [
          ProfileAction(
            title: 'Cancel Request',
            callback: (){
              LoadingDialog.open(context);
              controller.cancelRequest().then((value){
                LoadingDialog.close(context);
                context.pop();
              });
            },
            widget: const Icon(Icons.cancel_schedule_send_outlined)
          )
        ];
      case ProfileMainActionMode.accept:
        return [
          ProfileAction(
            title: 'Reject Request',
            callback: (){
              LoadingDialog.open(context);
              controller.rejectRequest().then((value){
                LoadingDialog.close(context);
                context.pop();
              });
            },
            widget: const Icon(Icons.remove_circle_outline_outlined)
          )
        ];
      case ProfileMainActionMode.rejectedByMe:
        return [
          ProfileAction(
              title: 'Accept Request',
              callback: (){
                LoadingDialog.open(context);
                controller.acceptRequest().then((value){
                  LoadingDialog.close(context);
                  context.pop();
                });
              },
              widget: const Icon(Icons.check_outlined)
          )
        ];
      case ProfileMainActionMode.rejectedByOther:
        return [];
      case ProfileMainActionMode.addToContact:
        return [];
      case ProfileMainActionMode.alreadyFriends:
        return [
          // ProfileAction(title: 'Block', callback: (){}, widget: const Icon(Icons.block_outlined)),
          // ProfileAction(title: 'Report', callback: (){}, widget: const Icon(Icons.report_gmailerrorred_outlined)),
          ProfileAction(
            title: 'Unfriend',
            callback: (){
              LoadingDialog.open(context);
              controller.unfriend().then((value){
                LoadingDialog.close(context);
                context.pop();
              });
            },
            widget: const Icon(Icons.person_remove_outlined)
          )
        ];
    }
  }
}