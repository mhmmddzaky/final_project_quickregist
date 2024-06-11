import 'package:final_project_quickregist/Lomba_Model.dart';
import 'package:flutter/material.dart';

class LombaItem extends StatelessWidget {
  final Lomba lomba;
  final Function(String, String) onStatusChange;

  LombaItem({
    required this.lomba,
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
            title:
                Text(lomba.nama, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Penyelenggara: ${lomba.penyelenggara}'),
                Text('Waktu: ${lomba.waktu}'),
                Text('No. Rekening: ${lomba.noRekening}'),
                Text('Biaya: ${lomba.biaya}'),
                Text('Link Pembayaran : ${lomba.linkPembayaran}'),
                Text('Status: ${lomba.status}',
                    style: TextStyle(
                        color: lomba.status == 'Menunggu ACC'
                            ? Colors.red
                            : Colors.green)),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => onStatusChange(lomba.id, 'Diterima'),
                  child: Text('Terima'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => onStatusChange(lomba.id, 'Ditolak'),
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
