// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $bottomNavRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      name: 'initial',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => SplashRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bottomNavRoute => StatefulShellRouteData.$route(
      factory: $BottomNavRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/home',
              name: 'home',
              factory: $HomeRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'topics',
                  name: 'topics',
                  factory: $TopicsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'quiz',
                  name: 'quiz',
                  factory: $QuizRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'questions',
                  name: 'questions',
                  factory: $QuestionsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'results',
                  name: 'results',
                  factory: $ResultsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/account',
              name: 'account',
              factory: $AccountRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $BottomNavRouteExtension on BottomNavRoute {
  static BottomNavRoute _fromState(GoRouterState state) =>
      const BottomNavRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TopicsRouteExtension on TopicsRoute {
  static TopicsRoute _fromState(GoRouterState state) => TopicsRoute(
        int.parse(state.uri.queryParameters['subject-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/topics',
        queryParams: {
          'subject-id': subjectId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QuizRouteExtension on QuizRoute {
  static QuizRoute _fromState(GoRouterState state) => QuizRoute(
        int.parse(state.uri.queryParameters['topic-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/quiz',
        queryParams: {
          'topic-id': topicId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $QuestionsRouteExtension on QuestionsRoute {
  static QuestionsRoute _fromState(GoRouterState state) => QuestionsRoute(
        int.parse(state.uri.queryParameters['quiz-id']!),
      );

  String get location => GoRouteData.$location(
        '/home/questions',
        queryParams: {
          'quiz-id': quizId.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ResultsRouteExtension on ResultsRoute {
  static ResultsRoute _fromState(GoRouterState state) => ResultsRoute(
        correctCount: int.parse(state.uri.queryParameters['correct-count']!),
        incorrectCount:
            int.parse(state.uri.queryParameters['incorrect-count']!),
        wrongAnswersList: state.uri.queryParametersAll['wrong-answers-list']
            ?.map((e) => e)
            .toList(),
      );

  String get location => GoRouteData.$location(
        '/home/results',
        queryParams: {
          'correct-count': correctCount.toString(),
          'incorrect-count': incorrectCount.toString(),
          if (wrongAnswersList != null) 'wrong-answers-list': wrongAnswersList,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRouteExtension on AccountRoute {
  static AccountRoute _fromState(GoRouterState state) => AccountRoute();

  String get location => GoRouteData.$location(
        '/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
