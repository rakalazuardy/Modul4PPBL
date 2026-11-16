import 'package:flutter/material.dart';

import '../pages/warga_page.dart';
import '../pages/formulir_page.dart';
import '../pages/detail_pengajuan_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const warga = '/warga';
  static const formulir = '/formulir';
  static const detail = '/detail';
  static const chat = '/chat';
  static const peta = '/peta';
  static const statistik = '/statistik';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case warga:
        return MaterialPageRoute(
          builder: (_) => const KerangkaNavigasi(),
        );

      case formulir:
        return MaterialPageRoute(
          builder: (_) => const FormulirPage(),
        );

      case detail:
        final id = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => DetailPengajuanPage(id: id),
        );

      case chat:
        return MaterialPageRoute(
          builder: (_) => const ChatPage(),
        );

      case peta:
        return MaterialPageRoute(
          builder: (_) => const PetaPage(),
        );

      case statistik:
        return MaterialPageRoute(
          builder: (_) => const StatistikPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Halaman tidak ditemukan'),
            ),
          ),
        );
    }
  }
}