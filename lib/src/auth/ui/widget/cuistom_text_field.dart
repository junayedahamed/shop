import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.borderRadius,
    this.hintText,
    this.controller,
    this.enable,
    this.validator,
    this.onChanged,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.textInputAction,
    this.keyboardType,
    this.fillcolor,
    this.focusedBorderColor,
    this.disabledBorderColor,
    this.enabledBorderColor,
    this.borderColor,
    this.errorBorderColor,
    this.filled,
    this.hoverColor,
    this.obscureText,
  });
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final Color? fillcolor;
  final Widget? suffixIcon, prefixIcon;
  final int? maxLines, minLines;
  final String? hintText;
  final TextEditingController? controller;
  final bool? enable, filled, obscureText;
  final Color? focusedBorderColor,
      disabledBorderColor,
      enabledBorderColor,
      borderColor,
      errorBorderColor,
      hoverColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      expands: false,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.done,
      enabled: enable ?? true,

      decoration: InputDecoration(
        hoverColor: hoverColor,
        suffixIcon: suffixIcon,
        fillColor: fillcolor,
        filled: filled,

        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        enabled: enable ?? true,

        // hint: Text(hintText ?? ""),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(color: errorBorderColor ?? Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(
            color: enabledBorderColor ?? Colors.grey.shade300,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(
            color: disabledBorderColor ?? Colors.green.shade100,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(color: borderColor ?? Colors.blue.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(color: focusedBorderColor ?? Colors.blueGrey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          borderSide: BorderSide(color: errorBorderColor ?? Colors.red),
        ),
      ),
    );
  }
}
