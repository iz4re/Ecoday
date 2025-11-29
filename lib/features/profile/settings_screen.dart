import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../auth/auth_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.username});

  final String? username;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification settings
  bool _dailyReminders = true;
  bool _eventAlerts = true;
  String _reminderTime = '09:00';

  // Goals
  int _dailyQuestGoal = 3;
  int _weeklyXPTarget = 200;

  // Privacy
  bool _showInLeaderboard = true;
  String _profileVisibility = 'Public';

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
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildAccountSection(),
                    const SizedBox(height: 16),
                    _buildNotificationsSection(),
                    const SizedBox(height: 16),
                    _buildPrivacySection(),
                    const SizedBox(height: 16),
                    _buildAboutSection(),
                    const SizedBox(height: 16),
                    _buildLogoutButton(),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return _buildSection(
      title: 'Account',
      children: [
        _buildSettingsTile(
          icon: Icons.edit_outlined,
          title: 'Edit Profile',
          subtitle: 'Update your profile information',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(username: widget.username),
              ),
            );
          },
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your password',
          onTap: () {
            _showComingSoonDialog('Change Password');
          },
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSection(
      title: 'Notifications',
      children: [
        _buildSwitchTile(
          icon: Icons.notifications_active_outlined,
          title: 'Daily Quest Reminders',
          subtitle: 'Get reminded about daily quests',
          value: _dailyReminders,
          onChanged: (value) => setState(() => _dailyReminders = value),
        ),
        if (_dailyReminders) ...[
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.access_time,
            title: 'Reminder Time',
            subtitle: _reminderTime,
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () => _showTimePicker(),
          ),
        ],
        _buildDivider(),
        _buildSwitchTile(
          icon: Icons.event_outlined,
          title: 'Event Alerts',
          subtitle: 'Notifications for new events',
          value: _eventAlerts,
          onChanged: (value) => setState(() => _eventAlerts = value),
        ),
      ],
    );
  }

  Widget _buildGoalsSection() {
    return _buildSection(
      title: '🎯 Eco Goals',
      children: [
        _buildSettingsTile(
          icon: Icons.task_alt,
          title: 'Daily Quest Goal',
          subtitle: '$_dailyQuestGoal quests per day',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                onPressed: _dailyQuestGoal > 1
                    ? () => setState(() => _dailyQuestGoal--)
                    : null,
                color: AppTheme.primaryGreen,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_dailyQuestGoal',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                onPressed: _dailyQuestGoal < 10
                    ? () => setState(() => _dailyQuestGoal++)
                    : null,
                color: AppTheme.primaryGreen,
              ),
            ],
          ),
          onTap: null,
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.stars_outlined,
          title: 'Weekly XP Target',
          subtitle: '$_weeklyXPTarget XP per week',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                onPressed: _weeklyXPTarget > 100
                    ? () => setState(() => _weeklyXPTarget -= 50)
                    : null,
                color: const Color(0xFF9C27B0),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_weeklyXPTarget',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9C27B0),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                onPressed: _weeklyXPTarget < 1000
                    ? () => setState(() => _weeklyXPTarget += 50)
                    : null,
                color: const Color(0xFF9C27B0),
              ),
            ],
          ),
          onTap: null,
        ),
      ],
    );
  }

  Widget _buildPrivacySection() {
    return _buildSection(
      title: 'Privacy',
      children: [
        _buildSwitchTile(
          icon: Icons.leaderboard_outlined,
          title: 'Show in Leaderboard',
          subtitle: 'Appear in global rankings',
          value: _showInLeaderboard,
          onChanged: (value) => setState(() => _showInLeaderboard = value),
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.visibility_outlined,
          title: 'Profile Visibility',
          subtitle: _profileVisibility,
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => _showVisibilityDialog(),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'About',
      children: [
        _buildSettingsTile(
          icon: Icons.info_outline,
          title: 'App Version',
          subtitle: 'EcoDay v2.0.0',
          onTap: null,
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.help_outline,
          title: 'How It Works',
          subtitle: 'Learn about EcoDay features',
          onTap: () => _showComingSoonDialog('Tutorial'),
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.quiz_outlined,
          title: 'Help & FAQ',
          subtitle: 'Get answers to common questions',
          onTap: () => _showComingSoonDialog('FAQ'),
        ),
        _buildDivider(),
        _buildSettingsTile(
          icon: Icons.email_outlined,
          title: 'Contact Support',
          subtitle: 'support@ecoday.id',
          onTap: () => _showComingSoonDialog('Contact Support'),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2E2B),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2E2B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7A7B),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2E2B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7A7B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _showLogoutDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF5252),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, size: 20),
              SizedBox(width: 8),
              Text(
                'Keluar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((time) {
      if (time != null) {
        setState(() {
          _reminderTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  void _showVisibilityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Visibility'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('Public'),
              subtitle: const Text('Everyone can see your profile'),
              value: 'Public',
              groupValue: _profileVisibility,
              onChanged: (value) {
                setState(() => _profileVisibility = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('Private'),
              subtitle: const Text('Only you can see your profile'),
              value: 'Private',
              groupValue: _profileVisibility,
              onChanged: (value) {
                setState(() => _profileVisibility = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: Text('$feature feature will be available in the next update!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
