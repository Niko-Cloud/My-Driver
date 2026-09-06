import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/primary_button.dart';
import 'order_tracking_screen.dart';

enum _Vehicle { motor, mobil, makanan }

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  _Vehicle _vehicle = _Vehicle.motor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Pesanan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            child: Column(
              children: [
                _LocationRow(color: AppColors.primary, shapeIsCircle: true, text: 'Jl. Merdeka No. 12, Bandung'),
                const Padding(padding: EdgeInsets.only(left: 5), child: Divider(height: 16, color: AppColors.border)),
                const _LocationRow(color: AppColors.textPrimary, shapeIsCircle: false, text: 'Lokasi Tujuan', isPlaceholder: true),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Pilih Layanan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _VehicleChip(label: 'Motor', icon: Icons.two_wheeler, selected: _vehicle == _Vehicle.motor, onTap: () => setState(() => _vehicle = _Vehicle.motor))),
              const SizedBox(width: 10),
              Expanded(child: _VehicleChip(label: 'Mobil', icon: Icons.directions_car, selected: _vehicle == _Vehicle.mobil, onTap: () => setState(() => _vehicle = _Vehicle.mobil))),
              const SizedBox(width: 10),
              Expanded(child: _VehicleChip(label: 'Makanan', icon: Icons.fastfood_outlined, selected: _vehicle == _Vehicle.makanan, onTap: () => setState(() => _vehicle = _Vehicle.makanan))),
            ],
          ),
          const SizedBox(height: 18),
          const Text('Catatan untuk Driver', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(hintText: 'Contoh: rumah cat hijau, pagar hitam'),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            child: Column(
              children: [
                _EstimateRow(label: 'Jarak', value: '4.2 km'),
                const SizedBox(height: 10),
                _EstimateRow(label: 'Estimasi Waktu', value: '14 menit'),
                const Divider(height: 24, color: AppColors.border),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Estimasi Biaya', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    Text(formatRupiah(18000), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
        child: PrimaryButton(
          label: 'Konfirmasi Pesanan',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrderTrackingScreen())),
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({required this.color, required this.shapeIsCircle, required this.text, this.isPlaceholder = false});

  final Color color;
  final bool shapeIsCircle;
  final String text;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: shapeIsCircle ? BoxShape.circle : BoxShape.rectangle, borderRadius: shapeIsCircle ? null : BorderRadius.circular(2)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: isPlaceholder ? AppColors.textSecondary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _VehicleChip extends StatelessWidget {
  const _VehicleChip({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.8 : 1.5),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: selected ? AppColors.primaryDark : AppColors.textSecondary),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: selected ? AppColors.primaryDark : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _EstimateRow extends StatelessWidget {
  const _EstimateRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
