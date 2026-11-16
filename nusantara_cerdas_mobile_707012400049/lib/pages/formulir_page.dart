import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});

  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();

  bool _setuju = false;
  String? _sesi = 'Pagi';
  String _bidang = 'Administrasi';
  bool _loading = false;

  bool get _emailValid {
    return _emailController.text.trim().contains('@');
  }

  bool get _formValid {
    return _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _emailValid &&
        _setuju &&
        _sesi != null;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _kirim() async {
    if (!_formValid || _loading) return;

    setState(() {
      _loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    context.read<PengajuanModel>().tambah(
      Pengajuan(
        id: DateTime.now().microsecondsSinceEpoch,
        nama: _namaController.text.trim(),
        email: _emailController.text.trim(),
        bidang: _bidang,
        sesi: _sesi!,
        tanggal: DateTime.now(),
      ),
    );

    setState(() {
      _loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan berhasil dikirim!'),
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.warga,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pengajuan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Ajukan Layanan',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Lengkapi data berikut untuk mengajukan layanan publik.',
            style: TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 22),

          const Text(
            'Nama Lengkap',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _namaController,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: 'Masukkan nama lengkap',
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined),
              hintText: 'nama@email.com',
              errorText: _emailController.text.isEmpty ||
                      _emailValid
                  ? null
                  : 'Email harus mengandung karakter @',
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Bidang Layanan',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: _bidang,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.category_outlined),
            ),
            items: const [
              'Administrasi',
              'Kependudukan',
              'Perizinan',
              'Kesehatan',
            ].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _bidang = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          const Text(
            'Sesi Kunjungan',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),

          ...['Pagi', 'Siang', 'Sore'].map(
            (s) => RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: Text(s),
              value: s,
              groupValue: _sesi,
              onChanged: (value) {
                setState(() {
                  _sesi = value;
                });
              },
            ),
          ),

          const SizedBox(height: 6),

          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _setuju,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(
              'Saya menyetujui penggunaan data pribadi untuk keperluan layanan.',
            ),
            onChanged: (value) {
              setState(() {
                _setuju = value ?? false;
              });
            },
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _formValid && !_loading
                  ? _kirim
                  : null,
              child: _loading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Kirim Pengajuan'),
            ),
          ),
        ],
      ),
    );
  }
}