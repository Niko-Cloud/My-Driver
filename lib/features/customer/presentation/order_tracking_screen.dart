import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/rating_stars.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFDFF6E9), Color(0xFFCFF0E0)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: const Center(child: Icon(Icons.map_outlined, size: 46, color: AppColors.primary)),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        _RoundIconButton(icon: Icons.arrow_back, onTap: () => Navigator.of(context).pop()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              transform: Matrix4.translationValues(0, -28, 0),
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Driver sedang menuju lokasimu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  const Text('Tiba dalam 6 menit', style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 18),
                  const _StatusStepper(activeIndex: 2),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(color: const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.two_wheeler, color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Andi Prasetyo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Row(
                                children: const [
                                  RatingStars(rating: 4.9, size: 12),
                                  SizedBox(width: 4),
                                  Text('4.9 · Honda Beat · D 4021 XA', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _RoundIconButton(icon: Icons.call, onTap: () {}, filled: true),
                        const SizedBox(width: 8),
                        _RoundIconButton(icon: Icons.chat_bubble_outline, onTap: () {}, filled: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                      child: const Text('Batalkan Pesanan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.danger)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusStepper extends StatelessWidget {
  const _StatusStepper({required this.activeIndex});

  final int activeIndex;

  static const _labels = ['Diterima', 'Dijemput', 'Perjalanan', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(_labels.length * 2 - 1, (i) {
            if (i.isOdd) {
              final done = (i ~/ 2) < activeIndex;
              return Expanded(child: Container(height: 3, color: done ? AppColors.primary : AppColors.border));
            }
            final stepIndex = i ~/ 2;
            final done = stepIndex < activeIndex;
            final current = stepIndex == activeIndex;
            return Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: done || current ? AppColors.primary : AppColors.border,
                shape: BoxShape.circle,
                boxShadow: current ? [const BoxShadow(color: AppColors.primarySoft, blurRadius: 0, spreadRadius: 4)] : null,
              ),
              child: done
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : current
                      ? Center(child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)))
                      : null,
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [for (final l in _labels) Text(l, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: AppColors.textSecondary))],
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap, this.filled = false});

  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: filled ? AppColors.primarySoft : Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: filled ? null : [const BoxShadow(color: Color(0x1A000000), blurRadius: 6)]),
        child: Icon(icon, size: 18, color: AppColors.primaryDark),
      ),
    );
  }
}
