import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'l10n/app_strings.dart';
import 'widgets/common.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/education_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/achievements_section.dart';
import 'sections/contact_section.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatefulWidget {
  const MyPortfolioApp({super.key});
  @override
  State<MyPortfolioApp> createState() => _MyPortfolioAppState();
}

class _MyPortfolioAppState extends State<MyPortfolioApp> {
  AppLocale _locale = AppLocale.en;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prince Kumar — Portfolio',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Georgia',
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gold,
          surface: AppColors.surface,
        ),
      ),
      home: PortfolioPage(
        locale: _locale,
        onLocaleChanged: (l) => setState(() => _locale = l),
      ),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  final AppLocale locale;
  final ValueChanged<AppLocale> onLocaleChanged;
  const PortfolioPage({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scroll = ScrollController();
  double _scrollOffset = 0;
  double _maxScroll = 1;

  // Section keys for navigation
  final _aboutKey = GlobalKey();
  final _eduKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _achieveKey = GlobalKey();
  final _contactKey = GlobalKey();

  int _activeSection = 0;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scroll.offset;
      _maxScroll = _scroll.position.maxScrollExtent.clamp(1, double.infinity);
      _activeSection = _calcActiveSection();
    });
  }

  int _calcActiveSection() {
    final keys = [
      _aboutKey,
      _eduKey,
      _skillsKey,
      _projectsKey,
      _achieveKey,
      _contactKey,
    ];
    final screenH = MediaQuery.of(context).size.height;
    if (_scrollOffset < screenH * 0.5) return 0;
    for (int i = keys.length - 1; i >= 0; i--) {
      final box = keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy < screenH * 0.5) return i + 1;
    }
    return 0;
  }

  void _scrollToSection(int index) {
    final keys = [
      null,
      _aboutKey,
      _eduKey,
      _skillsKey,
      _projectsKey,
      _achieveKey,
      _contactKey,
    ];
    if (index == 0) {
      _scroll.animateTo(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
      );
      return;
    }
    final key = keys[index];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings(widget.locale);
    final progress = (_scrollOffset / _maxScroll).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scroll,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: HeroSection(
                  scrollOffset: _scrollOffset,
                  s: s,
                  locale: widget.locale,
                  onLocaleChanged: widget.onLocaleChanged,
                  onViewWork: () => _scrollToSection(4),
                  onContact: () => _scrollToSection(6),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _aboutKey,
                  child: AboutSection(s: s),
                ),
              ),

              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _eduKey,
                  child: EducationSection(s: s),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _skillsKey,
                  child: SkillsSection(s: s),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _projectsKey,
                  child: ProjectsSection(s: s),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _achieveKey,
                  child: AchievementsSection(s: s),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _contactKey,
                  child: ContactSection(s: s),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _scrollOffset > 50 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: 3,
                alignment: Alignment.centerLeft,
                color: AppColors.bg.withOpacity(0.8),
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.goldDim,
                          AppColors.gold,
                          AppColors.cyan,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(color: Color(0x55D4A853), blurRadius: 6),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (_scrollOffset > MediaQuery.of(context).size.height * 0.8)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: _SectionNavPill(
                  labels: s.sectionLabels,
                  active: _activeSection,
                  onTap: _scrollToSection,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionNavPill extends StatelessWidget {
  final List<String> labels;
  final int active;
  final ValueChanged<int> onTap;
  const _SectionNavPill({
    required this.labels,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.card.withOpacity(0.95),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: labels.asMap().entries.map((e) {
            final isActive = e.key == active;
            return GestureDetector(
              onTap: () => onTap(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.gold.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  e.value,
                  style: TextStyle(
                    color: isActive ? AppColors.gold : AppColors.grey,
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
