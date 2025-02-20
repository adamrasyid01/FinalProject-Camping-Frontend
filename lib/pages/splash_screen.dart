import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  // FIX: IF GOING TO IMPLEMENT THE LOGIN

  // void checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  //   await Future.delayed(Duration(seconds: 3));

  //   if (isLoggedIn) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  //   } else {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()));
  //   }
  // }

  void navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
