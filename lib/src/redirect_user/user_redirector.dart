import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/save_user_data/session_manager.dart';

class UserRedirector extends StatelessWidget {
  UserRedirector({super.key});
  final SessionManager sessionManager = SessionManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: sessionManager.isSessionValid(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/navigation');
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/login');
          });
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
