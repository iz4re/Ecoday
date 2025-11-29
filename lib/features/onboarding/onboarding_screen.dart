import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../auth/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Selamat Datang di EcoDay!',
      description: 'Platform quest yang membantumu berkontribusi untuk bumi dengan cara yang fun dan rewarding',
      emoji: '🌍',
      gradient: [Color(0xFF0B8F6E), Color(0xFF0ABF8A)],
    ),
    OnboardingData(
      title: 'Kerjakan Quest Harian',
      description: 'Selesaikan misi eco-friendly setiap hari, kumpulkan XP, dan naik level!',
      emoji: '✨',
      gradient: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
    ),
    OnboardingData(
      title: 'Ikuti Event Seru',
      description: 'Join challenge spesial, compete dengan sesama eco-warriors, dan raih hadiah keren',
      emoji: '🎯',
      gradient: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
    ),
    OnboardingData(
      title: 'Raih Reward Eksklusif',
      description: 'Tukarkan poin dengan voucher, unlock badges, dan dapatkan title spesial!',
      emoji: '🏆',
      gradient: [Color(0xFFFFA726), Color(0xFFFFD54F)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skipToAuth() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipToAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipToAuth,
                  child: Text(
                    _currentPage == _pages.length - 1 ? '' : 'Lewati',
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPage(data: _pages[index]);
                },
              ),
            ),
            
            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _PageIndicator(
                    isActive: index == _currentPage,
                    color: _pages[_currentPage].gradient[0],
                  ),
                ),
              ),
            ),
            
            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pages[_currentPage].gradient[0],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == _pages.length - 1 
                            ? 'Mulai Sekarang!' 
                            : 'Lanjut',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        _currentPage == _pages.length - 1 
                            ? Icons.rocket_launch 
                            : Icons.arrow_forward,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});

  final OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji/Icon with gradient background
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: data.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: data.gradient[0].withValues(alpha: 0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                data.emoji,
                style: const TextStyle(fontSize: 80),
              ),
            ),
          ),
          const SizedBox(height: 48),
          
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2E2B),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.textMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.isActive,
    required this.color,
  });

  final bool isActive;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String emoji;
  final List<Color> gradient;

  OnboardingData({
    required this.title,
    required this.description,
    required this.emoji,
    required this.gradient,
  });
}
