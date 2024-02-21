import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/detect.dart';
import 'pages/about.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return  HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'detect',
          builder: (BuildContext context, GoRouterState state) {
            return  DetectPage();
          },
        ),      GoRoute(
          path: 'about',
          builder: (BuildContext context, GoRouterState state) {
            return  AboutPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      routerConfig:_router,
    );
  }
}