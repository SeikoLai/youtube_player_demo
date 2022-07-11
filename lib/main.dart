import 'package:flutter/material.dart';
import 'package:video_player_demo/src/app/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  /// Config app them
  static ThemeData _configTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      indicatorColor: Colors.white,
      textTheme: _configTextTheme(base.textTheme),
    );
  }

  static TextTheme _configTextTheme(TextTheme base) {
    return base.copyWith(
        caption: base.caption
            ?.copyWith(color: Colors.black, fontSize: 14.0, height: 20.0));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: _configTheme(),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _appRouter.router.routeInformationProvider,
      routeInformationParser: _appRouter.router.routeInformationParser,
      routerDelegate: _appRouter.router.routerDelegate,
    );
  }

  final AppRouter _appRouter = AppRouter();
}
