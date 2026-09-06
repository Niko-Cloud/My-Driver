import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/rating_stars.dart';

class DriverHistoryScreen extends StatelessWidget {
  const DriverHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Perjalanan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(18)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(value: 'Rp 612.000', label: 'Minggu ini'),
                  _VDivider(),
                  _StatColumn(value: '38', label: 'Trip'),
                  _VDivider(),
                  _StatColumn(value: '4.9', label: 'Rating'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: driverTrips.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) => _TripTile(trip: driverTrips[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripTile extends StatelessWidget {
  const _TripTile({required this.trip});

  final DriverTripItem trip;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: trip.cancelled ? 0.65 : 1,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.customerName, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('${trip.dateLabel} · ${trip.route}', style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Text(
                  trip.cancelled ? formatRupiah(0) : '+${formatRupiah(trip.earning)}',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: trip.cancelled ? AppColors.textSecondary : AppColors.primary),
                ),
              ],
            ),
            if (!trip.cancelled) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  RatingStars(rating: trip.rating, size: 12),
                  if (trip.note != null) ...[
                    const SizedBox(width: 4),
                    Expanded(child: Text(trip.note!, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 10.5, color: Color(0xFFE7FBF1), fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) => Container(width: 1, height: 30, color: Colors.white.withValues(alpha: 0.3));
}
