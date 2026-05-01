import 'package:flutter/material.dart';
import 'package:movie_tracker/config/routes/app_router.dart';
import 'package:movie_tracker/config/themes/app_theme.dart';
import 'package:movie_tracker/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie Tracker',
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
