import 'package:flutter/material.dart';
import '../event_detail_screen.dart';

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({
    super.key,
    required this.title,
    required this.description,
    required this.startDate,
    required this.rewardCount,
    this.rewards = const [],
    this.isComingSoon = false,
  });

  final String title;
  final String description;
  final String startDate;
  final int rewardCount;
  final List<String> rewards;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              title: title,
              description: description,
              daysLeft: 10, // Placeholder for upcoming events
              participants: 0,
              rewards: rewardCount,
            ),
          ),
        );
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2E2B),
                    ),
                  ),
                ),
                if (isComingSoon)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A9BFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7A7B),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: const Color(0xFF6B7A7B),
                ),
                const SizedBox(width: 4),
                Text(
                  startDate,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.emoji_events_outlined,
                  size: 14,
                  color: const Color(0xFF6B7A7B),
                ),
                const SizedBox(width: 4),
                Text(
                  '$rewardCount hadiah',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.track_changes,
                  size: 14,
                  color: const Color(0xFF6B7A7B),
                ),
                const SizedBox(width: 4),
                Text(
                  '4 quest',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
              ],
            ),
            if (rewards.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Rewards: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7A7B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ...rewards.map((emoji) => Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 18),
                        ),
                      )),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
