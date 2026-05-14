import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class ProjectsSection extends StatelessWidget {
  final AppStrings s;
  const ProjectsSection({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final hPad = isWide ? w * 0.08 : 28.0;
    final cols = w > 1100 ? 3 : (isWide ? 2 : 1);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.cardBorder), bottom: BorderSide(color: AppColors.cardBorder)),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 80),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RevealOnScroll(child: SectionHeader(label: s.projectsLabel, title: s.projectsTitle)),
        const SizedBox(height: 40),
        if (cols > 1)
          _buildGrid(cols)
        else
          ...s.projects.asMap().entries.map((e) => RevealOnScroll(
            delay: Duration(milliseconds: e.key * 100),
            child: _ProjectCard(project: e.value, viewLabel: s.viewProject),
          )),
      ]),
    );
  }

  Widget _buildGrid(int cols) {
    final projects = s.projects;
    return Wrap(spacing: 20, runSpacing: 20, children: projects.asMap().entries.map((e) {
      return LayoutBuilder(builder: (ctx, constraints) {
        final cardWidth = (constraints.maxWidth - (cols - 1) * 20) / cols;
        return SizedBox(
          width: cardWidth,
          child: RevealOnScroll(
            delay: Duration(milliseconds: e.key * 100),
            child: _ProjectCard(project: e.value, viewLabel: s.viewProject),
          ),
        );
      });
    }).toList());
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, String> project;
  final String viewLabel;
  const _ProjectCard({required this.project, required this.viewLabel});
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isCyan = widget.project['color'] == 'cyan';
    final accent = isCyan ? AppColors.cyan : AppColors.gold;
    final techs = widget.project['tech']!.split(' · ');

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(scale: _pressed ? 0.97 : 1.0, duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: _pressed ? AppColors.card.withOpacity(0.95) : AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _pressed ? accent.withOpacity(0.5) : AppColors.cardBorder),
            boxShadow: _pressed ? [BoxShadow(color: accent.withOpacity(0.12), blurRadius: 30, spreadRadius: 2)] : [],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(height: 3, decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              gradient: LinearGradient(colors: isCyan ? [AppColors.cyanDim, AppColors.cyan] : [AppColors.goldDim, AppColors.gold]),
            )),
            Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('PROJECT ${widget.project['tag']}', style: TextStyle(color: accent.withOpacity(0.5), fontSize: 10, fontFamily: 'Courier', letterSpacing: 2.5)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: accent.withOpacity(0.25))),
                  child: Text(widget.project['impact']!, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ]),
              const SizedBox(height: 14),
              Text(widget.project['title']!, style: const TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.1)),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 6, children: techs.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: accent.withOpacity(0.08), borderRadius: BorderRadius.circular(4), border: Border.all(color: accent.withOpacity(0.2))),
                child: Text(t.trim(), style: TextStyle(color: accent, fontSize: 10, fontFamily: 'Courier', letterSpacing: 0.5, fontWeight: FontWeight.w600)),
              )).toList()),
              const SizedBox(height: 16),
              Text(widget.project['description']!, style: const TextStyle(color: AppColors.grey, fontSize: 14, height: 1.7)),
              const SizedBox(height: 20),
              Row(children: [
                Text(widget.viewLabel, style: TextStyle(color: accent, fontSize: 10, letterSpacing: 2.5, fontFamily: 'Courier', fontWeight: FontWeight.w700)),
                const SizedBox(width: 10),
                Expanded(child: Container(height: 1, decoration: BoxDecoration(gradient: LinearGradient(colors: [accent, Colors.transparent])))),
                const SizedBox(width: 8),
                Icon(Icons.north_east_rounded, color: accent, size: 15),
              ]),
            ])),
          ]),
        ),
      ),
    );
  }
}
