import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class QuestOverviewCard extends StatelessWidget {
  const QuestOverviewCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.progress,
    this.isActive = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String progress;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.secondaryGreen : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isActive 
                ? AppTheme.secondaryGreen.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isActive ? iconColor.withValues(alpha: 0.7) : iconColor,
                size: 12,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppTheme.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            progress,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF2C3E50),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
