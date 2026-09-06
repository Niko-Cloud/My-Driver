import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/rating_stars.dart';
import 'create_order_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Halo,', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                        Text('Budi Santoso', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onLogout,
                    icon: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.logout, color: AppColors.primaryDark, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border, width: 1.5)),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 18, color: AppColors.textSecondary),
                    SizedBox(width: 10),
                    Text('Mau ke mana hari ini?', style: TextStyle(fontSize: 13.5, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 170,
                  decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFDFF6E9), Color(0xFFCFF0E0)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 14,
                        bottom: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: const Text('Lokasimu sekarang', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                        ),
                      ),
                      const Center(child: Icon(Icons.map_outlined, size: 40, color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Driver Terdekat', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                      Text('Lihat semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (final driver in nearbyDrivers) ...[
                    _DriverTile(driver: driver),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: null,
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
        child: PrimaryButton(
          label: 'Buat Pesanan',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateOrderScreen())),
        ),
      ),
    );
  }
}

class _DriverTile extends StatelessWidget {
  const _DriverTile({required this.driver});

  final NearbyDriver driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(12)),
            child: Icon(driver.isCar ? Icons.directions_car : Icons.two_wheeler, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(driver.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    RatingStars(rating: driver.rating, size: 12),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${driver.rating} · ${driver.vehicle} · ${driver.distanceKm} km',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('${driver.etaMinutes} mnt', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary)),
        ],
      ),
    );
  }
}
