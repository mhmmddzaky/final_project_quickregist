class Lomba {
  final String id;
  final String nama;
  final String penyelenggara;
  final DateTime waktu;
  final String noRekening;
  final double biaya;
  final String linkPembayaran;
  String status;

  Lomba({
    required this.id,
    required this.nama,
    required this.penyelenggara,
    required this.waktu,
    required this.noRekening,
    required this.biaya,
    required this.linkPembayaran,
    this.status = 'Menunggu Acc',
  });
}
