import 'package:flutter/material.dart';

class HowToGetRewardsCard extends StatelessWidget {
  const HowToGetRewardsCard({super.key});

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
                'Cara Mendapatkan Reward',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRewardMethod(
            '🏆',
            'Leaderboard Bulanan:',
            'Top 3 dapat badge + voucher premium',
          ),
          const SizedBox(height: 12),
          _buildRewardMethod(
            '👑',
            'Level Rewards:',
            'Unlock title baru setiap naik level',
          ),
          const SizedBox(height: 12),
          _buildRewardMethod(
            '🎯',
            'Event Challenge:',
            'Menangkan event untuk reward eksklusif',
          ),
          const SizedBox(height: 12),
          _buildRewardMethod(
            '⚡',
            'Streak Bonus:',
            'Pertahankan streak untuk badge spesial',
          ),
          const SizedBox(height: 12),
          _buildRewardMethod(
            '🌟',
            'Milestone:',
            'Capai quest tertentu untuk unlock badge',
          ),
        ],
      ),
    );
  }

  Widget _buildRewardMethod(String emoji, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2E2B),
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
