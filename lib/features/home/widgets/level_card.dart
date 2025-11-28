import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({
    super.key,
    required this.level,
    required this.levelTitle,
    required this.currentXP,
    required this.maxXP,
  });

  final int level;
  final String levelTitle;
  final int currentXP;
  final int maxXP;

  @override
  Widget build(BuildContext context) {
    final progress = currentXP / maxXP;
    
    // Determine colors based on level
    List<Color> gradientColors;
    Color shadowColor;
    
    if (level >= 40) {
      // Level 40+ (4000+ XP): Green
      gradientColors = [const Color(0xFF4CAF50), const Color(0xFF81C784)];
      shadowColor = const Color(0xFF4CAF50);
    } else if (level >= 30) {
      // Level 30-39 (3000-3999 XP): Yellow/Gold
      gradientColors = [const Color(0xFFFFC107), const Color(0xFFFFD54F)];
      shadowColor = const Color(0xFFFFC107);
    } else if (level >= 20) {
      // Level 20-29 (2000-2999 XP): Red
      gradientColors = [const Color(0xFFF44336), const Color(0xFFEF5350)];
      shadowColor = const Color(0xFFF44336);
    } else if (level >= 10) {
      // Level 10-19 (1000-1999 XP): Blue
      gradientColors = [const Color(0xFF2196F3), const Color(0xFF64B5F6)];
      shadowColor = const Color(0xFF2196F3);
    } else {
      // Level 1-9 (0-999 XP): Purple (default)
      gradientColors = [const Color(0xFF9C27B0), const Color(0xFFBA68C8)];
      shadowColor = const Color(0xFF9C27B0);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level $level',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    levelTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currentXP XP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$maxXP XP',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${maxXP - currentXP} XP lagi untuk level ${level + 1}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
