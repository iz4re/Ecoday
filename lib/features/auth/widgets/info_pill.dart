import 'package:flutter/material.dart';

class InfoPill extends StatelessWidget {
  const InfoPill({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FFF7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE0F6EA)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(19),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFF0ABF8A), size: 18),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B8F6E),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Color(0xFF6B7A7B), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
