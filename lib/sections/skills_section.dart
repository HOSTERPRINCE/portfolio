import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class SkillsSection extends StatelessWidget {
  final AppStrings s;
  const SkillsSection({super.key, required this.s});

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'Frontend',
      'icon': Icons.web_rounded,
      'color': 'gold',
      'skills': ['Flutter', 'Jetpack Compose', 'HTML', 'CSS', 'Tailwind', 'XML', 'JavaScript', 'React'],
    },
    {
      'name': 'Backend',
      'icon': Icons.dns_rounded,
      'color': 'cyan',
      'skills': ['Firebase', 'Supabase', 'Node.js'],
    },
    {
      'name': 'Databases',
      'icon': Icons.storage_rounded,
      'color': 'gold',
      'skills': ['Firestore', 'SQL', 'MongoDB', 'Hive', 'SQLite'],
    },
    {
      'name': 'Storage',
      'icon': Icons.cloud_upload_rounded,
      'color': 'cyan',
      'skills': ['Cloudinary', 'Firebase Storage'],
    },
    {
      'name': 'Tools',
      'icon': Icons.build_rounded,
      'color': 'gold',
      'skills': ['VS Code', 'Android Studio', 'Git', 'GitHub', 'IntelliJ'],
    },
    {
      'name': 'Languages',
      'icon': Icons.code_rounded,
      'color': 'cyan',
      'skills': ['Python', 'C', 'Dart', 'Kotlin', 'Java'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final hPad = isWide ? w * 0.08 : 28.0;

    return Container(
      color: AppColors.bg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: SectionHeader(label: s.skillsLabel, title: s.skillsTitle),
          ),
          const SizedBox(height: 48),
          if (isWide)
            _buildWideLayout()
          else
            _buildMobileLayout(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _categories.asMap().entries.map((entry) {
        return RevealOnScroll(
          delay: Duration(milliseconds: entry.key * 100),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _SkillCategory(category: entry.value),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWideLayout() {
    final half = (_categories.length / 2).ceil();
    final left = _categories.sublist(0, half);
    final right = _categories.sublist(half);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: left.asMap().entries.map((entry) {
              return RevealOnScroll(
                delay: Duration(milliseconds: entry.key * 120),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _SkillCategory(category: entry.value),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: right.asMap().entries.map((entry) {
              return RevealOnScroll(
                delay: Duration(milliseconds: (entry.key + half) * 120),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _SkillCategory(category: entry.value),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final Map<String, dynamic> category;
  const _SkillCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    final isCyan = category['color'] == 'cyan';
    final accentColor = isCyan ? AppColors.cyan : AppColors.gold;
    final skills = category['skills'] as List<String>;
    final icon = category['icon'] as IconData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category header
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: accentColor.withOpacity(0.25),
                ),
              ),
              child: Icon(icon, color: accentColor, size: 16),
            ),
            const SizedBox(width: 12),
            Text(
              category['name'],
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                fontFamily: 'Courier',
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accentColor.withOpacity(0.2),
                ),
              ),
              child: Text(
                '${skills.length}',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Courier',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Skill chips
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills.map((skill) => _SkillChip(
            skillName: skill,
            accentColor: accentColor,
          )).toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skillName;
  final Color accentColor;
  const _SkillChip({required this.skillName, required this.accentColor});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.accentColor.withOpacity(0.12)
              : AppColors.card.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withOpacity(0.5)
                : AppColors.cardBorder.withOpacity(0.6),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.skillName,
          style: TextStyle(
            color: _isHovered
                ? widget.accentColor
                : AppColors.white.withOpacity(0.7),
            fontSize: 13,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.5,
            fontFamily: 'Courier',
          ),
        ),
      ),
    );
  }
}
