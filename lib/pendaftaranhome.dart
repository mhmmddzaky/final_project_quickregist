import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tes_lagi/konstanta.dart';

class PendaftaranPage extends StatefulWidget {
  final Map<String, dynamic> lombaData;

  PendaftaranPage({required this.lombaData});

  @override
  _PendaftaranPageState createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();
  final idLombaController = TextEditingController();
  final namaPenyelenggaraController = TextEditingController();
  final emailPenyelenggaraController = TextEditingController();
  final namaLombaController = TextEditingController();
  final kategoriLombaController = TextEditingController();
  final tanggalPelaksanaanController = TextEditingController();
  final jamPelaksanaanController = TextEditingController();
  final noRekeningController = TextEditingController();
  final biayaLombaController = TextEditingController();
  final namaPesertaController = TextEditingController();
  final emailPesertaController = TextEditingController();
  final buktiPembayaranController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idLombaController.text = widget.lombaData['id_lomba']?.toString() ?? '';
    namaPenyelenggaraController.text =
        widget.lombaData['nama_penyelenggara'] ?? '';
    emailPenyelenggaraController.text =
        widget.lombaData['email_penyelenggara'] ?? '';
    namaLombaController.text = widget.lombaData['nama_lomba'] ?? '';
    kategoriLombaController.text = widget.lombaData['kategori_lomba'] ?? '';
    tanggalPelaksanaanController.text =
        widget.lombaData['tanggal_pelaksanaan'] ?? '';
    jamPelaksanaanController.text = widget.lombaData['jam_pelaksanaan'] ?? '';
    noRekeningController.text =
        widget.lombaData['no_rekening']?.toString() ?? '';
    biayaLombaController.text =
        widget.lombaData['biaya_lomba']?.toString() ?? '';
  }

  @override
  void dispose() {
    idLombaController.dispose();
    namaPenyelenggaraController.dispose();
    emailPenyelenggaraController.dispose();
    namaLombaController.dispose();
    kategoriLombaController.dispose();
    tanggalPelaksanaanController.dispose();
    jamPelaksanaanController.dispose();
    noRekeningController.dispose();
    biayaLombaController.dispose();
    namaPesertaController.dispose();
    emailPesertaController.dispose();
    buktiPembayaranController.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse(baseUrl + "/pendaftaranlomba"),
        body: {
          'id_lomba': idLombaController.text,
          'nama_penyelenggara': namaPenyelenggaraController.text,
          'email_penyelenggara': emailPenyelenggaraController.text,
          'nama_lomba': namaLombaController.text,
          'kategori_lomba': kategoriLombaController.text,
          'tanggal_pelaksanaan': tanggalPelaksanaanController.text,
          'jam_pelaksanaan': jamPelaksanaanController.text,
          'no_rekening': noRekeningController.text,
          'biaya_lomba': biayaLombaController.text,
          'nama_peserta': namaPesertaController.text,
          'email_peserta': emailPesertaController.text,
          'bukti_pembayaran': buktiPembayaranController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pendaftaran berhasil!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pendaftaran berhasil!'),
        ));
        print(response.body);
      }
    }
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(width: 2.0, color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(width: 2.0, color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(width: 2.0, color: Colors.black),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: _inputDecoration(hintText),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Pendaftaran Lomba'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('ID Lomba', idLombaController, 'ID Lomba'),
              _buildTextField('Nama Penyelenggara', namaPenyelenggaraController,
                  'Nama Penyelenggara'),
              _buildTextField('Email Penyelenggara',
                  emailPenyelenggaraController, 'Email Penyelenggara'),
              _buildTextField('Nama Lomba', namaLombaController, 'Nama Lomba'),
              _buildTextField(
                  'Kategori Lomba', kategoriLombaController, 'Kategori Lomba'),
              _buildTextField('Tanggal Pelaksanaan',
                  tanggalPelaksanaanController, 'Tanggal Pelaksanaan'),
              _buildTextField('Jam Pelaksanaan', jamPelaksanaanController,
                  'Jam Pelaksanaan'),
              _buildTextField(
                  'Nomor Rekening', noRekeningController, 'Nomor Rekening'),
              _buildTextField(
                  'Biaya Lomba', biayaLombaController, 'Biaya Lomba'),
              _buildTextField(
                  'Nama Peserta', namaPesertaController, 'Nama Peserta'),
              _buildTextField(
                  'Email Peserta', emailPesertaController, 'Email Peserta'),
              _buildTextField('Bukti Pembayaran (Link)',
                  buktiPembayaranController, 'Bukti Pembayaran (Link)'),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitData,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(width: 2.0, color: Colors.black),
                    ),
                  ),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
