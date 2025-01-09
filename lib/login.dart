import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'super_admin.dart'; // Import halaman super admin
import 'admin_instansi.dart'; // Import halaman admin instansi

const String baseUrl = 'https://toucan-outgoing-moderately.ngrok-free.app/WICARA_FIX/Wicara_Admin_Web';
final superAdminLoginUrl = Uri.parse('$baseUrl/api/api_login.php');
final adminInstansiLoginUrl = Uri.parse('$baseUrl/api/api_login_instansi.php');

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password tidak boleh kosong')),
      );
      return;
    }

    // Coba login sebagai Super Admin
    final superAdminResponse = await http.post(
      superAdminLoginUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (superAdminResponse.statusCode == 200) {
      var superAdminData = json.decode(superAdminResponse.body);
      if (superAdminData['success']) {
        // Login berhasil sebagai Super Admin
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_user', superAdminData['id_user'].toString());
        await prefs.setString('email', superAdminData['email']);
        await prefs.setString('nama', superAdminData['nama']);
        await prefs.setString('profile', superAdminData['profile']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePageSuperAdmin()),
        );
        return;
      }
    }

    // Jika gagal, coba login sebagai Admin Instansi
    final adminInstansiResponse = await http.post(
      adminInstansiLoginUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (adminInstansiResponse.statusCode == 200) {
      var adminInstansiData = json.decode(adminInstansiResponse.body);
      if (adminInstansiData['success']) {
        // Login berhasil sebagai Admin Instansi
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_instansi', adminInstansiData['id_instansi'].toString());
        await prefs.setString('nama_instansi', adminInstansiData['nama_instansi']);
        await prefs.setString('email_pic', adminInstansiData['email_pic']);
        await prefs.setString('gambar_instansi', adminInstansiData['gambar_instansi']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePageAdminInstansi()),
        );
        return;
      }
    }

    // Jika kedua login gagal
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email atau password tidak sesuai')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 285,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                image: DecorationImage(
                  image: AssetImage('images/Login_Image.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 36,
                      width: 120,
                      margin: const EdgeInsets.only(top: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset("images/Polines.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Text(
                        'WICARA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'Wadah Informasi Catatan Aspirasi & Rating Akademik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Selamat Datang Di Platform Aspirasi Dan Rating Akademik',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 15),
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Center(
                    child: SizedBox(
                      width: 110,
                      child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.amber[600],
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Klik Disini',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.indigo,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
