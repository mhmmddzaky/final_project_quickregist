import 'package:final_project_quickregist/pendaftaranModel.dart';
import 'package:final_project_quickregist/pendaftaran_item.dart';
import 'package:flutter/material.dart';

class DataPendaftaranPage extends StatefulWidget {
  @override
  _DataPendaftaranPageState createState() => _DataPendaftaranPageState();
}

class _DataPendaftaranPageState extends State<DataPendaftaranPage> {
  List<Pendaftaran> pendaftaranList = [
    Pendaftaran(
      idPeserta: '1',
      namaPeserta: 'Angga',
      email: 'angga@gmail.com',
      idLomba: '1',
      namaLomba: 'Lomba Live Coding',
      penyelenggara: 'Amikom Purwokerto',
      waktu: DateTime.now(),
      noRekening: '1234567890',
      biaya: 50000,
      linkPembayaran: '.com',
    ),
    Pendaftaran(
      idPeserta: '2',
      namaPeserta: 'Willy',
      email: 'willy@gmail.com',
      idLomba: '2',
      namaLomba: 'Lomba Desain Grafis',
      penyelenggara: 'Rifqy Willy',
      waktu: DateTime.now(),
      noRekening: '0987654321',
      biaya: 100000,
      linkPembayaran: '.com',
    ),
    Pendaftaran(
      idPeserta: '3',
      namaPeserta: 'Dzaky',
      email: 'dzaky@gmail.com',
      idLomba: '2',
      namaLomba: 'Lomba Desain Grafis',
      penyelenggara: 'Rifqy Willy',
      waktu: DateTime.now(),
      noRekening: '0987654321',
      biaya: 100000,
      linkPembayaran: '.com',
    ),
    Pendaftaran(
      idPeserta: '4',
      namaPeserta: 'Restu',
      email: 'restu@gmail.com',
      idLomba: '3',
      namaLomba: 'Lomba Poster',
      penyelenggara: 'Poster Indonesia',
      waktu: DateTime.now(),
      noRekening: '0987651234',
      biaya: 30000,
      linkPembayaran: '.com',
    ),
    Pendaftaran(
      idPeserta: '5',
      namaPeserta: 'Nabil',
      email: 'nabil@gmail.com',
      idLomba: '3',
      namaLomba: 'Lomba Poster',
      penyelenggara: 'Poster Indonesia',
      waktu: DateTime.now(),
      noRekening: '0987651234',
      biaya: 30000,
      linkPembayaran: '.com',
    ),
  ];

  void _updateStatus(String id, String status) {
    setState(() {
      pendaftaranList = pendaftaranList.map((pendaftaran) {
        if (pendaftaran.idPeserta == id) {
          return Pendaftaran(
            idPeserta: pendaftaran.idPeserta,
            namaPeserta: pendaftaran.namaPeserta,
            email: pendaftaran.email,
            idLomba: pendaftaran.idLomba,
            namaLomba: pendaftaran.namaLomba,
            penyelenggara: pendaftaran.penyelenggara,
            waktu: pendaftaran.waktu,
            noRekening: pendaftaran.noRekening,
            biaya: pendaftaran.biaya,
            linkPembayaran: pendaftaran.linkPembayaran,
            status: status,
          );
        }
        return pendaftaran;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pendaftaranList.length,
      itemBuilder: (context, index) {
        return PendaftaranItem(
          pendaftaran: pendaftaranList[index],
          onStatusChange: _updateStatus,
        );
      },
    );
  }
}
