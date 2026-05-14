import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class EducationSection extends StatelessWidget {
  final AppStrings s;
  const EducationSection({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final hPad = isWide ? w * 0.08 : 28.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.cardBorder), bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RevealOnScroll(child: SectionHeader(label: s.eduLabel, title: s.eduTitle)),
        const SizedBox(height: 40),
        if (isWide)
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: s.educations.asMap().entries.map((e) => Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: e.key < s.educations.length - 1 ? 20 : 0),
              child: RevealOnScroll(delay: Duration(milliseconds: e.key * 150), child: _EduCard(edu: e.value, index: e.key)),
            ),
          )).toList())
        else
          ...s.educations.asMap().entries.map((e) => RevealOnScroll(
            delay: Duration(milliseconds: e.key * 150),
            child: _EduCard(edu: e.value, index: e.key),
          )),
      ]),
    );
  }
}

class _EduCard extends StatelessWidget {
  final Map<String, String> edu;
  final int index;
  const _EduCard({required this.edu, required this.index});

  @override
  Widget build(BuildContext context) {
    final isCyan = index.isOdd;
    final accent = isCyan ? AppColors.cyan : AppColors.gold;
    final subjects = edu['sub']!.split(' · ');

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.cardBorder)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 3, decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
          gradient: LinearGradient(colors: isCyan ? [AppColors.cyanDim, AppColors.cyan] : [AppColors.goldDim, AppColors.gold]),
        )),
        Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: accent.withOpacity(0.25))),
              child: Text(edu['period']!, style: TextStyle(color: accent, fontSize: 10, fontFamily: 'Courier', fontWeight: FontWeight.w600)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.gold.withOpacity(0.3))),
              child: Text(edu['detail']!, style: const TextStyle(color: AppColors.goldLight, fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 14),
          Text(edu['degree']!, style: const TextStyle(color: AppColors.white, fontSize: 17, fontWeight: FontWeight.w800, height: 1.2)),
          const SizedBox(height: 6),
          Text(edu['institution']!, style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),
          Wrap(spacing: 6, runSpacing: 6, children: subjects.map((sub) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: AppColors.greyDim.withOpacity(0.3), borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.greyDim.withOpacity(0.6))),
            child: Text(sub, style: const TextStyle(color: AppColors.grey, fontSize: 10, letterSpacing: 0.3)),
          )).toList()),
        ])),
      ]),
    );
  }
}
