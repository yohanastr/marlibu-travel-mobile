import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.backgroundColor = AppColors.cardBackground,
    this.borderRadius = 20,
    this.elevation = 3,
    this.margin,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,

      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius:
            BorderRadius.circular(borderRadius),

        border: border,

        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: elevation * 3,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),

      child: child,
    );
  }
}