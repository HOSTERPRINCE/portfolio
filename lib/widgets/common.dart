import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ─── Theme Constants ──────────────────────────────────────────────────────────
class AppColors {
  static const bg         = Color(0xFF06080E);
  static const surface    = Color(0xFF0C0F18);
  static const card       = Color(0xFF111520);
  static const cardBorder = Color(0xFF1E2438);
  static const gold       = Color(0xFFD4A853);
  static const goldLight  = Color(0xFFF0CC80);
  static const goldDim    = Color(0xFF7A5A1A);
  static const white      = Color(0xFFF2EFE8);
  static const grey       = Color(0xFF7A8096);
  static const greyDim    = Color(0xFF2E3348);
  static const cyan       = Color(0xFF22D3EE);
  static const cyanDim    = Color(0xFF0E4F5E);
}

// ─── Particle System ──────────────────────────────────────────────────────────
class Particle {
  double x, y, size, speed, opacity, vx, vy;
  Particle(double w, double h)
      : x = math.Random().nextDouble() * w,
        y = math.Random().nextDouble() * h,
        size = math.Random().nextDouble() * 2 + 0.5,
        speed = math.Random().nextDouble() * 0.4 + 0.1,
        opacity = math.Random().nextDouble() * 0.5 + 0.1,
        vx = (math.Random().nextDouble() - 0.5) * 0.3,
        vy = -(math.Random().nextDouble() * 0.3 + 0.1);
  void update(double w, double h) {
    x += vx; y += vy;
    if (y < -10) y = h + 10;
    if (x < -10) x = w + 10;
    if (x > w + 10) x = -10;
  }
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  ParticlesPainter(this.particles);
  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      canvas.drawCircle(
        Offset(p.x, p.y), p.size,
        Paint()..color = AppColors.gold.withOpacity(p.opacity * 0.6),
      );
    }
  }
  @override
  bool shouldRepaint(covariant ParticlesPainter old) => true;
}

class ParticlesWidget extends StatefulWidget {
  const ParticlesWidget({super.key});
  @override
  State<ParticlesWidget> createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  List<Particle> _particles = [];
  bool _init = false;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
    _ctrl.addListener(() {
      for (var p in _particles) p.update(400, 700);
      setState(() {});
    });
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      if (!_init) {
        _particles = List.generate(60, (_) => Particle(c.maxWidth, c.maxHeight));
        _init = true;
      }
      return CustomPaint(painter: ParticlesPainter(_particles));
    });
  }
}

// ─── Grid Painter ─────────────────────────────────────────────────────────────
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.greyDim.withOpacity(0.12)..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 60) canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    for (double y = 0; y < size.height; y += 60) canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ─── Typewriter ───────────────────────────────────────────────────────────────
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  const TypewriterText({super.key, required this.texts, required this.style});
  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayed = '';
  int _textIndex = 0, _charIndex = 0;
  bool _deleting = false, _pausing = false, _showCursor = true;
  Timer? _timer, _cursorTimer;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
    _schedule(const Duration(milliseconds: 110));
  }

  @override
  void didUpdateWidget(TypewriterText old) {
    super.didUpdateWidget(old);
    if (old.texts != widget.texts) {
      _textIndex = 0; _charIndex = 0; _displayed = ''; _deleting = false; _pausing = false;
      _schedule(const Duration(milliseconds: 110));
    }
  }

  void _schedule(Duration d) { _timer?.cancel(); _timer = Timer(d, _tick); }

  void _tick() {
    if (!mounted || _pausing) return;
    final cur = widget.texts[_textIndex];
    if (!_deleting) {
      if (_charIndex < cur.length) {
        setState(() => _displayed = cur.substring(0, ++_charIndex));
        _schedule(const Duration(milliseconds: 110));
      } else {
        _pausing = true;
        Timer(const Duration(milliseconds: 2200), () {
          if (!mounted) return;
          _pausing = false; _deleting = true;
          _schedule(const Duration(milliseconds: 55));
        });
      }
    } else {
      if (_charIndex > 0) {
        setState(() => _displayed = cur.substring(0, --_charIndex));
        _schedule(const Duration(milliseconds: 55));
      } else {
        _deleting = false;
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _schedule(const Duration(milliseconds: 300));
      }
    }
  }

  @override
  void dispose() { _timer?.cancel(); _cursorTimer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(style: widget.style, children: [
      TextSpan(text: _displayed),
      WidgetSpan(child: AnimatedOpacity(
        opacity: _showCursor ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 120),
        child: Text('|', style: widget.style.copyWith(color: AppColors.cyan, fontWeight: FontWeight.w300)),
      )),
    ]));
  }
}

// ─── Reveal On Scroll ─────────────────────────────────────────────────────────
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Offset slideFrom;
  const RevealOnScroll({super.key, required this.child, this.delay = Duration.zero, this.slideFrom = const Offset(0, 0.12)});
  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut).drive(Tween(begin: 0.0, end: 1.0));
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic).drive(Tween(begin: widget.slideFrom, end: Offset.zero));
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    Future.delayed(widget.delay, () { if (mounted) _ctrl.forward(); });
  }

  void _check() {
    if (_triggered) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;
    final pos = box.localToGlobal(Offset.zero);
    if (pos.dy < MediaQuery.of(context).size.height * 0.95) _trigger();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) { _check(); return false; },
      child: Builder(builder: (ctx) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _check());
        return FadeTransition(opacity: _opacity, child: SlideTransition(position: _slide, child: widget.child));
      }),
    );
  }
}

// ─── FadeSlideIn ──────────────────────────────────────────────────────────────
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const FadeSlideIn({super.key, required this.child, this.delay = Duration.zero});
  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut).drive(Tween(begin: 0.0, end: 1.0));
    _slide = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic).drive(Tween(begin: const Offset(0, 0.08), end: Offset.zero));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.forward(); });
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => FadeTransition(opacity: _opacity, child: SlideTransition(position: _slide, child: widget.child));
}

// ─── Gold Divider ─────────────────────────────────────────────────────────────
class GoldDivider extends StatelessWidget {
  final double width;
  const GoldDivider({super.key, this.width = 60});
  @override
  Widget build(BuildContext context) {
    return Container(width: width, height: 1.5, decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Colors.transparent, AppColors.gold, AppColors.cyan, Colors.transparent], stops: [0, 0.3, 0.7, 1]),
      borderRadius: BorderRadius.circular(2),
    ));
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String label, title;
  const SectionHeader({super.key, required this.label, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.cyan, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: AppColors.cyan, fontSize: 10, letterSpacing: 4, fontFamily: 'Courier', fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 12),
      Text(title, style: const TextStyle(color: AppColors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: -1, height: 1.1)),
      const SizedBox(height: 16),
      const GoldDivider(),
    ]);
  }
}

// ─── Glass Card ───────────────────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool highlight;
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(24), this.highlight = false});
  @override
  Widget build(BuildContext context) {
    return Container(padding: padding, decoration: BoxDecoration(
      color: AppColors.card.withOpacity(0.7),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: highlight ? AppColors.gold.withOpacity(0.35) : AppColors.cardBorder.withOpacity(0.6)),
      boxShadow: [BoxShadow(color: highlight ? AppColors.gold.withOpacity(0.06) : Colors.black.withOpacity(0.3), blurRadius: 24)],
    ), child: child);
  }
}
