import 'package:flutter/material.dart';

class TitleRewardCard extends StatelessWidget {
  const TitleRewardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.unlockLevel,
    this.isLocked = true,
  });

  final String icon;
  final String title;
  final String description;
  final int unlockLevel;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isLocked
                  ? const Color(0xFFF5F5F5)
                  : const Color(0xFFF0FAF6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Opacity(
                opacity: isLocked ? 0.3 : 1.0,
                child: Text(
                  icon,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isLocked
                        ? const Color(0xFF6B7A7B)
                        : const Color(0xFF1F2E2B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      '🔒',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Unlock di level $unlockLevel',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFFF9500),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
