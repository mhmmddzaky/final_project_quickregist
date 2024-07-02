import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tes_lagi/detailpendaftaran.dart';
import 'package:tes_lagi/konstanta.dart';
import 'package:tes_lagi/login.dart';

class DetailLombaPage extends StatefulWidget {
  @override
  _DetailLombaPageState createState() => _DetailLombaPageState();
}

class _DetailLombaPageState extends State<DetailLombaPage> {
  List<dynamic> data = [];

  Future<void> fetchData() async {
    // String apiUrl = 'http://localhost/PendaftaranLomba/public/lomba';

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

  Future<void> deleteData(String idLomba) async {
    // String apiUrl = 'http://localhost/PendaftaranLomba/public/lomba/$idLomba';

    try {
      var response = await http.delete(Uri.parse(baseUrl + "/lomba/$idLomba"));
      if (response.statusCode == 200) {
        fetchData();
      } else {
        print('Failed to delete data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateStatus(String idLomba, String newStatus) async {
    // String apiUrl = 'http://localhost/PendaftaranLomba/public/lomba/$idLomba';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = json.encode({"status_lomba": newStatus});

    try {
      var response = await http.put(Uri.parse(baseUrl + "/lomba/$idLomba"),
          headers: headers, body: jsonBody);
      if (response.statusCode == 200) {
        fetchData();
      } else {
        print('Failed to update status');
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
        title: Text('Detail Lomba'),
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
                        '${data[index]['nama_lomba']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID Lomba: ${data[index]['id_lomba']}'),
                          Text(
                              'Kategori Lomba: ${data[index]['kategori_lomba']}'),
                          Text(
                              'Nama Penyelanggara: ${data[index]['nama_penyelenggara']}'),
                          Text(
                              'Email Penyelenggara: ${data[index]['email_penyelenggara']}'),
                          Text(
                              'Tanggal Pelaksanaan: ${data[index]['tanggal_pelaksanaan']}'),
                          Text(
                              'Jam Pelaksanaan: ${data[index]['jam_pelaksanaan']}'),
                          Text('Nomor Rekening: ${data[index]['no_rekening']}'),
                          Text('Biaya Lomba: ${data[index]['biaya_lomba']}'),
                          Text('Status Lomba: ${data[index]['status_lomba']}'),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            updateStatus(
                                data[index]['id_lomba'].toString(), 'Diterima');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            updateStatus(
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
                                      'Anda yakin ingin menghapus lomba ini?'),
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
                                        deleteData(
                                            data[index]['id_lomba'].toString());
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Detail Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Detail Pendaftaran',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPendaftaranPage()),
            );
          }
        },
      ),
    );
  }
}
