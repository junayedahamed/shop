import 'package:flutter/material.dart';
import 'package:ocad/src/auth/ui/widget/cuistom_text_field.dart';
import 'package:ocad/src/auth/ui/widget/custom_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final Color _focusedBorderColor = const Color(0xff9e723d);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  "Dive into the world of product and find the best one for you",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    "Welcome back! Please enter your details.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Email address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  validator: (String? value) {
                    if (passwordController.text.isEmpty) {
                      return "email is required";
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},

                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CustomTextField(
                  controller: passwordController,
                  validator: (String? value) {
                    if (passwordController.text.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  fillcolor: Colors.white,
                  hoverColor: Colors.white,
                  enabledBorderColor: Colors.blueGrey.shade600,
                  filled: true,

                  obscureText: true,
                  focusedBorderColor: _focusedBorderColor,
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.visibility_off_outlined, size: 22),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      activeColor: Color(0xff9e733e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blueGrey.shade700,
                          width: 0.8,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
