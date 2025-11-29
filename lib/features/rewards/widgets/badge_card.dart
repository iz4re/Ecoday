import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.emoji,
    required this.badgeName,
    required this.description,
    required this.dateEarned,
    this.isLocked = false,
  });

  final String emoji;
  final String badgeName;
  final String description;
  final String dateEarned;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1.0,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLocked ? Colors.grey.shade100 : Colors.white,
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
                gradient: isLocked
                    ? LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const LinearGradient(
                        colors: [Color(0xFFFFF9E6), Color(0xFFFFE7BA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: isLocked
                    ? const Icon(Icons.lock, size: 32, color: Colors.white)
                    : Text(
                        emoji,
                        style: const TextStyle(fontSize: 40),
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              badgeName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isLocked ? Colors.grey : const Color(0xFF1F2E2B),
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
      ),
    );
  }
}
