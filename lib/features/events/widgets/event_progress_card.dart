import 'package:flutter/material.dart';

class EventProgressCard extends StatelessWidget {
  const EventProgressCard({
    super.key,
    required this.xpEarned,
    required this.questsCompleted,
  });

  final int xpEarned;
  final int questsCompleted;

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      '🎯',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Progress Anda',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2E2B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '$xpEarned',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9C27B0),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'XP Event',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$questsCompleted quest selesai',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '🎯',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
