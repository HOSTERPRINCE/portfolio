import 'package:flutter/material.dart';
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class HeroSection extends StatelessWidget {
  final double scrollOffset;
  final AppStrings s;
  final AppLocale locale;
  final ValueChanged<AppLocale> onLocaleChanged;
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key, required this.scrollOffset, required this.s,
    required this.locale, required this.onLocaleChanged,
    required this.onViewWork, required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 800;
    final parallax = scrollOffset * 0.4;
    final hPad = isWide ? w * 0.08 : 28.0;

    return SizedBox(
      height: h,
      child: Stack(clipBehavior: Clip.hardEdge, children: [
        Positioned.fill(child: CustomPaint(painter: GridPainter())),
        Positioned(top: -100, right: -100, child: Container(
          width: 420, height: 420,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [AppColors.gold.withOpacity(0.07), Colors.transparent])),
        )),
        Positioned(bottom: 60, left: -80, child: Container(
          width: 280, height: 280,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [AppColors.cyan.withOpacity(0.06), Colors.transparent])),
        )),
        const Positioned.fill(child: ParticlesWidget()),
        Positioned(top: 0, right: 60, bottom: 0, child: IgnorePointer(
          child: Transform.rotate(angle: 0.05, child: Container(
            width: 1, decoration: BoxDecoration(gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.goldDim.withOpacity(0.25), AppColors.gold.withOpacity(0.15), Colors.transparent],
            )),
          )),
        )),

        // Language switcher
        Positioned(top: 50, right: 20, child: FadeSlideIn(
          delay: const Duration(milliseconds: 200),
          child: _LangSwitcher(locale: locale, onChanged: onLocaleChanged),
        )),

        // Main content with parallax
        Positioned(top: 0, left: 0, right: 0, child: Transform.translate(
          offset: Offset(0, -parallax),
          child: Padding(padding: EdgeInsets.symmetric(horizontal: hPad),
            child: isWide ? _buildWideLayout(h, w) : _buildMobileLayout(h),
          ),
        )),

        // Bottom fade
        Positioned(bottom: 0, left: 0, right: 0, child: Container(
          height: 80, decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.transparent, AppColors.bg.withOpacity(0.9)],
          )),
        )),

        // Scroll indicator
        Positioned(bottom: 28, left: 0, right: 0, child: FadeSlideIn(
          delay: const Duration(milliseconds: 1300),
          child: Column(children: [
            const Text('SCROLL', style: TextStyle(color: AppColors.greyDim, fontSize: 9, letterSpacing: 4, fontFamily: 'Courier')),
            const SizedBox(height: 8),
            _ScrollArrow(),
          ]),
        )),
      ]),
    );
  }

  Widget _buildMobileLayout(double h) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: h * 0.14),
      _statusChip(), const SizedBox(height: 36),
      FadeSlideIn(delay: const Duration(milliseconds: 250), child: _avatarRow()),
      const SizedBox(height: 44),
      FadeSlideIn(delay: const Duration(milliseconds: 400), child: _headline()),
      const SizedBox(height: 24),
      _typewriterRow(), const SizedBox(height: 48),
      _ctaRow(),
    ]);
  }

  Widget _buildWideLayout(double h, double w) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // Left — text content
      Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: h * 0.22),
        _statusChip(), const SizedBox(height: 30),
        FadeSlideIn(delay: const Duration(milliseconds: 400), child: _headline(fontSize: 64)),
        const SizedBox(height: 20),
        _typewriterRow(), const SizedBox(height: 44),
        _ctaRow(),
      ])),
      const SizedBox(width: 60),
      // Right — avatar
      Expanded(flex: 2, child: FadeSlideIn(
        delay: const Duration(milliseconds: 500),
        child: Center(child: _GlowAvatar(size: 180)),
      )),
    ]);
  }

  Widget _statusChip() => FadeSlideIn(delay: const Duration(milliseconds: 100), child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(30), border: Border.all(color: AppColors.cardBorder)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 7, height: 7, decoration: BoxDecoration(
        color: const Color(0xFF22C55E), shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: const Color(0xFF22C55E).withOpacity(0.5), blurRadius: 6, spreadRadius: 1)],
      )),
      const SizedBox(width: 8),
      Text(s.heroAvailable, style: const TextStyle(color: AppColors.grey, fontSize: 12, letterSpacing: 0.3)),
    ]),
  ));

  Widget _avatarRow() => Row(children: [
    _GlowAvatar(size: 90),
    const SizedBox(width: 18),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('PRINCE KUMAR', style: TextStyle(color: AppColors.white, fontSize: 14, letterSpacing: 4, fontFamily: 'Courier', fontWeight: FontWeight.w600)),
      const SizedBox(height: 5),
      Text(s.heroLocation, style: const TextStyle(color: AppColors.grey, fontSize: 12, letterSpacing: 0.5)),
    ]),
  ]);

  Widget _headline({double fontSize = 46}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(s.heroHeadline1, style: TextStyle(color: AppColors.white, fontSize: fontSize, fontWeight: FontWeight.w900, height: 1.0, letterSpacing: -2)),
    Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
      ShaderMask(
        shaderCallback: (b) => const LinearGradient(colors: [AppColors.gold, AppColors.goldLight, AppColors.cyan], stops: [0, 0.6, 1]).createShader(b),
        child: Text(s.heroHeadline2, style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.w900, height: 1.0, letterSpacing: -2)),
      ),
      Text(' .', style: TextStyle(color: AppColors.cyan, fontSize: fontSize, fontWeight: FontWeight.w900, height: 1.0)),
    ]),
  ]);

  Widget _typewriterRow() => FadeSlideIn(delay: const Duration(milliseconds: 700), child: Row(children: [
    const Text('— ', style: TextStyle(color: AppColors.goldDim, fontSize: 16)),
    TypewriterText(texts: s.roles, style: const TextStyle(color: AppColors.gold, fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.5, fontFamily: 'Courier')),
  ]));

  Widget _ctaRow() => FadeSlideIn(delay: const Duration(milliseconds: 900), child: Row(children: [
    _CTAButton(label: s.heroViewWork, isPrimary: true, onTap: onViewWork),
    const SizedBox(width: 14),
    _CTAButton(label: s.heroContact, isPrimary: false, onTap: onContact),
  ]));
}

