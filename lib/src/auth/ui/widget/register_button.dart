import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/auth/bloc/auth_bloc.dart';
import 'package:ocad/src/auth/ui/widget/custom_button.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton({
    super.key,
    required this.formkey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });
  final GlobalKey<FormState> formkey;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      buildWhen: (previous, current) => current is! AuthActionState,
      listenWhen: (previous, current) => current is AuthActionState,
      listener: (context, state) {
        if (state is RegistrationFailureState) {
          log("Registration failed: ${state.error}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        switch (state) {
          case RegistrationSuccessState():
            return CustomButton(
              color: Color(0xff9e733e),
              onPress: () {
                if (formkey.currentState!.validate()) {
                  authBloc.add(
                    RegisterUserEvent(
                      context: context,
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  );
                }
              },
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );

          case RegistrationLoadingState():
            return CustomButton(
              color: Color(0xff9e733e),
              onPress: () {
                // if (_formkey.currentState!.validate()) {
                //   // Perform login action
                // }
                return;
              },
              child: Center(
                child: Transform.scale(
                  scale: 0.6,
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            );
          case RegistrationFailState():
            return Column(
              spacing: 5,
              children: [
                Text(state.error, style: TextStyle(color: Colors.red)),
                CustomButton(
                  color: Color(0xff9e733e),
                  onPress: () {
                    if (formkey.currentState!.validate()) {
                      authBloc.add(
                        RegisterUserEvent(
                          context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Text(
                      "Sign Up",
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

          default:
            return CustomButton(
              color: Color(0xff9e733e),
              onPress: () {
                if (formkey.currentState!.validate()) {
                  authBloc.add(
                    RegisterUserEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      name: nameController.text.trim(),
                      context: context,
                    ),
                  );
                }
              },
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
