import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 10), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6D9FF),
              Color(0xFFD6C2FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // 🟣 PERFECT CIRCLE LOGO FIX
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),

                child: ClipOval(
                  child: SizedBox.expand(
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      fit: BoxFit.cover, // 🔥 fills full circle perfectly
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Remed Aura",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Quality you can trust 🌿",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF7E57C2),
                ),
              ),

              const SizedBox(height: 35),

              const CircularProgressIndicator(
                color: Color(0xFFB39DDB),
              ),
            ],
          ),
        ),
      ),
    );
  }
}