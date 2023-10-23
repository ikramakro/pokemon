import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:assesmant_task/screen/auth/login_screen.dart';
import 'package:assesmant_task/screen/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isUserLoggedIn() {
    final currentUser = auth.currentUser;
    return currentUser != null;
  }

  @override
  void initState() {
    super.initState();
    if (isUserLoggedIn()) {
      Timer(const Duration(seconds: 3), () => Get.to(() => PokemonList()));
    } else {
      Timer(const Duration(seconds: 3), () => Get.to(() => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInDownBig(
        duration: const Duration(milliseconds: 1600),
        child: Center(
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
