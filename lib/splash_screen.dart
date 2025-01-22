import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'super_admin.dart';
import 'admin_instansi.dart';
import 'login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _checkLoginStatus(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'images/Polines.png', // Gambar Polines.png
              // Atur lebar gambar Polines
              width: 240,
              height: 120, // Atur tinggi gambar Polines
            ),
          ),
        ],
      ),
    );
  }

  void _checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3)); // Simulasi waktu splash screen

    if (isLoggedIn) {
      String? idUser = prefs.getString('id_user');
      if (idUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePageSuperAdmin()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePageAdminInstansi()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }
}
