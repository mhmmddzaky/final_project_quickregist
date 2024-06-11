import 'package:flutter/material.dart';
import '../models/pendaftaran.dart';

class PendaftaranItem extends StatelessWidget {
  final Pendaftaran pendaftaran;
  final Function(String, String) onStatusChange;

  PendaftaranItem({
    required this.pendaftaran,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(pendaftaran.namaPeserta,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email : ${pendaftaran.email}'),
                Text('Lomba : ${pendaftaran.namaLomba}'),
                Text('Penyelenggara : ${pendaftaran.penyelenggara}'),
                Text('Waktu : ${pendaftaran.waktu}'),
                Text('No. Rekening : ${pendaftaran.noRekening}'),
                Text('Biaya : ${pendaftaran.biaya}'),
                Text('Link Pembayaran : ${pendaftaran.linkPembayaran}'),
                Text('Status : ${pendaftaran.status}',
                    style: TextStyle(
                        color: pendaftaran.status == 'Menunggu ACC'
                            ? Colors.red
                            : Colors.green)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      onStatusChange(pendaftaran.idPeserta, 'Diterima'),
                  child: Text('Terima'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () =>
                      onStatusChange(pendaftaran.idPeserta, 'Ditolak'),
                  child: Text('Tolak'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
