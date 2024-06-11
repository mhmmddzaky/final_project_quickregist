import 'package:flutter/material.dart';
import 'pendaftaranhome.dart';

class InfoLombaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Peserta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'QuickRegist',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Informasi Lomba',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildLombaCard(
                    'Lomba Coding Flutter',
                    '25 Juni 2024',
                    'Rp 100.000',
                    'Lomba ini terbuka untuk semua kalangan yang ingin mengasah kemampuan coding mereka dalam menggunakan Flutter.',
                  ),
                  const SizedBox(height: 10),
                  _buildLombaCard(
                    'Lomba Menulis',
                    '30 Juni 2024',
                    'Rp 50.000',
                    'Lomba menulis cerita pendek dengan tema bebas.',
                  ),
                  const SizedBox(height: 10),
                  _buildLombaCard(
                    'Lomba Desain Grafis',
                    '10 Juli 2024',
                    'Rp 75.000',
                    'Lomba desain grafis tingkat nasional bertemakan kemerdekaan Indonesia.',
                  ),
                  const SizedBox(height: 10),
                  _buildLombaCard(
                    'Lomba Matematika',
                    '5 Juli 2024',
                    'Rp 75.000',
                    'Lomba matematika untuk siswa SD dan SMP dengan berbagai tingkat kesulitan.',
                  ),
                  const SizedBox(height: 10),
                  _buildLombaCard(
                    'Lomba Matematika',
                    '5 Juli 2024',
                    'Rp 75.000',
                    'Lomba matematika untuk siswa SD dan SMP dengan berbagai tingkat kesulitan.',
                  ),
                ],
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
            label: 'Info Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Daftar Lomba',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PendaftaranPage(
                        username: '',
                        nama: '',
                        email: '',
                      )),
            );
          }
        },
      ),
    );
  }

  Widget _buildLombaCard(
      String nama, String tanggal, String biaya, String deskripsi) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          'Nama Lomba: $nama',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Tanggal: $tanggal',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Biaya: $biaya',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Deskripsi: $deskripsi',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
