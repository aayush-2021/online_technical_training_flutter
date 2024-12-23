// Handle the background message from firebase
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  await PushNotificationHelper.setupInteractedMessage();
  debugPrint("handleBackgroundMessage: $message");
}

class PushNotificationHelper {
  static void handleBackgroundMessage() {
    debugPrint("handleBackgroundMessage");
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static void handleForegroundMessage() {
    // Handle the foreground message from firebase
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log(message.data.toString(), name: 'message data');
      PushNotificationHelper.onDidReceiveLocalNotification(
          1,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          message.data);
      if (message.notification != null) {}
    });
  }

// In this example, suppose that all messages contain a data field with the key 'type'.
  static Future<void> setupInteractedMessage() async {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    debugPrint("fcm message: $message");
    log(message.toString(), name: 'Message');
    log(message.data.toString(), name: 'Message data');
    // if (rootNavigatorKey.currentContext != null) {
    //   var notice = message.data['result'];
    //   if (notice == null) return;
    // showModalBottomSheet(
    //   context: rootNavigatorKey.currentContext!,
    //   useRootNavigator: true,
    //   isScrollControlled: true,
    //   isDismissible: notice?['canClose'] ?? true,
    //   builder: (context) {
    //     return const ClipRRect(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(30),
    //         topRight: Radius.circular(30),
    //       ),
    //       // child: FirstNotificationBottomSheet(
    //       //   title: notice?['message'] ?? '',
    //       //   desc: notice?['clause'] ?? '',
    //       //   buttonText: notice?['button'] ?? '',
    //       //   routeName: notice?['buttonRouteName'] ?? '',
    //       //   merchantId: notice?['merchantId'] ?? '',
    //       //   merchantStoreId: notice?['merchantStoreId'],
    //       // ),
    //     );
    //   },
    // );
    // }
  }

  static Future<void> fcmSetup() async {
    // if (kIsWeb) return;
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      debugPrint("fcmToken: $fcmToken");

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        debugPrint("fcmToken: $fcmToken");
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
        // TODO: updateFcmToken(fcmToken);
      }).onError((err) {
        // Error getting token.
        debugPrint("fcm err: $err");
      });
    } on Exception catch (e) {
      // TODO: log exception
    }
  }

  static void onDidReceiveLocalNotification(
    int id,
    String title,
    String body,
    Map<String, dynamic> payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 5),
      toastBuilder: (cancelFunc) => Container(
        // height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFDAF2E1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // TODO:
            // Assets.icons.greenTick.svg(),
            // const Gap(12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text(
                    body,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // static updateFcmToken(String fcmToken) async {
  //   final container = ProviderContainer();
  //   final updateFcmTokenResponse = await container
  //       .read(authRepoProvider)
  //       .updateFcmToken(fcmToken: fcmToken);
  //   debugPrint("Update_Fcm_Token response: ");
  //   updateFcmTokenResponse.fold((l) {
  //     // TODO: log error on crashlytics
  //     // errorToast(l.error, message: l.message);
  //     return null;
  //   }, (r) {
  //     return r;
  //   });
  // }
}
