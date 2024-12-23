// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_app/feature/quiz/account_screen.dart';
import 'package:quiz_app/feature/quiz/bottom_nav_screen.dart';
import 'package:quiz_app/feature/quiz/home_screen.dart';
import 'package:quiz_app/feature/welcome/splash_screen.dart';

part 'app_router.g.dart';

// private navigators
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// In any TypedGoRoute, we can pass only the primitive data types..
///
/// String, int, double, float, List
/// Map, user defined classes
///
/// User user  = User();
/// user.toString();
///

class AppRouter {
  static BuildContext? get currentContext => rootNavigatorKey.currentContext;

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [],
    debugLogDiagnostics: true,
    // errorBuilder: (context, state) => const NotFoundScreen(),
    initialLocation: RoutePath.initial,
    routes: $appRoutes,
  );
}

// class NotFoundScreen extends StatelessWidget {
//   const NotFoundScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CommonErrorPage(
//       error: '404, Not Found',
//       stackTrace: StackTrace.fromString(
//         'You are looking for something which doesn\'t exists',
//       ),
//       buttonText: 'Go to Home Page',
//       onPressed: () {
//         context.goNamed(RouteName.home);
//       },
//     );
//   }
// }

@TypedGoRoute<SplashRoute>(
  path: RoutePath.initial,
  name: RouteName.initial,
)
class SplashRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: SplashScreen());
  }
}

@TypedStatefulShellRoute<BottomNavRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: RoutePath.home,
          name: RouteName.home,
          routes: [
            TypedGoRoute<TopicsRoute>(
              path: 'topics',
              name: 'topics',
            ),
            TypedGoRoute<QuizRoute>(
              path: 'quiz',
              name: 'quiz',
            ),
            TypedGoRoute<QuestionsRoute>(
              path: 'questions',
              name: 'questions',
            ),
            TypedGoRoute<ResultsRoute>(
              path: 'results',
              name: 'results',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<AccountRoute>(
          path: RoutePath.account,
          name: RouteName.account,
          routes: [],
        ),
      ],
    ),
  ],
)
class BottomNavRoute extends StatefulShellRouteData {
  const BottomNavRoute();
  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return NoTransitionPage(
      child: BottomNavScreen(
        key: state.pageKey,
        child: navigationShell,
      ),
    );
  }
}

class HomeRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: HomeScreen());
  }
}

class TopicsRoute extends GoRouteData {
  final int subjectId;
  const TopicsRoute(this.subjectId);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: TopicsScreen(subjectId: subjectId));
  }
}

// class Topic {
//   const Topic();
//   factory Topic.fromJson(Map<String, dynamic> json) => const Topic();
// }

class QuizRoute extends GoRouteData {
  final int topicId;
  const QuizRoute(this.topicId);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    // Topic.fromJson(json.decode(topic));
    return NoTransitionPage(child: QuizScreen(topicId: topicId));
  }
}

class QuestionsRoute extends GoRouteData {
  final int quizId;
  const QuestionsRoute(this.quizId);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: QuestionsScreen(quizId: quizId));
  }
}

class ResultsRoute extends GoRouteData {
  final int incorrectCount;
  final int correctCount;
  final List? wrongAnswersList;
  const ResultsRoute({
    required this.correctCount,
    required this.incorrectCount,
    required this.wrongAnswersList,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(
      child: ResultsScreen(
        correctCount: correctCount,
        incorrectCount: incorrectCount,
        wrongAnswersList: wrongAnswersList ?? [],
      ),
    );
  }
}

class AccountRoute extends GoRouteData {
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const NoTransitionPage(child: AccountScreen());
  }
}

//* -- Account Related Routes --

class RoutePath {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String permissions = '/permissions';

  // ----  AUTH  ----
  static const String login = '/login';

  // ----  CREATE ACCOUNT /----
  static const String register = '/register';
  static const String verifyPhone = '/verify-phone';
  static const String registerVerify = '/register-verify';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordVerify = '/forgot-password-verify';
  static const String resetPassword = '/reset-password';

