import 'package:flutter/material.dart';

class HowItWorksCard extends StatelessWidget {
  const HowItWorksCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                '💡',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 8),
              Text(
                'Cara Kerja Event',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStep('1', 'Pilih event yang sedang aktif'),
          const SizedBox(height: 10),
          _buildStep('2', 'Klik "Ikut Event Sekarang!" untuk join'),
          const SizedBox(height: 10),
          _buildStep('3', 'Selesaikan quest event setiap hari'),
          const SizedBox(height: 10),
          _buildStep('4', 'Kumpulkan XP dan naik ke leaderboard'),
          const SizedBox(height: 10),
          _buildStep('5', 'Top 3 mendapatkan hadiah eksklusif!'),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF5A9BFF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1F2E2B),
            ),
          ),
        ),
      ],
    );
  }
}
