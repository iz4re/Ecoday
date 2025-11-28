import 'package:flutter/material.dart';

class TopThreeCard extends StatelessWidget {
  const TopThreeCard({
    super.key,
    required this.rank,
    required this.name,
    required this.level,
    required this.xp,
    required this.medalColor,
    required this.medalIcon,
  });

  final int rank;
  final String name;
  final int level;
  final int xp;
  final Color medalColor;
  final IconData medalIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rank == 1
              ? const Color(0xFFFFC857)
              : rank == 2
                  ? const Color(0xFFB0B0B0)
                  : const Color(0xFFFF9E5A),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: medalColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              medalIcon,
              color: medalColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '😊',
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            name.split(' ')[0] + (name.split(' ').length > 1 ? '...' : ''),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2E2B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            'Lv $level',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF6B7A7B),
            ),
          ),
          Text(
            '$xp XP',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7A7B),
            ),
          ),
        ],
      ),
    );
  }
}
