import 'package:flutter/material.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.title,
    required this.level,
    required this.xp,
    this.isCurrentUser = false,
    this.hasSpecialBadges = false,
    this.badgeIcons = const [],
  });

  final int rank;
  final String name;
  final String title;
  final int level;
  final int xp;
  final bool isCurrentUser;
  final bool hasSpecialBadges;
  final List<IconData> badgeIcons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrentUser
            ? Border.all(
                color: const Color(0xFFBA68C8),
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isCurrentUser
                ? const Color(0xFF9C27B0).withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: isCurrentUser ? 15 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: rank <= 3
                  ? (rank == 1
                      ? const Color(0xFFFFF9E6)
                      : rank == 2
                          ? const Color(0xFFF5F5F5)
                          : const Color(0xFFFFF4E6))
                  : const Color(0xFFF0FAF6),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: rank <= 3
                  ? Icon(
                      rank == 1
                          ? Icons.military_tech
                          : rank == 2
                              ? Icons.emoji_events
                              : Icons.workspace_premium,
                      color: rank == 1
                          ? const Color(0xFFFFC857)
                          : rank == 2
                              ? const Color(0xFFB0B0B0)
                              : const Color(0xFFFF9E5A),
                      size: 20,
                    )
                  : Text(
                      '#$rank',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B7A7B),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Avatar emoji
          const Text(
            '😊',
            style: TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 12),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        isCurrentUser ? '$name (Anda)' : name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: isCurrentUser
                              ? const Color(0xFF9C27B0)
                              : const Color(0xFF1F2E2B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
                if (hasSpecialBadges || badgeIcons.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: badgeIcons
                        .take(3)
                        .map(
                          (icon) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(
                              icon,
                              size: 16,
                              color: icon == Icons.military_tech
                                  ? const Color(0xFFFFC857)
                                  : icon == Icons.emoji_events
                                      ? const Color(0xFFB0B0B0)
                                      : icon == Icons.workspace_premium
                                          ? const Color(0xFFFF9E5A)
                                          : icon == Icons.local_fire_department
                                              ? const Color(0xFFFF6B6B)
                                              : const Color(0xFF0B8F6E),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          // Level and XP
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Lv $level',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7A7B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$xp',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
              const Text(
                'XP',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7A7B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