class _LangSwitcher extends StatelessWidget {
  final AppLocale locale;
  final ValueChanged<AppLocale> onChanged;
  const _LangSwitcher({required this.locale, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: AppColors.card.withOpacity(0.9), borderRadius: BorderRadius.circular(30), border: Border.all(color: AppColors.cardBorder)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        for (final l in AppLocale.values)
          GestureDetector(onTap: () => onChanged(l), child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: locale == l ? AppColors.gold.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: locale == l ? AppColors.gold.withOpacity(0.5) : Colors.transparent),
            ),
            child: Text(l.name.toUpperCase(), style: TextStyle(
              color: locale == l ? AppColors.gold : AppColors.grey, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5, fontFamily: 'Courier',
            )),
          )),
      ]),
    );
  }
}

class _GlowAvatar extends StatelessWidget {
  final double size;
  const _GlowAvatar({this.size = 90});
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, gradient: SweepGradient(colors: [AppColors.gold, AppColors.cyan, AppColors.gold]))),
      Container(width: size - 6, height: size - 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.bg)),
      CircleAvatar(radius: size * 0.42, backgroundImage: const AssetImage('assets/images/profile.jpg')),
    ]);
  }
}

class _ScrollArrow extends StatefulWidget {
  @override
  State<_ScrollArrow> createState() => _ScrollArrowState();
}
class _ScrollArrowState extends State<_ScrollArrow> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _anim, builder: (_, __) => Transform.translate(
      offset: Offset(0, _anim.value * 6),
      child: Column(children: [
        Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gold.withOpacity(0.4 + _anim.value * 0.5), size: 22),
        Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gold.withOpacity(0.2 + _anim.value * 0.3), size: 16),
      ]),
    ));
  }
}

class _CTAButton extends StatefulWidget {
  final String label; final bool isPrimary; final VoidCallback onTap;
  const _CTAButton({required this.label, required this.isPrimary, required this.onTap});
  @override
  State<_CTAButton> createState() => _CTAButtonState();
}
class _CTAButtonState extends State<_CTAButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(scale: _pressed ? 0.95 : 1.0, duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            gradient: widget.isPrimary ? const LinearGradient(colors: [AppColors.gold, AppColors.goldLight]) : null,
            color: widget.isPrimary ? null : Colors.transparent,
            border: Border.all(color: widget.isPrimary ? Colors.transparent : AppColors.greyDim),
            borderRadius: BorderRadius.circular(6),
            boxShadow: widget.isPrimary ? [BoxShadow(color: AppColors.gold.withOpacity(0.25), blurRadius: 20, offset: const Offset(0, 6))] : [],
          ),
          child: Text(widget.label, style: TextStyle(color: widget.isPrimary ? AppColors.bg : AppColors.grey, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
        ),
      ),
    );
  }
}
