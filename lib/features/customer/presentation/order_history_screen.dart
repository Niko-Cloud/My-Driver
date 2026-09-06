import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/rating_stars.dart';
import '../../../core/widgets/status_badge.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Pesanan', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19))),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        itemCount: customerHistory.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) => _HistoryTile(item: customerHistory[i]),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.item});

  final OrderHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final cancelled = item.status == OrderStatus.cancelled;
    return Opacity(
      opacity: cancelled ? 0.75 : 1,
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
                      Text(item.route, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text('${item.dateLabel} · ${item.vehicle}', style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                StatusBadge(status: item.status),
              ],
            ),
            if (!cancelled) ...[
              const Divider(height: 22, color: AppColors.border),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatRupiah(item.price), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                  if (item.rating != null)
                    RatingStars(rating: item.rating!)
                  else
                    GestureDetector(
                      onTap: () => _showRatingSheet(context),
                      child: const Text('Beri Rating ›', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRatingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _RatingSheet(),
    );
  }
}

class _RatingSheet extends StatefulWidget {
  const _RatingSheet();

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 36, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          const Text('Beri Rating Perjalanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          const Text('Andi Prasetyo · Honda Beat', style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          RatingStarsInput(rating: _rating, onChanged: (v) => setState(() => _rating = v)),
          const SizedBox(height: 8),
          const TextField(
            maxLines: 2,
            decoration: InputDecoration(hintText: 'Bagikan pengalamanmu...'),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Kirim',
            height: 50,
            onPressed: _rating == 0 ? null : () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
