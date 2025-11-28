import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/user_rank_card.dart';
import 'widgets/top_three_card.dart';
import 'widgets/leaderboard_item.dart';
import 'widgets/reward_info_card.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: UserRankCard(
                  rank: 11,
                  level: 1,
                  xp: 0,
                  title: 'Eco Newbie',
                ),
              ),
              const SizedBox(height: 24),
              _buildTopThreeSection(),
              const SizedBox(height: 24),
              _buildAllRankingsSection(),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: RewardInfoCard(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Leaderboard Global ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Peringkat berdasarkan Total XP',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                '🏆',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              const Text(
                'Top 3 Heroes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              TopThreeCard(
                rank: 1,
                name: 'Budi Santoso',
                level: 9,
                xp: 4850,
                medalColor: Color(0xFFFFC857),
                medalIcon: Icons.military_tech,
              ),
              TopThreeCard(
                rank: 2,
                name: 'Siti Rahayu',
                level: 8,
                xp: 4280,
                medalColor: Color(0xFFB0B0B0),
                medalIcon: Icons.emoji_events,
              ),
              TopThreeCard(
                rank: 3,
                name: 'Ahmad Hidayat',
                level: 8,
                xp: 3950,
                medalColor: Color(0xFFFF9E5A),
                medalIcon: Icons.workspace_premium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllRankingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Semua Peringkat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const LeaderboardItem(
          rank: 1,
          name: 'Budi Santoso',
          title: 'Earth Guardian',
          level: 9,
          xp: 4850,
          hasSpecialBadges: true,
          badgeIcons: [Icons.military_tech, Icons.emoji_events, Icons.local_fire_department],
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 2,
          name: 'Siti Rahayu',
          title: 'Eco Champion',
          level: 8,
          xp: 4280,
          hasSpecialBadges: true,
          badgeIcons: [Icons.emoji_events, Icons.local_fire_department],
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 3,
          name: 'Ahmad Hidayat',
          title: 'Eco Champion',
          level: 8,
          xp: 3950,
          hasSpecialBadges: true,
          badgeIcons: [Icons.workspace_premium, Icons.local_fire_department],
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 4,
          name: 'Dewi Lestari',
          title: 'Eco Champion',
          level: 7,
          xp: 3120,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 5,
          name: 'Rudi Hartono',
          title: 'Eco Champion',
          level: 7,
          xp: 2750,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 6,
          name: 'Maya Putri',
          title: 'Eco Warrior',
          level: 6,
          xp: 2320,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 7,
          name: 'Eko Prasetyo',
          title: 'Eco Warrior',
          level: 6,
          xp: 1980,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 8,
          name: 'Rina Susanti',
          title: 'Eco Warrior',
          level: 5,
          xp: 1550,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 9,
          name: 'Agus Setiawan',
          title: 'Eco Warrior',
          level: 5,
          xp: 1320,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 10,
          name: 'Linda Wijaya',
          title: 'Eco Starter',
          level: 4,
          xp: 1100,
        ),
        const SizedBox(height: 8),
        const LeaderboardItem(
          rank: 11,
          name: 'qqqq',
          title: 'Eco Newbie',
          level: 1,
          xp: 0,
          isCurrentUser: true,
          badgeIcons: [Icons.eco],
        ),
      ],
    );
  }
}
