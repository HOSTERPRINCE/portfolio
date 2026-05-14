import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class AboutSection extends StatelessWidget {
  final AppStrings s;
  const AboutSection({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final hPad = isWide ? w * 0.08 : 28.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.cardBorder),
          bottom: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: isWide ? _buildWide() : _buildMobile(),
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: SectionHeader(label: s.aboutLabel, title: s.aboutTitle),
        ),
        const SizedBox(height: 32),
        RevealOnScroll(
          delay: const Duration(milliseconds: 150),
          child: _aboutText(),
        ),
        const SizedBox(height: 44),
        RevealOnScroll(
          delay: const Duration(milliseconds: 250),
          child: _statsRow(),
        ),
      ],
    );
  }

  Widget _buildWide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RevealOnScroll(
                child: SectionHeader(label: s.aboutLabel, title: s.aboutTitle),
              ),
              const SizedBox(height: 32),
              RevealOnScroll(
                delay: const Duration(milliseconds: 150),
                child: _aboutText(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),

        Expanded(
          flex: 2,
          child: RevealOnScroll(
            delay: const Duration(milliseconds: 250),
            slideFrom: const Offset(0.15, 0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _StatCard(number: '3+', label: s.statYears, useCyan: false),
                const SizedBox(height: 16),
                _StatCard(number: '20+', label: s.statProjects, useCyan: true),
                const SizedBox(height: 16),
                _StatCard(number: '6+', label: s.statTech, useCyan: false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _aboutText() => Text(
    s.aboutText,
    style: const TextStyle(
      color: AppColors.grey,
      fontSize: 16,
      height: 1.85,
      letterSpacing: 0.1,
    ),
  );

  Widget _statsRow() => Row(
    children: [
      Expanded(
        child: _StatCard(number: '3+', label: s.statYears, useCyan: false),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _StatCard(number: '20+', label: s.statProjects, useCyan: true),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _StatCard(number: '6+', label: s.statTech, useCyan: false),
      ),
    ],
  );
}

class _StatCard extends StatelessWidget {
  final String number, label;
  final bool useCyan;
  const _StatCard({
    required this.number,
    required this.label,
    required this.useCyan,
  });

  @override
  Widget build(BuildContext context) {
    final color = useCyan ? AppColors.cyan : AppColors.gold;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: color.withOpacity(0.05), blurRadius: 20)],
      ),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (b) => LinearGradient(
              colors: useCyan
                  ? [AppColors.cyan, AppColors.white]
                  : [AppColors.gold, AppColors.goldLight],
            ).createShader(b),
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 11,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
