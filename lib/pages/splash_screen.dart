import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_routing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for logo scaling
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOutBack,
    );

    _logoController.forward();

    // Navigate to login after short delay
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1), // Samba blue background
      body: Stack(
        children: [
          // Animated gradient background
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Centered animation content
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // InfoTech logo
                  Image.asset(
                    'assets/images/intotech_logo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  // Divider dot or line
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Samba logo
                  Image.asset(
                    'assets/images/sambaa.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Powered by InfoTech (Pvt) Ltd.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom fade-in text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _scaleAnimation,
              child: const Text(
                'Connecting Innovation & Banking',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
