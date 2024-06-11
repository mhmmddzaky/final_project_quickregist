import 'package:final_project_quickregist/Lomba_Model.dart';
import 'package:final_project_quickregist/lomba_item.dart';
import 'package:flutter/material.dart';

class DataLombaPage extends StatefulWidget {
  @override
  _DataLombaPageState createState() => _DataLombaPageState();
}

class _DataLombaPageState extends State<DataLombaPage> {
  List<Lomba> lombaList = [
    Lomba(
      id: '1',
      nama: 'Lomba Live Coding',
      penyelenggara: 'Amikom Purwokerto',
      waktu: DateTime.now(),
      noRekening: '1234567890',
      biaya: 50000,
      linkPembayaran: '.com',
    ),
    Lomba(
      id: '2',
      nama: 'Lomba Desain Grafis',
      penyelenggara: 'Rifqy Willy',
      waktu: DateTime.now(),
      noRekening: '0987654321',
      biaya: 100000,
      linkPembayaran: '.com',
    ),
    Lomba(
      id: '3',
      nama: 'Lomba Poster',
      penyelenggara: 'Poster Indonesia',
      waktu: DateTime.now(),
      noRekening: '0987651234',
      biaya: 30000,
      linkPembayaran: '.com',
    ),
  ];

  void _updateStatus(String id, String status) {
    setState(() {
      lombaList = lombaList.map((lomba) {
        if (lomba.id == id) {
          return Lomba(
            id: lomba.id,
            nama: lomba.nama,
            penyelenggara: lomba.penyelenggara,
            waktu: lomba.waktu,
            noRekening: lomba.noRekening,
            biaya: lomba.biaya,
            linkPembayaran: lomba.linkPembayaran,
            status: status,
          );
        }
        return lomba;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lombaList.length,
      itemBuilder: (context, index) {
        return LombaItem(
          lomba: lombaList[index],
          onStatusChange: _updateStatus,
        );
      },
    );
  }
}
