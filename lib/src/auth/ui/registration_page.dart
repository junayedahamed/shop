import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocad/src/auth/bloc/auth_bloc.dart';
import 'package:ocad/src/auth/ui/tex_field_eye_toggler/text_field_eye_togller.dart';
import 'package:ocad/src/auth/ui/widget/cuistom_text_field.dart';
import 'package:ocad/src/auth/ui/widget/register_button.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final Color _focusedBorderColor = const Color(0xff9e723d);
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthBloc authBloc = AuthBloc();
  final TextFieldEyeTogller textFieldEyeTogller = TextFieldEyeTogller();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF9F4),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              // spacing: 12,
              children: [
                SizedBox(height: 35),
                Text(
                  textScaler: TextScaler.linear(1.3),
                  "Welcome to eShop!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "Welcome! Please provide your information to create an account.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Full name is required";
                    }
                    return textFieldEyeTogller.validateName(value);
                  },
                  controller: fullNameController,
                  fillcolor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,

                  focusedBorderColor: _focusedBorderColor,
                  enabledBorderColor: Colors.blueGrey.shade600,
                ),
                SizedBox(height: 14),
                Text(
                  "Email address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return textFieldEyeTogller.validateEmail(value);
                  },
                  controller: emailController,
                  fillcolor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,

                  focusedBorderColor: _focusedBorderColor,
                  enabledBorderColor: Colors.blueGrey.shade600,
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                ListenableBuilder(
                  listenable: textFieldEyeTogller,
                  builder: (context, asyncSnapshot) {
                    return CustomTextField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return textFieldEyeTogller.validatePassword1(value);
                      },
                      fillcolor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorderColor: Colors.blueGrey.shade600,
                      filled: true,

                      obscureText: textFieldEyeTogller.isObscure1,
                      focusedBorderColor: _focusedBorderColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          textFieldEyeTogller.toggle1();
                        },
                        icon: Icon(
                          textFieldEyeTogller.isObscure1
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 22,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                ListenableBuilder(
                  listenable: textFieldEyeTogller,
                  builder: (context, asyncSnapshot) {
                    return CustomTextField(
                      controller: confirmPasswordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return " Confirm password is required";
                        }
                        return textFieldEyeTogller.validatePassword2(
                          passwordController.text,
                          value,
                        );
                      },
                      fillcolor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorderColor: Colors.blueGrey.shade600,
                      filled: true,

                      obscureText: textFieldEyeTogller.isObscure2,
                      focusedBorderColor: _focusedBorderColor,
                      suffixIcon: IconButton(
                        onPressed: () {
                          textFieldEyeTogller.toggle2();
                        },
                        icon: Icon(
                          textFieldEyeTogller.isObscure2
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 22,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 10),
                RegisterButton(
                  formkey: _formkey,
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: fullNameController,
                ),

                SizedBox(height: 15),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade700,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.go('/login');
                            },
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff9e733e),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
