import 'package:flutter/material.dart';

class EventLeaderboardCard extends StatelessWidget {
  const EventLeaderboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              '🏆',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
            Text(
              'Leaderboard Event',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2E2B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTopThree(),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5E6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: const [
              Text('🎁', style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Top 3 mendapatkan semua hadiah event!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9C27B0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildUserPosition(),
        const SizedBox(height: 16),
        _buildAllParticipants(context),
      ],
    );
  }

  Widget _buildTopThree() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPodiumCard(
          rank: 2,
          name: 'Siti Rahayu',
          xp: 720,
          emoji: '😊',
          color: const Color(0xFFB0B0B0),
        ),
        _buildPodiumCard(
          rank: 1,
          name: 'Budi Santoso',
          xp: 850,
          emoji: '😊',
          color: const Color(0xFFFFC857),
          isFirst: true,
        ),
        _buildPodiumCard(
          rank: 3,
          name: 'Ahmad Hidayat',
          xp: 680,
          emoji: '😊',
          color: const Color(0xFFFF9E5A),
        ),
      ],
    );
  }

  Widget _buildPodiumCard({
    required int rank,
    required String name,
    required int xp,
    required String emoji,
    required Color color,
    bool isFirst = false,
  }) {
    return Container(
      width: isFirst ? 110 : 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: isFirst ? 32 : 28),
          ),
          const SizedBox(height: 6),
          Text(
            name.split(' ')[0],
            style: TextStyle(
              color: Colors.white,
              fontSize: isFirst ? 14 : 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '$xp XP',
            style: TextStyle(
              color: Colors.white,
              fontSize: isFirst ? 13 : 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '👑',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 4),
                Text(
                  'JUARA $rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserPosition() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9C27B0).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text(
                    '😊',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posisi Anda Saat Ini',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Rank #16',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Total XP',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '⭐',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Text(
                  '⭐',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Selesaikan lebih banyak quest untuk naik peringkat!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllParticipants(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📊 Semua Peserta',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2E2B),
          ),
        ),
        const SizedBox(height: 12),
        _buildParticipantItem('🏆', '😊', 'Budi Santoso', 850, hasTopBadge: true),
        const SizedBox(height: 8),
        _buildParticipantItem('🥈', '😊', 'Siti Rahayu', 720, hasSecondBadge: true),
        const SizedBox(height: 8),
        _buildParticipantItem('🥉', '😊', 'Ahmad Hidayat', 680, hasThirdBadge: true),
        const SizedBox(height: 8),
        _buildParticipantItem('#4', '😊', 'Dewi Lestari', 620),
        const SizedBox(height: 8),
        _buildParticipantItem('#5', '😊', 'Rudi Hartono', 580),
        const SizedBox(height: 8),
        _buildParticipantItem('#6', '😊', 'Maya Putri', 550),
        const SizedBox(height: 8),
        _buildParticipantItem('#7', '😊', 'Eko Prasetyo', 520),
        const SizedBox(height: 8),
        _buildParticipantItem('#8', '😊', 'Rina Susanti', 480),
        const SizedBox(height: 8),
        _buildParticipantItem('#9', '😊', 'Agus Setiawan', 450),
      ],
    );
  }

  Widget _buildParticipantItem(
    String rank,
    String emoji,
    String name,
    int xp, {
    bool hasTopBadge = false,
    bool hasSecondBadge = false,
    bool hasThirdBadge = false,
  }) {
    Color borderColor = Colors.transparent;
    if (hasTopBadge) borderColor = const Color(0xFFFFC857);
    if (hasSecondBadge) borderColor = const Color(0xFFB0B0B0);
    if (hasThirdBadge) borderColor = const Color(0xFFFF9E5A);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: borderColor != Colors.transparent ? 2 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (hasTopBadge || hasSecondBadge || hasThirdBadge)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  rank,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            )
          else
            SizedBox(
              width: 32,
              child: Text(
                rank,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7A7B),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(width: 12),
          Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2E2B),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$xp',
                style: const TextStyle(
                  fontSize: 15,
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
