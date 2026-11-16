import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class DetailPengajuanPage extends StatelessWidget {
  final int id;

  const DetailPengajuanPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final item = context
        .watch<PengajuanModel>()
        .berdasarkanId(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengajuan'),
      ),
      body: item == null
          ? const Center(
              child: Text('Data pengajuan tidak ditemukan'),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Icon(
                  Icons.assignment_turned_in_outlined,
                  size: 58,
                  color: Color(0xFF1769AA),
                ),

                const SizedBox(height: 16),

                Center(
                  child: Text(
                    item.bidang,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                _row('Nama lengkap', item.nama),
                _row('Email', item.email),
                _row('Bidang layanan', item.bidang),
                _row('Sesi kunjungan', item.sesi),
                _row(
                  'Tanggal',
                  '${item.tanggal.day}/${item.tanggal.month}/${item.tanggal.year}',
                ),
                _row(
                  'Status',
                  item.selesai ? 'Selesai' : 'Diproses',
                ),
              ],
            ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}