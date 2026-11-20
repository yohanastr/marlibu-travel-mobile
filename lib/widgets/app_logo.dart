import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double? height;
  final String assetPath;
  final BoxFit fit;

  const AppLogo({
    super.key,
    this.width = 180,
    this.height,
    this.assetPath = 'assets/images/logo.png',
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,

      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height ?? 100,
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 35,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}