import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../ranking/ranking_screen.dart';
import '../events/event_screen.dart';
import '../rewards/reward_screen.dart';
import '../quests/widgets/quest_card.dart';
import '../quests/widgets/tips_quest_card.dart';
import 'widgets/level_card.dart';
import 'widgets/stat_card.dart';
import 'widgets/quest_overview_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String _selectedQuestType = 'harian'; // 'harian' or 'mingguan'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF6),
      body: SafeArea(
        child: _currentIndex == 0
            ? _buildHomeContent()
            : _currentIndex == 1
                ? const RankingScreen()
                : _currentIndex == 2
                    ? const EventScreen()
                    : _currentIndex == 3
                        ? const RewardScreen()
                        : _buildPlaceholder(),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: LevelCard(
              level: 1,
              levelTitle: 'Eco Newbie',
              currentXP: 0,
              maxXP: 100,
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.star_border,
                    iconColor: AppTheme.secondaryGreen,
                    value: '0',
                    label: 'Total XP',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.local_fire_department_outlined,
                    iconColor: Color(0xFFFF9E5A),
                    value: '0',
                    label: 'Streak',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.track_changes,
                    iconColor: Color(0xFF5A9BFF),
                    value: '0',
                    label: 'Hari ini',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedQuestType = 'harian';
                      });
                    },
                    child: QuestOverviewCard(
                      icon: Icons.circle,
                      iconColor: Color(0xFFFF6B6B),
                      title: 'Quest Harian',
                      progress: '0/8 selesai',
                      isActive: _selectedQuestType == 'harian',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedQuestType = 'mingguan';
                      });
                    },
                    child: QuestOverviewCard(
                      icon: Icons.calendar_today,
                      iconColor: Color(0xFF5A9BFF),
                      title: 'Quest Mingguan',
                      progress: '0/5 progress',
                      isActive: _selectedQuestType == 'mingguan',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quest Cards Section - filtered by type
          if (_selectedQuestType == 'harian') ..._buildDailyQuests(),
          if (_selectedQuestType == 'mingguan') ..._buildWeeklyQuests(),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TipsQuestCard(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildDailyQuests() {
    return const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.coffee_outlined,
          iconColor: Color(0xFFE91E63),
          title: 'Bawa Tumbler',
          description: 'Gunakan tumbler hari ini',
          questType: 'Harian',
          xpReward: 15,
          hasPhoto: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.lightbulb_outline,
          iconColor: Color(0xFFFFC857),
          title: 'Matikan Lampu',
          description: 'Matikan lampu yang tidak terpakai',
          questType: 'Harian',
          xpReward: 10,
          hasPhoto: false,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.bolt_outlined,
          iconColor: Color(0xFFFF9E5A),
          title: 'Hemat Listrik 30 Menit',
          description: 'Cabut charger & matikan perangkat tidak terpakai',
          questType: 'Harian',
          xpReward: 20,
          hasPhoto: false,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.recycling,
          iconColor: AppTheme.secondaryGreen,
          title: 'Pilah Sampah',
          description: 'Pisahkan sampah organik dan anorganik',
          questType: 'Harian',
          xpReward: 15,
          hasPhoto: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.water_drop_outlined,
          iconColor: Color(0xFF5A9BFF),
          title: 'Hemat Air',
          description: 'Kurangi waktu mandi 5 menit',
          questType: 'Harian',
          xpReward: 15,
          hasPhoto: false,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.shopping_bag_outlined,
          iconColor: Color(0xFF5A9BFF),
          title: 'Tas Belanja Sendiri',
          description: 'Bawa tas belanja reusable',
          questType: 'Harian',
          xpReward: 10,
          hasPhoto: false,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.directions_walk,
          iconColor: Color(0xFFFF9E5A),
          title: 'Jalan Kaki',
          description: 'Pilih jalan kaki untuk jarak dekat',
          questType: 'Harian',
          xpReward: 25,
          hasPhoto: false,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.do_not_disturb_on_outlined,
          iconColor: Color(0xFFFF6B6B),
          title: 'Tolak Sedotan Plastik',
          description: 'Katakan tidak pada sedotan plastik',
          questType: 'Harian',
          xpReward: 10,
          hasPhoto: false,
        ),
      ),
    ];
  }

  List<Widget> _buildWeeklyQuests() {
    return const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.eco_outlined,
          iconColor: AppTheme.secondaryGreen,
          title: 'Bebas Plastik Sekali Pakai',
          description: 'Tidak membeli produk dengan plastik sekali pakai selama 7 hari',
          questType: 'Mingguan',
          xpReward: 50,
          hasPhoto: false,
          isWeekly: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.shopping_bag,
          iconColor: Color(0xFF5A9BFF),
          title: 'Bawa Tas Belanja Konsisten',
          description: 'Gunakan tas belanja reusable setiap berbelanja selama seminggu',
          questType: 'Mingguan',
          xpReward: 40,
          hasPhoto: false,
          isWeekly: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.local_shipping_outlined,
          iconColor: Color(0xFFFF9E5A),
          title: 'Kurangi Kendaraan Bermotor',
          description: 'Gunakan transportasi umum/sepeda minimal 5x seminggu',
          questType: 'Mingguan',
          xpReward: 60,
          hasPhoto: false,
          isWeekly: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.delete_outline,
          iconColor: AppTheme.secondaryGreen,
          title: 'Setor Bank Sampah',
          description: 'Kumpulkan dan setor sampah daur ulang ke bank sampah',
          questType: 'Mingguan',
          xpReward: 80,
          hasPhoto: true,
          isWeekly: true,
        ),
      ),
      SizedBox(height: 12),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: QuestCard(
          icon: Icons.restaurant_outlined,
          iconColor: Color(0xFFE91E63),
          title: 'Kurangi Food Waste',
          description: 'Habiskan makanan tanpa sisa selama 7 hari berturut-turut',
          questType: 'Mingguan',
          xpReward: 45,
          hasPhoto: false,
          isWeekly: true,
        ),
      ),
    ];
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Halo, Yudha! ',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                        ),
                  ),
                  const Text('👋', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Mari selesaikan quest hari ini',
                style: TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lv',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        'Coming Soon',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textMuted,
            ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.task_alt, 'Quest', AppTheme.secondaryGreen),
              _buildNavItem(1, Icons.emoji_events_outlined, 'Ranking', const Color(0xFFFFC857)),
              _buildNavItem(2, Icons.calendar_today, 'Event', const Color(0xFF5A9BFF)),
              _buildNavItem(3, Icons.card_giftcard, 'Reward', const Color(0xFFFF6B6B)),
              _buildNavItem(4, Icons.person_outline, 'Profil', AppTheme.textMuted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color color) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? color : AppTheme.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? color : AppTheme.textMuted,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
