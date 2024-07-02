import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tes_lagi/konstanta.dart';
import 'package:tes_lagi/login.dart';
import 'package:tes_lagi/riwayatlomba.dart';

class TambahLombaPage extends StatefulWidget {
  @override
  _TambahLombaPageState createState() => _TambahLombaPageState();
}

class _TambahLombaPageState extends State<TambahLombaPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _namaLombaController = TextEditingController();
  TextEditingController _namaPenyelenggaraController = TextEditingController();
  TextEditingController _emailPenyelenggaraController = TextEditingController();
  TextEditingController _tanggalPelaksanaanController = TextEditingController();
  TextEditingController _jamPelaksanaanController = TextEditingController();
  TextEditingController _noRekeningController = TextEditingController();
  TextEditingController _biayaLombaController = TextEditingController();

  List<String> _categories = [];
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    var url = Uri.parse(baseUrl + "/kategorilomba");

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<String> categories = [];

        for (var item in jsonData) {
          categories.add(item['kategori_lomba']);
        }

        setState(() {
          _categories = categories;
        });
      } else {
        print('Failed to load categories. Status code: ${response.statusCode}');
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var data = {
      'nama_lomba': _namaLombaController.text,
      'kategori_lomba': _selectedCategory,
      'nama_penyelenggara': _namaPenyelenggaraController.text,
      'email_penyelenggara': _emailPenyelenggaraController.text,
      'tanggal_pelaksanaan': _tanggalPelaksanaanController.text,
      'jam_pelaksanaan': _jamPelaksanaanController.text,
      'no_rekening': _noRekeningController.text,
      'biaya_lomba': _biayaLombaController.text,
    };

    var url = Uri.parse('http://localhost/PendaftaranLomba/public/lomba');

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        _showSnackBar('Lomba berhasil ditambahkan');
        _namaLombaController.clear();
        _namaPenyelenggaraController.clear();
        _emailPenyelenggaraController.clear();
        _tanggalPelaksanaanController.clear();
        _jamPelaksanaanController.clear();
        _noRekeningController.clear();
        _biayaLombaController.clear();

        setState(() {
          _selectedCategory = '';
        });
      } else {
        print('Lomba berhasil ditambahkan');
        _showSnackBar('Lomba berhasil ditambahkan');
        _namaLombaController.clear();
        _namaPenyelenggaraController.clear();
        _emailPenyelenggaraController.clear();
        _tanggalPelaksanaanController.clear();
        _jamPelaksanaanController.clear();
        _noRekeningController.clear();
        _biayaLombaController.clear();
        _selectedCategory = '';
      }
    } catch (e) {
      print('Error: $e');
      _showSnackBar('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Lomba'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaLombaController,
                decoration: InputDecoration(
                  labelText: 'Nama Lomba',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Lomba harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Kategori Lomba',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori Lomba harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _namaPenyelenggaraController,
                decoration: InputDecoration(
                  labelText: 'Nama Penyelenggara',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Penyelenggara harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailPenyelenggaraController,
                decoration: InputDecoration(
                  labelText: 'Email Penyelenggara',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Penyelenggara harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _tanggalPelaksanaanController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Pelaksanaan',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Pelaksanaan harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _jamPelaksanaanController,
                decoration: InputDecoration(
                  labelText: 'Jam Pelaksanaan',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jam Pelaksanaan harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _noRekeningController,
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Rekening harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _biayaLombaController,
                decoration: InputDecoration(
                  labelText: 'Biaya Lomba',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Biaya Lomba harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tambah Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Riwayat Lomba',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RiwayatLombaPage()),
            );
          }
        },
      ),
    );
  }
}
