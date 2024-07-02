import 'package:final_project_quickregist/konstanta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiwayatPendaftaranPage extends StatefulWidget {
  @override
  _RiwayatPendaftaranPageState createState() => _RiwayatPendaftaranPageState();
}

class _RiwayatPendaftaranPageState extends State<RiwayatPendaftaranPage> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    // String apiUrl = 'http://localhost/PendaftaranLomba/public/pendaftaranlomba';

    try {
      var response = await http.get(Uri.parse(baseUrl + "/pendaftaranlomba"));
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
          'Riwayat Pendaftaran Lomba',
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
                    '${data[index]['nama_peserta']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Lomba: ${data[index]['nama_lomba']}'),
                      Text('Kategori Lomba: ${data[index]['kategori_lomba']}'),
                      Text(
                          'Tanggal Pelaksanaan: ${data[index]['tanggal_pelaksanaan']}'),
                      Text(
                          'Jam Pelaksanaan: ${data[index]['jam_pelaksanaan']}'),
                      Text('Email Peserta: ${data[index]['email_peserta']}'),
                      Text(
                          'Status Pendaftaran: ${data[index]['status_pendaftaran']}'),
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
