import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:quiz_app/gen/colors.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// This is the overlay used for showing the loading animation
// final loadingOverlay = OverlayEntry(
//   maintainState: false,
//   builder: (context) => Center(
//     child: LoadingAnimationWidget.hexagonDots(
//       color: ColorName.blue,
//       size: 100,
//     ),
//   ),
// );
OverlayEntry appLoader() {
  return OverlayEntry(
    maintainState: false,
    builder: (context) => Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: Colors.blue,
        size: 100,
      ),
    ),
  );
}

/// This is the provider to store the loading state of any screen.
///
/// Update it accordingly to show the loading animation.
final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

/// Just call this function in the build method of the screen.
///
/// This will show a loader when required.
void loadingListener(BuildContext context, WidgetRef ref,
    [OverlayEntry? overlayEntry]) {
  EasyLoading.instance.backgroundColor = Colors.transparent;
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
  // EasyLoading.instance.backgroundColor = Colors.transparent;
  // EasyLoading.instance.maskType = EasyLoadingMaskType.custom;
  // EasyLoading.instance.maskColor = Colors.grey;
  // final overlay = Overlay.of(context);
  ref.listen<bool>(isLoadingProvider, (previous, next) async {
    if (next) {
      await startLoading();
    } else {
      await stopLoading();
    }
  });
}

Future<void> startLoading([WidgetRef? ref]) async {
  EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
  EasyLoading.instance.backgroundColor = null;
  // EasyLoading.instance
  //     ..displayDuration = const Duration(milliseconds: 2500)
  //     ..loadingStyle = EasyLoadingStyle.custom
  //     ..radius = 10.0
  //     ..textColor = Colors.white
  //     ..indicatorColor = Colors.transparent
  //     ..maskColor = Colors.transparent
  //     ..backgroundColor = Colors.transparent
  //     ..boxShadow = []
  //     ..userInteractions = true
  //     ..dismissOnTap = false;

  // EasyLoading.instance.indicatorSize = 20;
  await EasyLoading.show(
    indicator: SizedBox(
      width: 50,
      child: LoadingAnimationWidget.hexagonDots(
        color: Colors.blue,
        size: 50,
      ),
    ),
  );
}

Future<void> stopLoading([WidgetRef? ref]) async {
  EasyLoading.removeAllCallbacks();
  await EasyLoading.dismiss();
}

bool get isLoading => EasyLoading.isShow;
