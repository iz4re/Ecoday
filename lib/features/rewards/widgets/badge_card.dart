import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.emoji,
    required this.badgeName,
    required this.description,
    required this.dateEarned,
  });

  final String emoji;
  final String badgeName;
  final String description;
  final String dateEarned;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
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
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF9E6), Color(0xFFFFE7BA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            badgeName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7A7B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            dateEarned,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7A7B),
            ),
          ),
        ],
      ),
    );
  }
}
