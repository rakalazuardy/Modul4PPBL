import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  static const bidang = [
    'Administrasi',
    'Kependudukan',
    'Perizinan',
    'Kesehatan',
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();

    final values = bidang.map(model.jumlahBidang).toList();

    final maxValue =
        (values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b))
            .toDouble();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Ringkasan Pengajuan',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            'Jumlah pengajuan berdasarkan bidang layanan.',
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _metric('Total', model.total, const Color(0xFF1769AA)),
              const SizedBox(width: 10),
              _metric('Selesai', model.jumlahSelesai, Colors.green),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pengajuan per Bidang',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 280,
                  child: BarChart(
                    BarChartData(
                      maxY: maxValue < 4 ? 4 : maxValue + 1,
                      alignment: BarChartAlignment.spaceAround,
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 44,
                            getTitlesWidget: (value, meta) {
                              final i = value.toInt();

                              if (i < 0 || i >= bidang.length) {
                                return const SizedBox.shrink();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  ['Admin', 'Warga', 'Izin', 'Sehat'][i],
                                  style: const TextStyle(fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: List.generate(
                        bidang.length,
                        (i) => BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: values[i].toDouble(),
                              width: 30,
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xFF2787C8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                ...List.generate(
                  bidang.length,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(child: Text(bidang[i])),
                        Text(
                          '${values[i]} pengajuan',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, int value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
