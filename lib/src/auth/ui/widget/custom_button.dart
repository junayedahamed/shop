import 'package:flutter/material.dart';

enum CustomButtonVariant { primary, warning, outline, noBorder }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.child,
    this.padding,
    this.borderRadius,
    this.variant = CustomButtonVariant.primary,
    this.color,
    this.outlineColor,
    this.height,
    this.width,
  });

  final VoidCallback onPress;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final double? borderRadius;
  final CustomButtonVariant variant;
  final Color? color;
  final Color? outlineColor;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color buttonColor;
    Color? borderClr;
    // Color? textColor;
    double borderWidth = 2.0;

    switch (variant) {
      case CustomButtonVariant.primary:
        buttonColor = color ?? theme.colorScheme.secondary;
        borderClr = null;
        // textColor = theme.colorScheme.onSecondary;
        break;
      case CustomButtonVariant.warning:
        buttonColor = color ?? Colors.orange;
        borderClr = null;
        // textColor = Colors.white;
        break;
      case CustomButtonVariant.noBorder:
        buttonColor = color ?? theme.colorScheme.primary;
        borderClr = null;
        borderWidth = 0.0;
      case CustomButtonVariant.outline:
        buttonColor = Colors.transparent;
        borderClr = outlineColor ?? theme.colorScheme.primary;
        // textColor = outlineColor ?? theme.colorScheme.primary;
        break;
    }

    Widget content = child;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        child: InkWell(
          onTap: onPress,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          child: Ink(
            height: height ?? 40,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              border: borderClr != null
                  ? Border.all(color: borderClr, width: borderWidth)
                  : null,
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
