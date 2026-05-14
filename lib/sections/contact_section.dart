import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/common.dart';
import '../l10n/app_strings.dart';

class ContactSection extends StatelessWidget {
  final AppStrings s;
  const ContactSection({super.key, required this.s});

  static const List<Map<String, String>> contactLinks = [
    {'icon': 'email', 'label': 'Email', 'value': 'princekumarthakur002@gmail.com', 'url': 'mailto:princekumarthakur002@gmail.com'},
    {'icon': 'linkedin', 'label': 'LinkedIn', 'value': 'Prince Kumar', 'url': 'https://www.linkedin.com/in/prince-kumar-069143329/'},
    {'icon': 'github', 'label': 'GitHub', 'value': 'HOSTERPRINCE', 'url': 'https://github.com/HOSTERPRINCE'},
  ];

  IconData _iconFor(String key) => switch (key) {
    'email' => Icons.alternate_email_rounded,
    'linkedin' => Icons.work_outline_rounded,
    'github' => Icons.terminal_rounded,
    _ => Icons.info_outline,
  };

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
        RevealOnScroll(child: SectionHeader(label: s.contactLabel, title: s.contactTitle)),
        const SizedBox(height: 20),
        RevealOnScroll(delay: const Duration(milliseconds: 100), child: SizedBox(
          width: isWide ? w * 0.5 : double.infinity,
          child: Text(s.contactSubtitle, style: const TextStyle(color: AppColors.grey, fontSize: 15, height: 1.75)),
        )),
        const SizedBox(height: 36),
        if (isWide)
          _buildWideLayout()
        else
          _buildMobileLayout(),
        const SizedBox(height: 60),
        RevealOnScroll(delay: const Duration(milliseconds: 500), child: _Footer(s: s)),
      ]),
    );
  }

  Widget _buildWideLayout() {
    return RevealOnScroll(delay: const Duration(milliseconds: 200), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Contact form (left)
      Expanded(flex: 3, child: _ContactForm(s: s)),
      const SizedBox(width: 40),
      // Contact links (right)
      Expanded(flex: 2, child: Column(children: contactLinks.asMap().entries.map((e) => _ContactTile(
        icon: _iconFor(e.value['icon']!), label: e.value['label']!, value: e.value['value']!, url: e.value['url']!, index: e.key,
      )).toList())),
    ]));
  }

  Widget _buildMobileLayout() {
    return Column(children: [
      RevealOnScroll(delay: const Duration(milliseconds: 200), child: _ContactForm(s: s)),
      const SizedBox(height: 36),
      ...contactLinks.asMap().entries.map((e) => RevealOnScroll(
        delay: Duration(milliseconds: 300 + e.key * 80),
        child: _ContactTile(icon: _iconFor(e.value['icon']!), label: e.value['label']!, value: e.value['value']!, url: e.value['url']!, index: e.key),
      )),
    ]);
  }
}

class _ContactForm extends StatefulWidget {
  final AppStrings s;
  const _ContactForm({required this.s});
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sent = false;
  bool _sending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    setState(() => _sending = true);

