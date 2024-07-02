import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tes_lagi/konstanta.dart';
import 'package:tes_lagi/login.dart';
import 'package:tes_lagi/pendaftaranhome.dart';
import 'package:tes_lagi/riwayatpendaftaran.dart';

class InfoLombaPage extends StatefulWidget {
  @override
  _InfoLombaPageState createState() => _InfoLombaPageState();
}

class _InfoLombaPageState extends State<InfoLombaPage> {
  List<Map<String, dynamic>> lombaDatabase = [];

  @override
  void initState() {
    super.initState();
    fetchLombaData();
  }

  Future<void> fetchLombaData() async {
    final response = await http.get(Uri.parse(baseUrl + "/lomba"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        lombaDatabase =
            data.map((item) => item as Map<String, dynamic>).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Lomba'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: lombaDatabase.length,
                itemBuilder: (context, index) {
                  final lomba = lombaDatabase[index];

                  if (lomba['status_lomba'] != 'Diterima') {
                    return SizedBox.shrink();
                  }
                  return Card(
                    color: Colors.lightBlue[50],
                    margin: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(
                        lomba['nama_lomba']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID Lomba: ${lomba['id_lomba']}'),
                          Text('Nama Lomba: ${lomba['nama_lomba']}'),
                          Text('Kategori Lomba: ${lomba['kategori_lomba']}'),
                          Text(
                              'Nama Penyelenggara: ${lomba['nama_penyelenggara']}'),
                          Text(
                              'Email Penyelenggara: ${lomba['email_penyelenggara']}'),
                          Text(
                              'Tanggal Pelaksanaan: ${lomba['tanggal_pelaksanaan']}'),
                          Text('Jam Pelaksanaan: ${lomba['jam_pelaksanaan']}'),
                          Text('Nomor Rekening: ${lomba['no_rekening']}'),
                          Text('Biaya Lomba: ${lomba['biaya_lomba']}'),
                          Text('Status Lomba: ${lomba['status_lomba']}'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PendaftaranPage(
                              lombaData: lomba,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Daftar Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Riwayat Pendaftaran',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiwayatPendaftaranPage()),
            );
          }
        },
      ),
    );
  }
}
