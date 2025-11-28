import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/current_title_card.dart';
import 'widgets/title_reward_card.dart';
import 'widgets/badge_card.dart';
import 'widgets/voucher_card.dart';
import 'widgets/how_to_get_rewards_card.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

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
                child: CurrentTitleCard(
                  title: 'Eco Newbie',
                  level: 1,
                  xp: 0,
                ),
              ),
              const SizedBox(height: 24),
              _buildTitleRewardsSection(),
              const SizedBox(height: 24),
              _buildBadgeCollectionSection(),
              const SizedBox(height: 24),
              _buildVouchersSection(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: HowToGetRewardsCard(),
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
                'Reward & Hadiah ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
              Text(
                '🎁',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Claim voucher, badge, dan title Anda',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRewardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Text(
                '👑',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Text(
                'Title & Level Rewards',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TitleRewardCard(
            icon: '⚔️',
            title: 'Title: Eco Warrior',
            description: 'Unlock title "Eco Warrior"',
            unlockLevel: 5,
            isLocked: true,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TitleRewardCard(
            icon: '🛡️',
            title: 'Title: Earth Guardian',
            description: 'Unlock title "Earth Guardian"',
            unlockLevel: 10,
            isLocked: true,
          ),
        ),
      ],
    );
  }

  Widget _buildBadgeCollectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Text(
                '🏅',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Text(
                'Koleksi Badge',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BadgeCard(
            emoji: '🎉',
            badgeName: 'Welcome Badge',
            description: 'Joined EcoDay',
            dateEarned: '28/11/2025',
          ),
        ),
      ],
    );
  }

  Widget _buildVouchersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Text(
                '🎫',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              Text(
                'Voucher Tersedia',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2E2B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: VoucherCard(
            title: 'Voucher Tumbler Premium',
            description: 'Tumbler ramah lingkungan 500ml',
            expiryDate: '2025-12-31',
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: VoucherCard(
            title: 'Diskon 25% Eco Product',
            description: 'Berlaku untuk semua produk ramah lingkungan',
            expiryDate: '2025-12-15',
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: VoucherCard(
            title: 'Voucher Reusable Bag',
            description: 'Tas belanja ramah lingkungan gratis',
            expiryDate: '2026-01-31',
          ),
        ),
      ],
    );
  }
}
