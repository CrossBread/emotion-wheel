import 'package:emotion_wheel/common/data/models/app_state.dart';
import 'package:emotion_wheel/common/data/models/feeling_wheel_emotions.dart';
import 'package:emotion_wheel/common/flutter_utils.dart';
import 'package:emotion_wheel/common/presentation/pages/splash_page.dart';
import 'package:emotion_wheel/common/presentation/widgets/emotion_detail_screen.dart';
import 'package:emotion_wheel/constants.dart';
import 'package:emotion_wheel/provider/presentation/pages/home_page.dart';
import 'package:emotion_wheel/provider/presentation/widgets/emotion_quiz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

typedef EmotionColors = List<MaterialColor>;

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class ProviderApp extends StatefulWidget {
  static final GoRouter router = GoRouter(
    initialLocation: '/home/quiz',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => SplashPage(
          onLoad: () async {},
          onLoadComplete: () {},
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(path: '/home/quiz', name: 'quiz', builder: (context, state) => const GoodBadScreen()),
          GoRoute(path: '/home/quiz2', name: 'quiz-core', builder: (context, state) => const CoreScreen()),
          GoRoute(
              path: '/home/quiz3',
              name: 'quiz-secondary',
              builder: (context, state) => const SecondaryScreen()),
          GoRoute(
              path: '/home/quiz4',
              name: 'quiz-tertiary',
              builder: (context, state) => const TertiaryScreen()),
          GoRoute(
              path: '/home/emotion-detail/:emotionName',
              name: 'emotion-detail',
              builder: (context, state) {
                return EmotionDetailScreen(state.params[kEmotionNamePathParameter] ?? 'error');
              }),
        ],
        builder: (context, state, child) => HomePage(body: child),
      )
    ],
  );

  final Widget Function(RouterConfig<Object> router) builder;

  const ProviderApp({super.key, required this.builder});

  @override
  State<ProviderApp> createState() => _ProviderAppState();
}

class _ProviderAppState extends State<ProviderApp> {
  bool isLoading = true;
  late FeelingWheelEmotions _feelingWheelEmotions;

  @override
  void initState() {
    super.initState();
    _initFeelingWheelEmotions();
  }

  @override
  Widget build(BuildContext context) {
    print('isLoading?: $isLoading');
    return isLoading
        ? Container(
            color: Colors.black12,
            child: const Center(child: CircularProgressIndicator()),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<AppState>(create: (BuildContext context) => AppState()),
              Provider<FeelingWheelEmotions>(
                create: (context) {
                  return _feelingWheelEmotions;
                },
              ),
              Provider<EmotionColors>(create: (context) {
                EmotionColors list = [
                  Colors.yellow,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                  Colors.deepOrange,
                  Colors.orange
                ];
                return list;
              }),
            ],
            // builder: (context, child) {
            //   return Consumer2<FeelingWheelEmotions, EmotionColors>(
            //       builder: (context, emotions, colors, child) {
            //     return EmotionWheelApp(router: ProviderApp.router);
            //   });
            // },
            child: widget.builder(ProviderApp.router),
            // child: EmotionWheelApp(router: router),
          );
  }

  Future<void> _initFeelingWheelEmotions() async {
    var json = await loadJsonFromAsset(kEmotionDataFilePath);
    _feelingWheelEmotions = FeelingWheelEmotions.fromJson(json);
    setState(() {
      isLoading = false;
    });
  }
}
