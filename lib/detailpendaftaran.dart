import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tes_lagi/konstanta.dart';

class DetailPendaftaranPage extends StatefulWidget {
  @override
  _DetailPendaftaranPageState createState() => _DetailPendaftaranPageState();
}

class _DetailPendaftaranPageState extends State<DetailPendaftaranPage> {
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
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> updateStatusPendaftaran(
      String idPendaftaran, String newStatus) async {
    // String apiUrl =
    //     'http://localhost/PendaftaranLomba/public/pendaftaranlomba/$idPendaftaran';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = json.encode({"status_pendaftaran": newStatus});

    try {
      var response = await http.put(
          Uri.parse(baseUrl + "/pendaftaranlomba/$idPendaftaran"),
          headers: headers,
          body: jsonBody);
      if (response.statusCode == 200) {
        fetchData();
      } else {
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> hapusData(String idPendaftaran) async {
    // String apiUrl =
    //     'http://localhost/PendaftaranLomba/public/pendaftaranlomba/$idPendaftaran';

    try {
      var response = await http
          .delete(Uri.parse(baseUrl + "/pendaftaranlomba/$idPendaftaran"));
      if (response.statusCode == 200) {
        fetchData();
      } else {
        print('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting data: $e');
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
          'Detail Pendaftaran',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      title: Text(
                        '${data[index]['nama_peserta']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'ID Pendaftaran: ${data[index]['id_pendaftaran']}'),
                          Text('ID Lomba: ${data[index]['id_lomba']}'),
                          Text('Nama Lomba: ${data[index]['nama_lomba']}'),
                          Text(
                              'Kategori Lomba: ${data[index]['kategori_lomba']}'),
                          Text(
                              'Email Peserta: ${data[index]['email_peserta']}'),
                          Text(
                              'Bukti Pembayaran: ${data[index]['bukti_pembayaran']}'),
                          Text(
                              'Status Pendaftaran: ${data[index]['status_pendaftaran']}'),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            updateStatusPendaftaran(
                                data[index]['id_lomba'].toString(), 'Diterima');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            updateStatusPendaftaran(
                                data[index]['id_lomba'].toString(), 'Ditolak');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Hapus Data'),
                                  content: Text(
                                      'Anda yakin ingin menghapus pendaftaran ini?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Batal'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Hapus'),
                                      onPressed: () {
                                        hapusData(data[index]['id_pendaftaran']
                                            .toString());
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
