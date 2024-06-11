class Pendaftaran {
  final String idPeserta;
  final String namaPeserta;
  final String email;
  final String idLomba;
  final String namaLomba;
  final String penyelenggara;
  final DateTime waktu;
  final String noRekening;
  final double biaya;
  final String linkPembayaran;
  String status;

  Pendaftaran({
    required this.idPeserta,
    required this.namaPeserta,
    required this.email,
    required this.idLomba,
    required this.namaLomba,
    required this.penyelenggara,
    required this.waktu,
    required this.noRekening,
    required this.biaya,
    required this.linkPembayaran,
    this.status = 'Menunggu Acc',
  });
}
