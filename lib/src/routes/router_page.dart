import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/ui/login_page.dart';
import 'package:ocad/src/home/ui/home_page.dart';

GoRouter get router => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
);
