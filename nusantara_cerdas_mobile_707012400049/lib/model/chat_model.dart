import 'package:flutter/foundation.dart';

class Pesan {
  final String teks;
  final bool dariWarga;
  final DateTime waktu;

  Pesan({
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });
}

class ChatModel extends ChangeNotifier {
  final List<Pesan> _pesan = [
    Pesan(
      teks: 'Selamat datang di layanan Nusantara Cerdas. Ada yang bisa kami bantu?',
      dariWarga: false,
      waktu: DateTime.now(),
    ),
  ];

  List<Pesan> get pesan => List.unmodifiable(_pesan);

  void kirim(String teks) {
    if (teks.trim().isEmpty) return;

    _pesan.add(
      Pesan(
        teks: teks.trim(),
        dariWarga: true,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void balasOtomatis() {
    _pesan.add(
      Pesan(
        teks: 'Terima kasih. Pesan Anda telah kami terima. Petugas akan segera membantu.',
        dariWarga: false,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}