  // ---- BOTTOM NAV SCREENS  /----
  static const String home = '/home';
  static const String job = '/job';
  static const String invoice = '/invoice';
  static const String search = '/search';
  static const String booking = '/booking';
  static const String chat = '/chat';
  static const String account = '/account';

  // ---------- PAYMENT ---------
  static const String payment = 'payment';
  static const String paymentHistory = 'payment-history';
  static const String paymentMethod = '/payment-method';
  static const String paymentMethodForm = '/payment-method-form';
  static const String paymentStatus = '/payment-status';

  // ---------- ACCOUNT ---------
  static const String updateProfile = '/update-profile';
  static const String describeYourself = '/describe-yourself';
  static const String iceBreakers = '/ice-breakers';
  static const String datingPool = '/dating-pool';

  static const String preferences = '/preferences';

  // static const String datePreference = '/date-preference';
  // static const String paymentPreference = '/payment-preference';
  // static const String spendingSettings = '/spending-settings';

  // static const String photoIdProof = '/photo-id-proof';
  // static const String selfieVerification = '/selfie-verification';

  static const String profile = 'profile';
  // static const String profileGallery = '/profile-gallery';

  // static const String privacySetting = '/privacy-setting';

  static const String availability = '/availability';

  static const String favorites = '/favorites';

  // --------- OTHERS -----------
  static const String maintenance = '/maintenance';
  static const String error = '/error';

  static const String notification = '/notification';

  static const String plans = '/plans';
  static const String subscription = '/subscription';
}

class RouteName {
  static const String initial = 'initial';
  static const String welcome = 'welcome';
  static const String permissions = 'permissions';

  // ----  AUTH  ----
  static const String login = 'login';
  static const String forgotPassword = 'forgot-password';
  static const String forgotPasswordVerify = 'forgot-password-verify';
  static const String resetPassword = 'reset-password';

  // ----  CREATE ACCOUNT /----
  static const String onboarding = 'onboarding';
  static const String locationPermission = 'locationPermission';
  static const String register = 'register';
  static const String verifyEmail = 'verifyEmail';
  static const String verifyPhone = 'verifyPhone';
  static const String registerVerify = 'registerVerify';

  static const String availability = 'availability';
  static const String uploadDocuments = 'uploadDocuments';

  // ---- BOTTOM NAV SCREENS  ----
  static const String home = 'home';
  static const String job = 'job';
  static const String invoice = 'invoice';
  static const String booking = 'booking';
  static const String bookingDetails = 'bookingDetails';
  static const String chat = 'chat';
  static const String chatMessages = 'chatMessages';
  static const String account = 'account';

  // ----  SERVICES  ----
  static const String search = 'search';

  // ---------- PAYMENT ---------
  static const String payment = 'payment';
  static const String paymentHistory = 'payment-history';
  static const String paymentMethod = 'payment-method';
  static const String paymentMethodForm = 'payment-method-form';
  static const String paymentStatus = 'payment-status';

  // ---------- ACCOUNT ---------

  static const String privacySetting = 'privacySetting';
  static const String likedProfiles = 'likedProfiles';
  static const String partnerProfile = '/partnerProfile';

  static const String profile = 'profile';

  static const String updateProfile = 'updateProfile';
  static const String profileGallery = 'profileGallery';
  static const String describeYourself = 'describeYourself';
  static const String iceBreakers = 'iceBreakers';
  static const String datingPool = 'datingPool';

  static const String preferences = 'preferences';

  static const String datePreference = 'datePreference';
  static const String paymentPreference = 'paymentPreference';
  static const String spendingSettings = 'spendingSettings';

  static const String photoIdProof = 'photoIdProof';
  static const String selfieVerification = 'selfieVerification';

  // --------- OTHERS -----------
  static const String maintenance = 'maintenance';
  static const String error = 'error';

  static const String notification = 'notification';
  static const String plans = 'plans';
  static const String subscription = 'subscription';
}

Page slideTransitionPage(
  Widget child, {
  int? milliseconds,
  Tween<Offset>? tween,
}) {
  return CustomTransitionPage(
    transitionDuration: Duration(milliseconds: milliseconds ?? 200),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(
        tween ?? Tween(begin: const Offset(1, 0), end: const Offset(0, 0)),
      ),
      child: child,
    ),
  );
}
