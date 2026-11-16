import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _kirim() {
    final teks = _controller.text;

    if (teks.trim().isEmpty) return;

    context.read<ChatModel>().kirim(teks);
    _controller.clear();

    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        if (mounted) {
          context.read<ChatModel>().balasOtomatis();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pesan = context.watch<ChatModel>().pesan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya Petugas'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFEAF3FB),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF1769AA),
                  child: Icon(
                    Icons.support_agent,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Layanan Bantuan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Petugas siap membantu',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(14),
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final item = pesan[
                    pesan.length - 1 - index];

                return Align(
                  alignment: item.dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 290,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: item.dariWarga
                          ? const Color(0xFF1769AA)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      item.teks,
                      style: TextStyle(
                        color: item.dariWarga
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                8,
                12,
                12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _kirim(),
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton.filled(
                    onPressed: _kirim,
                    icon: const Icon(Icons.send),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF1769AA),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}