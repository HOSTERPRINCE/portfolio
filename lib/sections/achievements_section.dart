import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class AchievementsSection extends StatelessWidget {
  final AppStrings s;
  const AchievementsSection({super.key, required this.s});

  IconData _iconFor(String key) => switch (key) {
    'trophy' => Icons.emoji_events_rounded,
    'star' => Icons.star_rounded,
    'people' => Icons.people_rounded,
    'code' => Icons.code_rounded,
    'school' => Icons.school_rounded,
    'hub' => Icons.hub_rounded,
    _ => Icons.emoji_events_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final hPad = isWide ? w * 0.08 : 28.0;
    final cols = w > 1100 ? 3 : (isWide ? 3 : 2);

    return Container(
      color: AppColors.bg,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RevealOnScroll(child: SectionHeader(label: s.achieveLabel, title: s.achieveTitle)),
        const SizedBox(height: 40),
        GridView.count(
          crossAxisCount: cols,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: isWide ? 1.6 : 1.1,
          children: s.achievements.asMap().entries.map((e) {
            final a = e.value;
            final isCyan = e.key.isOdd;
            final accent = isCyan ? AppColors.cyan : AppColors.gold;
            return RevealOnScroll(
              delay: Duration(milliseconds: e.key * 80),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [BoxShadow(color: accent.withOpacity(0.04), blurRadius: 16)],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: accent.withOpacity(0.25))),
                    child: Icon(_iconFor(a['icon']!), color: accent, size: 20),
                  ),
                  const SizedBox(height: 14),
                  Text(a['title']!, style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w800, height: 1.2)),
                  const SizedBox(height: 4),
                  Text(a['sub']!, style: const TextStyle(color: AppColors.grey, fontSize: 11, height: 1.4)),
                ]),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
