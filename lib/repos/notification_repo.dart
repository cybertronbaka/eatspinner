import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OneSignalNotification{
  final List<String> uidList;
  final String contents;
  final String heading;
  final String? smallIcon;
  final String? largeIcon;
  final String? androidAccentColor;
  final String targetChannel;
  final Map<String, dynamic>? data;
  final String? appUrl;
  OneSignalNotification({
    required this.uidList,
    required this.heading,
    required this.contents,
    this.data,
    this.smallIcon,
    this.largeIcon,
    this.androidAccentColor,
    this.appUrl,
    this.targetChannel = "push"
  });

  Map<String, dynamic> toJson(){
    return {
      "include_aliases": {
        "external_id": uidList
      },
      "target_channel": targetChannel,
      "headings": {"en": heading},
      "contents": {"en": contents},
      if(androidAccentColor != null) "android_accent_color": androidAccentColor!,
      if(smallIcon != null) "small_icon": smallIcon,
      if(largeIcon != null) "large_icon": largeIcon,
      if(data != null) "custom_data": data,
      if(appUrl != null) "app_url": 'eatspinner://com.example.eatspinner$appUrl',
    };
  }
}

class NotificationRepo {
  Future<bool> sendNotification(OneSignalNotification notification) async{
    if(notification.uidList.isEmpty) return false;

    final response = await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Authorization': 'Basic ${dotenv.env["ONE_SIGNAL_API_KEY"]}',
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>
      {
        "app_id": dotenv.env["ONE_SIGNAL_APP_ID"],
        ...notification.toJson()
      }),
    );
    final responseJson = jsonDecode(response.body);
    if(responseJson['errors'] == null){
      return true;
    }

    print('COULD NOT SEND NOTIFICATION: THERE WAS AN ERROR: ${responseJson['errors']}');
    return false;
  }
}