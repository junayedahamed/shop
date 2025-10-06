import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/ui/login_page.dart';
import 'package:ocad/src/auth/ui/registration_page.dart';
import 'package:ocad/src/navigator/navigator_page.dart';
import 'package:ocad/src/product_details/ui/widget/product_details_page.dart';
import 'package:ocad/src/redirect_user/user_redirector.dart';

GoRouter get router => GoRouter(
  routes: [
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => UserRedirector(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: 'registration',
      path: '/registration',
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      name: 'navigation',
      path: '/navigation',
      builder: (context, state) => NavigatorPage(),
    ),
    GoRoute(
      name: 'details',
      path: '/details/:product/:isFavorite',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final product = extra['product'];
        final isFavorite = extra['isFavorite'];
        return ProductDetailsPage(product: product, isFavorite: isFavorite);
      },
    ),
  ],
);
