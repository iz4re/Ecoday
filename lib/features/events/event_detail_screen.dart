import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'event_progress_screen.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({
    super.key,
    required this.title,
    required this.description,
    this.daysLeft = 0,
    this.participants = 0,
    this.rewards = 0,
    this.isJoined = false,
  });

  final String title;
  final String description;
  final int daysLeft;
  final int participants;
  final int rewards;
  final bool isJoined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF6),
      body: SafeArea(
        child: Stack(
          children: [
            // Content
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 60,
                bottom: isJoined ? 20 : 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 20),
                  _buildQuickStats(),
                  const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 20),
                  _buildQuestsGrid(),
                  const SizedBox(height: 20),
                  _buildRewardsCarousel(),
                  const SizedBox(height: 20),
                  _buildJoinedUsers(),
                  const SizedBox(height: 20),
                  _buildFunRules(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Floating Header
            _buildFloatingHeader(context),
            // Floating CTA (if not joined)
            if (!isJoined) _buildFloatingCTA(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingHeader(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FAF6).withValues(alpha: 0.95),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Event Detail',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.access_time, size: 14, color: Color(0xFFFF9500)),
                  SizedBox(width: 4),
                  Text(
                    '2 hari lagi',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF9500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fun badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9C27B0).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🔥', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 6),
                    Text(
                      'TRENDING EVENT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0ABF8A).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '16+ bergabung',
                  style: TextStyle(
                    color: Color(0xFF0ABF8A),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Title with emoji
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2E2B),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7A7B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatBubble(
              '⏰',
              '$daysLeft hari',
              'Sisa waktu',
              const Color(0xFFFF9500),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatBubble(
              '🎁',
              '$rewards hadiah',
              'Untuk top 3',
              const Color(0xFF9C27B0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBubble(String emoji, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7A7B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF9C27B0).withValues(alpha: 0.05),
              const Color(0xFFBA68C8).withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('💡', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text(
                  'Yang Perlu Kamu Tau',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2E2B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow('📅', '1-3 Desember 2025'),
            const SizedBox(height: 10),
            _buildInfoRow('🏷️', 'Reduce Plastic & Zero Waste'),
            const SizedBox(height: 10),
            _buildInfoRow('📸', 'Semua quest butuh foto bukti!'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7A7B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quest yang Bisa Kamu Kerjain 💪',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,  // Increased from 140
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildQuestCard('🥤', 'Bawa Tumbler', 15, const Color(0xFFFF9500)),
              _buildQuestCard('🛍️', 'Tas Belanja', 10, const Color(0xFF0ABF8A)),
              _buildQuestCard('🚫', 'No Sedotan', 10, const Color(0xFF5A9BFF)),
              _buildQuestCard('🌱', 'Bebas Plastik', 80, const Color(0xFF9C27B0)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestCard(String emoji, String title, int xp, Color color) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+$xp XP',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Hadiah Keren Buat Top 3! 🎁',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 168,  // Increased from 160
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildRewardCard('🥇', 'Juara 1', 'Tumbler + Eco Bag\n+ Voucher 100K', const Color(0xFFFFD700)),
              _buildRewardCard('🥈', 'Juara 2', 'Eco Bag\n+ Voucher 50K', const Color(0xFFC0C0C0)),
              _buildRewardCard('🥉', 'Juara 3', 'Eco Bag\n+ Voucher 25K', const Color(0xFFCD7F32)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRewardCard(String medal, String rank, String reward, Color color) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(medal, style: const TextStyle(fontSize: 36)),
          const SizedBox(height: 12),
          Text(
            rank,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            reward,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7A7B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinedUsers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Stacked avatars
            SizedBox(
              width: 100,
              height: 36,
              child: Stack(
                children: List.generate(
                  4,
                  (index) => Positioned(
                    left: index * 20.0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: _getAvatarColor(index),
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '16+ orang sudah join!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2E2B),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Yuk jadi bagian dari komunitas 🚀',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7A7B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(int index) {
    const colors = [
      Color(0xFF9C27B0),
      Color(0xFF0ABF8A),
      Color(0xFFFF9500),
      Color(0xFF5A9BFF),
    ];
    return colors[index % colors.length];
  }

  Widget _buildFunRules() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Aturan Main-nya Gampang Kok! 😎',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
          const SizedBox(height: 16),
          _buildRuleItem('📸', 'Upload foto bukti tiap quest'),
          _buildRuleItem('✅', 'Tunggu admin approve (maks 24 jam)'),
          _buildRuleItem('⭐', 'XP masuk setelah approved'),
          _buildRuleItem('🏆', 'Kumpulin XP terbanyak = menang!'),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7A7B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCTA(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0B8F6E), Color(0xFF24C08E)],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0B8F6E).withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EventProgressScreen(
                    title: title,
                    description: description,
                    daysLeft: daysLeft,
                    participants: participants,
                    rewards: rewards,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Ikut Event Sekarang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text('🚀', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
