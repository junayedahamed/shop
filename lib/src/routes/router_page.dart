import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/ui/login_page.dart';
import 'package:ocad/src/auth/ui/registration_page.dart';
import 'package:ocad/src/navigator/navigator_page.dart';
import 'package:ocad/src/redirect_user/user_redirector.dart';

GoRouter get router => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => UserRedirector()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(
      path: '/registration',
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(path: '/navigation', builder: (context, state) => NavigatorPage()),
  ],
);
