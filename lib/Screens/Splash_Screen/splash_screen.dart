import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_notebook_app/Screens/Auth/Login/Login_Screen.dart';
import 'package:flutter/material.dart';
import '../Connectivity  Error/connectivity_error_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        List<ConnectivityResult> result,
        ) {
      if (result.contains(ConnectivityResult.mobile)) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        );
      } else if (result.contains(ConnectivityResult.wifi)) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          ),
        );
      } else {
        Timer(
          Duration(seconds: 3),
              () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ConnectivityErrorScreen()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo1.png'),
      ),
    );
  }
}
