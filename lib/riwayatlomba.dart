import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tes_lagi/konstanta.dart';
import 'dart:convert';
import 'package:tes_lagi/tambahlomba.dart';

class RiwayatLombaPage extends StatefulWidget {
  @override
  _RiwayatLombaPageState createState() => _RiwayatLombaPageState();
}

class _RiwayatLombaPageState extends State<RiwayatLombaPage> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(baseUrl + "/lomba"));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Lomba',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TambahLombaPage()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  title: Text(
                    '${data[index]['nama_lomba']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID Lomba: ${data[index]['id_lomba']}'),
                      Text('Kategori Lomba: ${data[index]['kategori_lomba']}'),
                      Text(
                          'Nama Penyelenggara: ${data[index]['nama_penyelenggara']}'),
                      Text(
                          'Email Penyelenggara: ${data[index]['email_penyelenggara']}'),
                      Text(
                          'Tanggal Pelaksanaan: ${data[index]['tanggal_pelaksanaan']}'),
                      Text(
                          'Jam Pelaksanaan: ${data[index]['jam_pelaksanaan']}'),
                      Text('Biaya Lomba: ${data[index]['biaya_lomba']}'),
                      Text('Status Lomba: ${data[index]['status_lomba']}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
