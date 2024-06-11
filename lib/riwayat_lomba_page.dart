import 'package:flutter/material.dart';
import 'package:tes/penyelenggara/LombaModel.dart';

class RiwayatLombaPage extends StatelessWidget {
  final List<Lomba> lombaList;

  RiwayatLombaPage({required this.lombaList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lombaList.length,
      itemBuilder: (context, index) {
        final lomba = lombaList[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          elevation: 5,
          child: ListTile(
            title:
                Text(lomba.nama, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Lomba: ${lomba.nama}'),
                Text('Penyelenggara: ${lomba.penyelenggara}'),
                Text('Waktu: ${lomba.waktu}'),
                Text('No Rekening: ${lomba.noRekening}'),
                Text('Biaya: ${lomba.biaya}'),
                Text('Status: ${lomba.status}',
                    style: TextStyle(
                        color: lomba.status == 'Menunggu ACC'
                            ? Colors.red
                            : Colors.green)),
              ],
            ),
          ),
        );
      },
    );
  }
}
