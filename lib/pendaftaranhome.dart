import 'package:final_project_quickregist/infoLomba.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pendaftaran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PendaftaranPage(
        username: 'contoh_username',
        nama: 'Contoh Nama',
        email: 'contoh@example.com',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PendaftaranPage extends StatefulWidget {
  final String username;
  final String nama;
  final String email;

  PendaftaranPage({
    required this.username,
    required this.nama,
    required this.email,
  });

  @override
  _PendaftaranPageState createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final TextEditingController _namaLombaController = TextEditingController();
  final TextEditingController _waktuLombaController = TextEditingController();
  final TextEditingController _biayaLombaController = TextEditingController();
  final TextEditingController _buktiBayarController = TextEditingController();
  String? _selectedKategori;

  final Map<String, Map<String, String>> _kategoriDetails = {
    'Voli': {
      'nama': 'Lomba Voli',
      'waktu': '10:00 - 12:00',
      'biaya': 'Rp 100.000',
    },
    'Menulis': {
      'nama': 'Lomba Menulis',
      'waktu': '13:00 - 15:00',
      'biaya': 'Rp 50.000',
    },
    'Matematika': {
      'nama': 'Lomba Matematika',
      'waktu': '16:00 - 18:00',
      'biaya': 'Rp 75.000',
    },
  };

  void _onKategoriChanged(String? newValue) {
    setState(() {
      _selectedKategori = newValue;
      if (newValue != null) {
        _namaLombaController.text = _kategoriDetails[newValue]!['nama']!;
        _waktuLombaController.text = _kategoriDetails[newValue]!['waktu']!;
        _biayaLombaController.text = _kategoriDetails[newValue]!['biaya']!;
      }
    });
  }

  void _simpanData() {
    String username = widget.username;
    String nama = widget.nama;
    String email = widget.email;
    String kategori = _selectedKategori ?? '';
    String namaLomba = _namaLombaController.text;
    String waktuLomba = _waktuLombaController.text;
    String biayaLomba = _biayaLombaController.text;
    String buktiBayar = _buktiBayarController.text;

    print('Username: $username');
    print('Nama: $nama');
    print('Email: $email');
    print('Kategori: $kategori');
    print('Nama Lomba: $namaLomba');
    print('Waktu Lomba: $waktuLomba');
    print('Biaya Lomba: $biayaLomba');
    print('Bukti Bayar: $buktiBayar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Peserta'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  'QuickRegist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Pendaftaran Lomba',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(labelText: 'Username'),
                controller: TextEditingController(text: widget.username),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(labelText: 'Nama'),
                controller: TextEditingController(text: widget.nama),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(labelText: 'Email'),
                controller: TextEditingController(text: widget.email),
              ),
              DropdownButtonFormField<String>(
                value: _selectedKategori,
                decoration: InputDecoration(labelText: 'Pilih Kategori Lomba'),
                items: _kategoriDetails.keys
                    .map((kategori) => DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        ))
                    .toList(),
                onChanged: _onKategoriChanged,
              ),
              TextField(
                controller: _namaLombaController,
                decoration: InputDecoration(labelText: 'Nama Lomba'),
                readOnly: true,
              ),
              TextField(
                controller: _waktuLombaController,
                decoration: InputDecoration(labelText: 'Waktu Lomba'),
                readOnly: true,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _biayaLombaController,
                      decoration: InputDecoration(labelText: 'Biaya Lomba'),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _buktiBayarController,
                  decoration: InputDecoration(
                    labelText: 'Link Bukti Pembayaran',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _simpanData,
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Daftar Lomba',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoLombaPage()),
            );
          }
        },
      ),
    );
  }
}
