import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/quest_card.dart';
import 'widgets/tips_quest_card.dart';

class QuestListScreen extends StatelessWidget {
  const QuestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Quest Harian',
          style: TextStyle(
            color: AppTheme.primaryGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          QuestCard(
            icon: Icons.lightbulb_outline,
            iconColor: Color(0xFFFFC857),
            title: 'Matikan Lampu',
            description: 'Matikan lampu yang tidak terpakai',
            questType: 'Harian',
            xpReward: 10,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.bolt_outlined,
            iconColor: Color(0xFFFF9E5A),
            title: 'Hemat Listrik 30 Menit',
            description: 'Cabut charger & matikan perangkat tidak terpakai',
            questType: 'Harian',
            xpReward: 20,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.recycling,
            iconColor: AppTheme.secondaryGreen,
            title: 'Pilah Sampah',
            description: 'Pisahkan sampah organik dan anorganik',
            questType: 'Harian',
            xpReward: 15,
            hasPhoto: true,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.water_drop_outlined,
            iconColor: Color(0xFF5A9BFF),
            title: 'Hemat Air',
            description: 'Kurangi waktu mandi 5 menit',
            questType: 'Harian',
            xpReward: 15,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.shopping_bag_outlined,
            iconColor: Color(0xFF5A9BFF),
            title: 'Tas Belanja Sendiri',
            description: 'Bawa tas belanja reusable',
            questType: 'Harian',
            xpReward: 10,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.directions_walk,
            iconColor: Color(0xFFFF9E5A),
            title: 'Jalan Kaki',
            description: 'Pilih jalan kaki untuk jarak dekat',
            questType: 'Harian',
            xpReward: 25,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          QuestCard(
            icon: Icons.do_not_disturb_on_outlined,
            iconColor: Color(0xFFFF6B6B),
            title: 'Tolak Sedotan Plastik',
            description: 'Katakan tidak pada sedotan plastik',
            questType: 'Harian',
            xpReward: 10,
            hasPhoto: false,
          ),
          SizedBox(height: 12),
          TipsQuestCard(),
        ],
      ),
    );
  }
}
