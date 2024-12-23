import 'dart:async';
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/app.dart';
import 'package:quiz_app/core/loader.dart';
import 'package:quiz_app/core/push_notification_helper.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  //* --- Crashlytics ---
  // initCrashlytics();

  //* --- Local Db Initialization ---
  await initLocalDB();

  //* -- Firebase setup --
  // await initFirebase(options: firebaseOptions);

  //* -- FCM setup --
  await initFCM();

  // Add cross-flavor configuration here
  runApp(await builder());
}

Future<void> initLocalDB() async {
  // await DatabaseHelper.instance .init();
}

// Future<void> initFirebase({required FirebaseOptions options}) async {
//   try {
//     if (Firebase.apps.isEmpty) {
//       await Firebase.initializeApp(
//         options: options,
//       );
//     }
//     debugPrint(Firebase.app().toString());
//   } on Exception catch (e) {
//     debugPrint(e.toString());
//   }
// }

Future<void> initFCM() async {
  try {
    // var status = await PermissionHelper.requestAllPermissions();
    // debugPrint("Permission Status: $status");
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    await PushNotificationHelper.fcmSetup();
    PushNotificationHelper.setupInteractedMessage();
    PushNotificationHelper.handleBackgroundMessage();
    PushNotificationHelper.handleForegroundMessage();
  } on Exception catch (e) {
    // TODO: log exception
    debugPrint(e.toString());
  }
}

void initCrashlytics() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    FirebaseCrashlytics.instance.recordError(errorDetails, null);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    stopLoading();
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Widget quizApp() => const ProviderScope(child: App());
