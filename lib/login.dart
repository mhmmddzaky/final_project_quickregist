import 'package:final_project_quickregist/admin.dart';
import 'package:final_project_quickregist/halaman_penyelenggara.dart';
import 'package:final_project_quickregist/infoLomba.dart';
import 'package:flutter/material.dart';
import 'register_peserta.dart';
import 'register_penyelenggara.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'admin';

  void _clearFields() {
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _selectedUserType = 'admin';
    });
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String userType = _selectedUserType;

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Semua field harus diisi'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    String role;
    switch (userType) {
      case 'peserta':
        role = 'Peserta';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoLombaPage()),
        );
        break;
      case 'penyelenggara':
        role = 'Penyelenggara';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PagePenyelenggara()),
        );
        break;
      case 'admin':
        role = 'Admin';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPanel()),
        );
        break;
      default:
        role = 'Peserta';

        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Info'),
        content: Text('Username: $username\nPassword: $password\nRole: $role'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _clearFields();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToRegister() {
    if (_selectedUserType == 'peserta') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPeserta()),
      ).then((value) => _clearFields());
    } else if (_selectedUserType == 'penyelenggara') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPenyelenggara()),
      ).then((value) => _clearFields());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 40),
            Center(
              child: Text(
                'QuickRegist',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              items: [
                DropdownMenuItem(value: 'admin', child: Text('Admin')),
                DropdownMenuItem(value: 'peserta', child: Text('Peserta')),
                DropdownMenuItem(
                    value: 'penyelenggara', child: Text('Penyelenggara')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedUserType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'User Type'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: _navigateToRegister,
              child: Text('Belum punya akun? Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
