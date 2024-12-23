import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/core/app_router.dart';

/// The Root widget
class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(
        //   surface: ColorName.white,
        //   seedColor: ColorName.white,
        //   surfaceTint: ColorName.white,
        // ),
        // scaffoldBackgroundColor:  const Color(0xFFFFFBFF),
        // scaffoldBackgroundColor: ColorName.primaryAccent.withOpacity(0.05),
        useMaterial3: true,
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          titleSmall: TextStyle(letterSpacing: 2),
        ),
      ),
      // builder: (context, child) {
      //   final mediaQuery = MediaQuery.of(context);
      //   final scaleRange = mediaQuery.textScaler.clamp(
      //     minScaleFactor: 0.8,
      //     maxScaleFactor: 1.5,
      //   );
      //   return MediaQuery(
      //     data: mediaQuery.copyWith(
      //       textScaler: scaleRange,
      //     ),
      //     child: EasyLoading.init(
      //       builder: BotToastInit(),
      //     ).call(context, child),
      //   );
      // },
      // supportedLocales: L10n.all,
      // locale: const Locale('en'),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      routerConfig: AppRouter.router,
    );
  }
}
