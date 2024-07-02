import 'dart:convert';
import 'package:final_project_quickregist/detaillomba.dart';
import 'package:final_project_quickregist/infolomba.dart';
import 'package:final_project_quickregist/konstanta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'register.dart';
import 'tambahlomba.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isNotEmpty && password.isNotEmpty) {
      final responsePengguna = await http.get(Uri.parse(baseUrl + "/pengguna"));
      final responseAdmin = await http.get(Uri.parse(baseUrl + "/admin"));

      if (responsePengguna.statusCode == 200 &&
          responseAdmin.statusCode == 200) {
        final List<dynamic> users = jsonDecode(responsePengguna.body);
        final List<dynamic> admins = jsonDecode(responseAdmin.body);

        final user = users.firstWhere(
          (user) =>
              user['username'] == username && user['password'] == password,
          orElse: () => null,
        );

        final admin = admins.firstWhere(
          (admin) =>
              admin['username'] == username && admin['password'] == password,
          orElse: () => null,
        );

        if (user != null || admin != null) {
          _usernameController.clear();
          _passwordController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login berhasil!'),
              duration: Duration(seconds: 2),
            ),
          );

          if (username.startsWith('PS')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoLombaPage()),
            );
          } else if (username.startsWith('PN')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TambahLombaPage()),
            );
          } else if (username.startsWith('AD')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailLombaPage()),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Username atau password salah!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal terhubung ke server!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username dan password wajib diisi!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              'QuickRegist App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      width: 2.0,
                      color: Colors.black,
                    ),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: _navigateToRegister,
              child: Text(
                'Belum punya akun? Daftar akun di sini!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
