import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';

class DriverActiveOrderScreen extends StatefulWidget {
  const DriverActiveOrderScreen({super.key});

  @override
  State<DriverActiveOrderScreen> createState() => _DriverActiveOrderScreenState();
}

enum _Stage { pickedUp, inProgress, completed }

class _DriverActiveOrderScreenState extends State<DriverActiveOrderScreen> {
  _Stage _stage = _Stage.pickedUp;

  void _advance() {
    switch (_stage) {
      case _Stage.pickedUp:
        setState(() => _stage = _Stage.inProgress);
      case _Stage.inProgress:
        setState(() => _stage = _Stage.completed);
      case _Stage.completed:
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = switch (_stage) { _Stage.pickedUp => 0, _Stage.inProgress => 1, _Stage.completed => 2 };
    final buttonLabel = switch (_stage) {
      _Stage.pickedUp => 'Mulai Perjalanan',
      _Stage.inProgress => 'Selesaikan Pesanan',
      _Stage.completed => 'Kembali ke Pesanan Masuk',
    };

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFDFF6E9), Color(0xFFCFF0E0)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: const Center(child: Icon(Icons.map_outlined, size: 44, color: AppColors.primary)),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            _stage == _Stage.pickedUp ? 'Menuju Lokasi Jemput' : 'Menuju Lokasi Antar',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                          ),
                        ),
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
              transform: Matrix4.translationValues(0, -24, 0),
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(color: const Color(0xFFF0F1EE), shape: BoxShape.circle),
                          child: const Icon(Icons.person_outline, color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Maria Dewi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                              Text('Penumpang · 3 pesanan bersama', style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(11)),
                          child: const Icon(Icons.call, color: AppColors.primaryDark, size: 17),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            _Dot(color: AppColors.primary, circle: true),
                            SizedBox(width: 10),
                            Text('Jl. Merdeka No. 12', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(left: 3.5), child: Container(width: 1, height: 16, color: AppColors.border)),
                        Row(
                          children: const [
                            _Dot(color: AppColors.textPrimary, circle: false),
                            SizedBox(width: 10),
                            Text('Jl. Asia Afrika No. 8', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _MiniStepper(activeIndex: activeIndex),
                  const Spacer(),
                  PrimaryButton(label: buttonLabel, onPressed: _advance),
                  if (_stage != _Stage.completed) ...[
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Batalkan Pesanan', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.danger)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color, required this.circle});

  final Color color;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: circle ? BoxShape.circle : BoxShape.rectangle, borderRadius: circle ? null : BorderRadius.circular(2)));
  }
}

class _MiniStepper extends StatelessWidget {
  const _MiniStepper({required this.activeIndex});

  final int activeIndex;
  static const _labels = ['Dijemput', 'Dalam Perjalanan', 'Selesai'];

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
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: done || current ? AppColors.primary : AppColors.border,
                shape: BoxShape.circle,
                boxShadow: current ? [const BoxShadow(color: AppColors.primarySoft, blurRadius: 0, spreadRadius: 4)] : null,
              ),
              child: done ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
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
