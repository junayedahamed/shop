import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/ui/widget/custom_button.dart';

class NullUserAccount extends StatelessWidget {
  const NullUserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Icon(Icons.person, size: 100, color: Colors.grey)),
        SizedBox(height: 20),
        Text(
          "No user logged in",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 35),
        CustomButton(
          width: 200,
          color: Color(0xff9e733e),
          onPress: () {
            context.push('/login');
          },
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
