import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocad/src/auth/bloc/auth_bloc.dart';
import 'package:ocad/src/auth/ui/login_page.dart';
import 'package:ocad/src/auth/ui/widget/cuistom_text_field.dart';
import 'package:ocad/src/auth/ui/widget/custom_button.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final Color _focusedBorderColor = const Color(0xff9e723d);
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthBloc authBloc = AuthBloc();
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
                SizedBox(height: 20),
                Text(
                  "Full Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Full Name is required";
                    }
                    return null;
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
                SizedBox(height: 12),
                CustomTextField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                  controller: emailController,
                  fillcolor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,

                  focusedBorderColor: _focusedBorderColor,
                  enabledBorderColor: Colors.blueGrey.shade600,
                ),
                SizedBox(height: 16),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12),
                BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    return CustomTextField(
                      controller: passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      fillcolor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorderColor: Colors.blueGrey.shade600,
                      filled: true,

                      obscureText: state is ShowPasswordStateRegistration
                          ? !state.isShow
                          : true,
                      focusedBorderColor: _focusedBorderColor,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          authBloc.add(ShowPasswordEventRegistration());
                        },
                        child: Icon(
                          state is ShowPasswordStateRegistration && state.isShow
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          size: 22,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 12),

                SizedBox(height: 10),
                CustomButton(
                  color: Color(0xff9e733e),
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      // Perform login action
                    }
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false,
                              );
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
