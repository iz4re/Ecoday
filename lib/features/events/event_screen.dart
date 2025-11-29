import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/event_stat_card.dart';
import 'widgets/active_event_card.dart';
import 'widgets/upcoming_event_card.dart';
import 'widgets/how_it_works_card.dart';
import '../../core/widgets/empty_state_widget.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

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
              _buildStatCards(),
              const SizedBox(height: 24),
              _buildActiveEventsSection(),
              const SizedBox(height: 24),
              _buildFeaturedEvent(),
              const SizedBox(height: 24),
              _buildUpcomingEventsSection(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HowItWorksCard(),
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
            children: const [
              Text(
                'Event Eco-Challenge ',
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
            'Ikuti challenge dan menangkan hadiah!',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: EventStatCard(
              count: 8,
              label: 'Aktif',
              color: Color(0xFF9C27B0),
              icon: Icons.local_fire_department,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: EventStatCard(
              count: 4,
              label: 'Mendatang',
              color: Color(0xFFFF9500),
              icon: Icons.calendar_today,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: EventStatCard(
              count: 1,
              label: 'Diikuti',
              color: AppTheme.secondaryGreen,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveEventsSection() {
    final List<Map<String, dynamic>> activeEvents = [
      {
        'title': 'EcoWeek: Reduce Plastic Challenge',
        'description': 'Kurangi plastik selama 7 hari! Top 3 dapat tumbler premium gratis!',
        'daysLeft': 3,
        'rewardCount': 2,
        'questCount': 4,
        'isJoined': true,
        'isEndingSoon': true,
      },
      {
        'title': 'Zero Waste Weekend',
        'description': '48 jam tanpa sampah! Buktikan kamu bisa hidup tanpa waste!',
        'daysLeft': 2,
        'rewardCount': 2,
        'questCount': 6,
        'isEndingSoon': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Event Aktif (${activeEvents.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (activeEvents.isEmpty)
          const EmptyStateWidget(
            icon: Icons.event_busy,
            message: 'Tidak ada event aktif saat ini',
            subMessage: 'Nantikan event seru berikutnya!',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeEvents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = activeEvents[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ActiveEventCard(
                  title: event['title'],
                  description: event['description'],
                  daysLeft: event['daysLeft'],
                  rewardCount: event['rewardCount'],
                  questCount: event['questCount'],
                  isJoined: event['isJoined'] ?? false,
                  isEndingSoon: event['isEndingSoon'] ?? false,
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildFeaturedEvent() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ActiveEventCard(
        title: 'Water Saving Sprint',
        description: 'Sprint 10 hari hemat air! Setiap tetes berharga!',
        daysLeft: 6,
        rewardCount: 2,
        questCount: 3,
        isHotEvent: true,
      ),
    );
  }

  Widget _buildUpcomingEventsSection() {
    final List<Map<String, dynamic>> upcomingEvents = [
      {
        'title': 'Paperless December',
        'description': 'Desember tanpa kertas! Digitalisasi semua dokumen!',
        'startDate': 'Mulai 1 Desember',
        'rewardCount': 2,
      },
      {
        'title': 'Eco Shopping December',
        'description': 'Belanja ramah lingkungan sepanjang Desember! Pilih produk sustainable!',
        'startDate': 'Mulai 1 Desember',
        'rewardCount': 2,
      },
      {
        'title': 'Urban Farming Initiative',
        'description': 'Tanam sayuran sendiri di rumah! Food security dimulai dari diri sendiri!',
        'startDate': '5 Desember',
        'rewardCount': 2,
        'rewards': ['Pot Tanaman', 'Baju'],
        'isComingSoon': true,
      },
      {
        'title': 'Second Hand Fashion Week',
        'description': 'Fast fashion OUT! Thrifting IN! Tampil keren dengan fashion berkelanjutan!',
        'startDate': '8 Desember',
        'rewardCount': 2,
        'rewards': ['Baju', 'Celana'],
        'isComingSoon': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Event Mendatang (${upcomingEvents.length})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (upcomingEvents.isEmpty)
          const EmptyStateWidget(
            icon: Icons.calendar_today,
            message: 'Belum ada event mendatang',
            subMessage: 'Cek lagi nanti ya!',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: upcomingEvents.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = upcomingEvents[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UpcomingEventCard(
                  title: event['title'],
                  description: event['description'],
                  startDate: event['startDate'],
                  rewardCount: event['rewardCount'],
                  rewards: event['rewards'] != null ? List<String>.from(event['rewards']) : [],
                  isComingSoon: event['isComingSoon'] ?? false,
                ),
              );
            },
          ),
      ],
    );
  }
}