    try {
      // Using Web3Forms API — free 250 emails/month
      // Get your access key at https://web3forms.com (enter your email to receive it)
      const accessKey = '6a7fefe1-466f-4d80-b8b2-32688f964177';

      print('📧 Sending email via Web3Forms...');
      print('   Name: $name, Email: $email');

      final response = await http.post(
        Uri.parse('https://api.web3forms.com/submit'),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({
          'access_key': accessKey,
          'name': name,
          'email': email,
          'message': message,
          'subject': 'Portfolio Contact from $name',
        }),
      );

      print('📧 Response status: ${response.statusCode}');
      print('📧 Response body: ${response.body}');

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        setState(() {
          _sent = true;
          _sending = false;
        });
      } else {
        final errorMsg = result['message'] ?? 'Unknown error (status: ${response.statusCode})';
        print('❌ Web3Forms error: $errorMsg');
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('❌ Email send failed: $e');
      setState(() => _sending = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send: $e'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sent) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.gold.withOpacity(0.3))),
        child: Row(children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.gold, size: 28),
          const SizedBox(width: 14),
          Expanded(child: Text(widget.s.formSent, style: const TextStyle(color: AppColors.white, fontSize: 14, height: 1.5))),
        ]),
      );
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.cardBorder)),
      child: Column(children: [
        _FormField(hint: widget.s.formName, icon: Icons.person_outline_rounded, controller: _nameController),
        const SizedBox(height: 14),
        _FormField(hint: widget.s.formEmail, icon: Icons.alternate_email_rounded, controller: _emailController),
        const SizedBox(height: 14),
        _FormField(hint: widget.s.formMessage, icon: Icons.message_outlined, maxLines: 4, controller: _messageController),
        const SizedBox(height: 18),
        GestureDetector(
          onTap: _sending ? null : _sendEmail,
          child: Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              gradient: _sending
                  ? LinearGradient(colors: [AppColors.gold.withOpacity(0.5), AppColors.goldLight.withOpacity(0.5)])
                  : const LinearGradient(colors: [AppColors.gold, AppColors.goldLight]),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: AppColors.gold.withOpacity(0.25), blurRadius: 20, offset: const Offset(0, 6))],
            ),
            child: Center(
              child: _sending
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.bg),
                    )
                  : Text(widget.s.formSend, style: const TextStyle(color: AppColors.bg, fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
            ),
          ),
        ),
      ]),
    );
  }
}

class _FormField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextEditingController controller;
  const _FormField({required this.hint, required this.icon, this.maxLines = 1, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.cardBorder)),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint, hintStyle: TextStyle(color: AppColors.grey.withOpacity(0.5), fontSize: 13),
          prefixIcon: maxLines == 1 ? Icon(icon, color: AppColors.greyDim, size: 18) : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: maxLines > 1 ? 16 : 0, vertical: 14),
        ),
      ),
    );
  }
}

class _ContactTile extends StatefulWidget {
  final IconData icon; final String label, value, url; final int index;
  const _ContactTile({required this.icon, required this.label, required this.value, required this.url, required this.index});
  @override
  State<_ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<_ContactTile> {
  bool _pressed = false;

  Future<void> _openLink() async {
    html.window.open(widget.url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final isCyan = widget.index == 1;
    final accent = isCyan ? AppColors.cyan : AppColors.gold;
    return GestureDetector(
      onTap: _openLink,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 14), padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.card : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _pressed ? accent.withOpacity(0.4) : AppColors.cardBorder),
          boxShadow: _pressed ? [BoxShadow(color: accent.withOpacity(0.08), blurRadius: 20)] : [],
        ),
        child: Row(children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: accent.withOpacity(0.08), borderRadius: BorderRadius.circular(10), border: Border.all(color: accent.withOpacity(0.2))),
            child: Icon(widget.icon, color: accent, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.label.toUpperCase(), style: const TextStyle(color: AppColors.grey, fontSize: 10, letterSpacing: 2, fontFamily: 'Courier')),
              const SizedBox(height: 4),
              Text(widget.value, style: const TextStyle(color: AppColors.white, fontSize: 15, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
            ]),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.open_in_new_rounded, color: AppColors.greyDim, size: 15),
        ]),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final AppStrings s;
  const _Footer({required this.s});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.goldDim)),
        Container(width: 80, height: 1, margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldDim, Colors.transparent]))),
        Container(width: 6, height: 6, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold)),
        Container(width: 80, height: 1, margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, AppColors.goldDim, Colors.transparent]))),
        Container(width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.goldDim)),
      ]),
      const SizedBox(height: 24),
      const Text('© 2024 Prince Kumar', style: TextStyle(color: AppColors.greyDim, fontSize: 12, letterSpacing: 2, fontFamily: 'Courier')),
      const SizedBox(height: 6),
      Text(s.footerCraft, style: const TextStyle(color: AppColors.greyDim, fontSize: 11, letterSpacing: 0.5)),
    ]));
  }
}
