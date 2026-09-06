import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/format.dart';

class AdminPricingScreen extends StatelessWidget {
  const AdminPricingScreen({super.key});

  static const _icons = {'Motor': Icons.two_wheeler, 'Mobil': Icons.directions_car, 'Makanan': Icons.fastfood_outlined};
  static const _colors = {
    'Motor': (AppColors.primaryDark, AppColors.primarySoft),
    'Mobil': (AppColors.info, AppColors.infoSoft),
    'Makanan': (AppColors.warning, AppColors.warningSoft),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Tarif', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aturan tarif baru ditambahkan'))),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        children: [
          for (final rule in pricingRules) ...[
            _PricingTile(rule: rule),
            const SizedBox(height: 12),
          ],
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Aturan tarif baru ditambahkan'))),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border, width: 1.5)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 16, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text('Tambah Aturan Tarif', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PricingTile extends StatelessWidget {
  const _PricingTile({required this.rule});

  final PricingRule rule;

  @override
  Widget build(BuildContext context) {
    final icon = AdminPricingScreen._icons[rule.vehicle]!;
    final (fg, bg) = AdminPricingScreen._colors[rule.vehicle]!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(11)),
                child: Icon(icon, color: fg, size: 19),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(rule.vehicle, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800))),
              const Icon(Icons.edit_outlined, size: 16, color: AppColors.textSecondary),
            ],
          ),
          const Divider(height: 24, color: AppColors.border),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tarif dasar', style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    Text(formatRupiah(rule.baseFare), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rule.secondaryLabel, style: const TextStyle(fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    Text(rule.secondaryValue, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
