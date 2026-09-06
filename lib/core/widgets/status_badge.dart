import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/mock_data.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final OrderStatus status;

  (String, Color, Color) get _visuals => switch (status) {
        OrderStatus.completed => ('Selesai', AppColors.primaryDark, AppColors.primarySoft),
        OrderStatus.inProgress => ('Berjalan', AppColors.info, AppColors.infoSoft),
        OrderStatus.accepted => ('Diterima', AppColors.info, AppColors.infoSoft),
        OrderStatus.pickedUp => ('Dijemput', AppColors.info, AppColors.infoSoft),
        OrderStatus.searching => ('Mencari', AppColors.textSecondary, AppColors.border),
        OrderStatus.cancelled => ('Batal', AppColors.danger, AppColors.dangerSoft),
      };

  @override
  Widget build(BuildContext context) {
    final (label, fg, bg) = _visuals;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        label,
        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: fg),
      ),
    );
  }
}
