import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'quest_confirmation_dialog.dart';

class QuestCard extends StatelessWidget {
  const QuestCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.questType,
    required this.xpReward,
    this.hasPhoto = false,
    this.isWeekly = false,
    this.onCompleted,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String questType;
  final int xpReward;
  final bool hasPhoto;
  final bool isWeekly;
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isWeekly 
                      ? const Color(0xFF5A9BFF).withValues(alpha: 0.15)
                      : AppTheme.secondaryGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isWeekly ? Icons.calendar_today : Icons.circle,
                      size: 7,
                      color: isWeekly ? const Color(0xFF5A9BFF) : AppTheme.secondaryGreen,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      questType,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isWeekly ? const Color(0xFF5A9BFF) : AppTheme.secondaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5F1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 10,
                      color: Color(0xFFE91E63),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '+$xpReward XP',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE91E63),
                      ),
                    ),
                  ],
                ),
              ),
              if (hasPhoto) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 10,
                        color: Color(0xFF64748B),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Foto',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => QuestConfirmationDialog(
                    questTitle: title,
                    questDescription: description,
                    questIcon: icon,
                    iconColor: iconColor,
                    xpReward: xpReward,
                    hasPhoto: hasPhoto,
                    isWeekly: isWeekly,
                    onCompleted: onCompleted,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasPhoto ? Icons.upload_outlined : Icons.check_circle_outline,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hasPhoto ? 'Upload & Selesaikan' : 'Selesaikan Quest',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
