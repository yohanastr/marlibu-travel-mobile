
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _carController;

  @override
  void initState() {
    super.initState();

    _carController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _carController.forward().then((_) {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/register');
    });
  }

  @override
  void dispose() {
    _carController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            final logoWidth = screenWidth * 0.54;
            final logoHeight = screenHeight * 0.16;

            final buttonWidth = screenWidth * 0.67;

            const buttonHeight = 39.0;
            const carWidth = 75.0;
            const carHeight = 70.0;

            final carStart = -20.0;
            final carEnd = buttonWidth - carWidth + 5;

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                // LOGO MARLIBU
                Positioned(
                  top: screenHeight * 0.345,
                  child: Image.asset(
                    'assets/images/marlibu_logo.png',
                    width: logoWidth,
                    height: logoHeight,
                    fit: BoxFit.contain,
                  ),
                ),

                // TOMBOL MULAI SEKARANG
                Positioned(
                  top: screenHeight * 0.704,
                  child: SizedBox(
                    width: buttonWidth,
                    height: 80,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // BACKGROUND TOMBOL
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Material(
                            color: const Color(0xFFFF914D),
                            elevation: 4,
                            borderRadius: BorderRadius.circular(13),
                            child: const SizedBox(
                              height: buttonHeight,
                              child: Center(
                                child: Text(
                                  'Mulai Sekarang',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ANIMASI MOBIL
                        AnimatedBuilder(
                          animation: _carController,
                          builder: (context, child) {
                            final position = carStart +
                                (carEnd - carStart) *
                                    Curves.easeInOut.transform(
                                      _carController.value,
                                    );

                            return Positioned(
                              left: position,
                              top: -27,
                              child: child!,
                            );
                          },
                          child: Image.asset(
                            'assets/images/car.png',
                            width: carWidth,
                            height: carHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
