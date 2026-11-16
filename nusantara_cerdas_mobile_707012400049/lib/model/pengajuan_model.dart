import 'package:flutter/foundation.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String email;
  final String bidang;
  final String sesi;
  final DateTime tanggal;
  bool selesai;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.bidang,
    required this.sesi,
    required this.tanggal,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftar = [
    Pengajuan(
      id: 1,
      nama: 'Andi Pratama',
      email: 'andi@email.com',
      bidang: 'Administrasi',
      sesi: 'Pagi',
      tanggal: DateTime.now().subtract(
        const Duration(days: 2),
      ),
    ),
    Pengajuan(
      id: 2,
      nama: 'Siti Rahma',
      email: 'siti@email.com',
      bidang: 'Kependudukan',
      sesi: 'Siang',
      tanggal: DateTime.now().subtract(
        const Duration(days: 1),
      ),
      selesai: true,
    ),
  ];

  List<Pengajuan> get daftar => List.unmodifiable(_daftar);

  void tambah(Pengajuan pengajuan) {
    _daftar.insert(0, pengajuan);
    notifyListeners();
  }

  Pengajuan? berdasarkanId(int id) {
    for (final item in _daftar) {
      if (item.id == id) return item;
    }
    return null;
  }

  void tandaiSelesai(int id) {
    final index = _daftar.indexWhere(
      (item) => item.id == id,
    );

    if (index == -1) return;

    _daftar[index].selesai = true;
    notifyListeners();
  }

  int jumlahBidang(String bidang) {
    return _daftar
        .where((item) => item.bidang == bidang)
        .length;
  }

  int get total => _daftar.length;

  int get jumlahSelesai =>
      _daftar.where((item) => item.selesai).length;

  int get jumlahDiproses => total - jumlahSelesai;
}