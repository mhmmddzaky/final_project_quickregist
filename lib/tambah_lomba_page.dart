import 'package:flutter/material.dart';
import 'package:tes/penyelenggara/LombaModel.dart';

class TambahLombaPage extends StatefulWidget {
  final Function(Lomba) addLomba;

  TambahLombaPage({required this.addLomba});

  @override
  _TambahLombaPageState createState() => _TambahLombaPageState();
}

class _TambahLombaPageState extends State<TambahLombaPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaLombaController = TextEditingController();
  final _penyelenggaraController = TextEditingController();
  final _waktuLombaController = TextEditingController();
  final _noRekeningController = TextEditingController();
  final _biayaLombaController = TextEditingController();

  @override
  void dispose() {
    _namaLombaController.dispose();
    _penyelenggaraController.dispose();
    _waktuLombaController.dispose();
    _noRekeningController.dispose();
    _biayaLombaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final lomba = Lomba(
        nama: _namaLombaController.text,
        penyelenggara: _penyelenggaraController.text,
        waktu: _waktuLombaController.text,
        noRekening: _noRekeningController.text,
        biaya: _biayaLombaController.text,
      );

      widget.addLomba(lomba);

      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lomba berhasil ditambahkan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _namaLombaController,
              decoration: InputDecoration(labelText: 'Nama Lomba'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Lomba harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _penyelenggaraController,
              decoration: InputDecoration(labelText: 'Penyelenggara'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Penyelenggara harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _waktuLombaController,
              decoration: InputDecoration(labelText: 'Waktu Lomba'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Waktu Lomba harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _noRekeningController,
              decoration: InputDecoration(labelText: 'No Rekening'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No Rekening harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _biayaLombaController,
              decoration: InputDecoration(labelText: 'Biaya Lomba'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Biaya Lomba harus diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Tambah Lomba'),
            ),
          ],
        ),
      ),
    );
  }
}
