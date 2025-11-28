import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import 'widgets/eco_input_field.dart';
import 'widgets/eco_primary_button.dart';
import 'widgets/info_pill.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0FFF2), Color(0xFFF5FFFA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth > 420
                  ? 400.0
                  : constraints.maxWidth - 24;
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 32,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLogoSection(),
                        const SizedBox(height: 18),
                        const Text(
                          'Quest your way to a greener planet',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _AuthCard(
                          isLogin: isLogin,
                          onTabChanged: (value) {
                            setState(() => isLogin = value);
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'EcoDay v2.0 • Quest System with Authentication',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.secondaryGreen, AppTheme.primaryGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Icon(Icons.eco_outlined, color: Colors.white, size: 42),
        ),
        const SizedBox(height: 18),
        Text(
          'EcoDay',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppTheme.primaryGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AuthCard extends StatelessWidget {
  const _AuthCard({required this.isLogin, required this.onTabChanged});

  final bool isLogin;
  final ValueChanged<bool> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 50,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: Column(
        children: [
          _TabSwitcher(isLogin: isLogin, onChanged: onTabChanged),
          const SizedBox(height: 26),
          AnimatedCrossFade(
            firstChild: _RegisterForm(),
            secondChild: _LoginForm(),
            crossFadeState: isLogin
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  const _TabSwitcher({required this.isLogin, required this.onChanged});

  final bool isLogin;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppTheme.primaryGreen;
    final inactiveColor = AppTheme.textMuted;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 54,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F8F6),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: isLogin
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: IgnorePointer(
                  child: Container(
                    width: (constraints.maxWidth - 8) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => onChanged(false),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 18,
                              color: !isLogin ? activeColor : inactiveColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daftar',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: !isLogin ? activeColor : inactiveColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () => onChanged(true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 18,
                              color: isLogin ? activeColor : inactiveColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Masuk',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isLogin ? activeColor : inactiveColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EcoInputField(
          label: 'Email atau Username',
          hint: 'email@example.com atau username',
          icon: Icons.mail_outline,
        ),
        const SizedBox(height: 16),
        const EcoInputField(
          label: 'Password',
          hint: 'Masukkan password',
          icon: Icons.lock_outline,
          obscure: true,
        ),
        const SizedBox(height: 24),
        const Center(child: EcoPrimaryButton(label: 'Masuk ke Akun', icon: Icons.eco)),
        const SizedBox(height: 18),
        const InfoPill(
          title: 'Database Mode',
          subtitle: 'Data tersimpan di Supabase database',
          icon: Icons.auto_awesome,
          iconColor: AppTheme.accentYellow,
        ),
      ],
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        EcoInputField(
          label: 'Nama Lengkap',
          hint: 'Masukkan nama lengkap',
          icon: Icons.person_outline,
        ),
        SizedBox(height: 16),
        EcoInputField(
          label: 'Username',
          hint: 'username_unik',
          icon: Icons.alternate_email,
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            '3-20 karakter, huruf, angka, dan underscore',
            style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
          ),
        ),
        SizedBox(height: 16),
        EcoInputField(
          label: 'Email',
          hint: 'email@example.com',
          icon: Icons.mail_outline,
        ),
        SizedBox(height: 16),
        EcoInputField(
          label: 'Password',
          hint: 'Minimal 6 karakter',
          icon: Icons.lock_outline,
          obscure: true,
        ),
        SizedBox(height: 16),
        EcoInputField(
          label: 'Konfirmasi Password',
          hint: 'Ulangi password',
          icon: Icons.lock_reset,
          obscure: true,
        ),
        SizedBox(height: 24),
        Center(
          child: EcoPrimaryButton(
            label: 'Mulai Petualangan Eco',
            icon: Icons.auto_awesome,
          ),
        ),
      ],
    );
  }
}
