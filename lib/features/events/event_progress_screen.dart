import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/event_progress_card.dart';
import 'widgets/event_quest_card.dart';
import 'widgets/event_leaderboard_card.dart';
import '../../core/widgets/empty_state_widget.dart';

class EventProgressScreen extends StatefulWidget {
  const EventProgressScreen({
    super.key,
    required this.title,
    required this.description,
    this.daysLeft = 0,
    this.participants = 0,
    this.rewards = 0,
  });

  final String title;
  final String description;
  final int daysLeft;
  final int participants;
  final int rewards;

  @override
  State<EventProgressScreen> createState() => _EventProgressScreenState();
}

class _EventProgressScreenState extends State<EventProgressScreen> {
  int _totalXpEarned = 0;
  int _questsCompleted = 0;

  void _onQuestCompleted(int xpReward) {
    setState(() {
      _totalXpEarned += xpReward;
      _questsCompleted++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEventCard(),
                    const SizedBox(height: 20),
                    EventProgressCard(
                      xpEarned: _totalXpEarned,
                      questsCompleted: _questsCompleted,
                    ),
                    const SizedBox(height: 20),
                    _buildQuestSection(),
                    const SizedBox(height: 20),
                    const EventLeaderboardCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: const [
                Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  'Kembali ke Event',
                  style: TextStyle(
                    color: AppTheme.primaryGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9C27B0).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  Icons.access_time,
                  'Sisa Waktu',
                  '${widget.daysLeft} hari',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(
                  Icons.people_outline,
                  'Peserta',
                  '${widget.participants}+',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(
                  Icons.emoji_events_outlined,
                  'Hadiah',
                  '${widget.rewards}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestSection() {
    // Dummy data for quests
    final List<Map<String, dynamic>> quests = [
      {
        'icon': '🥤',
        'title': 'Bawa Tumbler',
        'description': 'Gunakan tumbler hari ini',
        'xp': 15,
        'tag': 'Harian',
        'category': 'Reduce Plastic',
        'tagColor': const Color(0xFFFF9500),
        'hasUpload': true,
      },
      {
        'icon': '🛍️',
        'title': 'Tas Belanja Sendiri',
        'description': 'Bawa tas belanja reusable',
        'xp': 10,
        'tag': 'Harian',
        'category': 'Reduce Plastic',
        'tagColor': const Color(0xFF0ABF8A),
        'hasUpload': true,
      },
      {
        'icon': '🚫',
        'title': 'Tolak Sedotan Plastik',
        'description': 'Katakan tidak pada sedotan plastik',
        'xp': 10,
        'tag': 'Harian',
        'category': 'Reduce Plastic',
        'tagColor': const Color(0xFF0ABF8A),
        'hasUpload': true,
      },
      {
        'icon': '🌱',
        'title': 'Bebas Plastik Sekali Pakai',
        'description': 'Tidak membeli produk dengan plastik sekali pakai selama 7 hari',
        'xp': 80,
        'tag': 'Mingguan',
        'category': 'Reduce Plastic',
        'tagColor': const Color(0xFF5A9BFF),
        'hasUpload': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              '⚔️',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 8),
            Text(
              'Quest Event',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2E2B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (quests.isEmpty)
          const EmptyStateWidget(
            icon: Icons.assignment_turned_in_outlined,
            message: 'Belum ada quest tersedia',
            subMessage: 'Nantikan quest seru lainnya segera!',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quests.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final quest = quests[index];
              return EventQuestCard(
                icon: quest['icon'],
                title: quest['title'],
                description: quest['description'],
                xp: quest['xp'],
                tag: quest['tag'],
                category: quest['category'],
                tagColor: quest['tagColor'],
                hasUpload: quest['hasUpload'],
                onCompleted: _onQuestCompleted,
              );
            },
          ),
      ],
    );
  }
}
