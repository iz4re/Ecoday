import 'package:flutter/material.dart';

class TipsQuestCard extends StatelessWidget {
  const TipsQuestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFC857).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC857).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Color(0xFFFF9E5A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tips Quest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _buildTip('Quest Harian: Selesaikan setiap hari untuk streak bonus!'),
          const SizedBox(height: 8),
          _buildTip('Quest Mingguan: Konsistensi adalah kunci!'),
          const SizedBox(height: 8),
          _buildTip('Foto Quest: Upload bukti untuk validasi otomatis'),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7A7B),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7A7B),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
