class Lomba {
  String nama;
  String penyelenggara;
  String waktu;
  String noRekening;
  String biaya;
  String status;

  Lomba({
    required this.nama,
    required this.penyelenggara,
    required this.waktu,
    required this.noRekening,
    required this.biaya,
    this.status = 'Menunggu ACC',
  });
}
