import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/format.dart';
import '../../../core/widgets/status_badge.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admin', style: TextStyle(fontSize: 11.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
            Text('Dashboard', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
          ],
        ),
        toolbarHeight: 68,
        actions: [IconButton(onPressed: onLogout, icon: const Icon(Icons.logout))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              _StatCard(icon: Icons.account_balance_wallet_outlined, value: 'Rp 42,5jt', label: 'Pendapatan bulan ini', filled: true),
              _StatCard(icon: Icons.receipt_long_outlined, value: '1.284', label: 'Total pesanan'),
              _StatCard(icon: Icons.groups_outlined, value: '86', label: 'Driver aktif'),
              _StatCard(icon: Icons.star_rounded, value: '4.8', label: 'Rating rata-rata'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tren Pendapatan', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(8)),
                      child: const Text('30 hari', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(height: 80, child: CustomPaint(painter: _TrendPainter(), size: const Size(double.infinity, 80))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Pesanan Terbaru', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          for (final order in recentOrders) ...[
            _RecentOrderTile(order: order),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.value, required this.label, this.filled = false});

  final IconData icon;
  final String value;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: filled ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: filled ? null : Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: filled ? Colors.white : (icon == Icons.star_rounded ? AppColors.warning : AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: filled ? Colors.white : AppColors.textPrimary)),
          Text(label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: filled ? const Color(0xFFE7FBF1) : AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _RecentOrderTile extends StatelessWidget {
  const _RecentOrderTile({required this.order});

  final RecentOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${order.id} · ${order.route}', style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
                Text('${order.timeLabel} · ${formatRupiah(order.price)}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          StatusBadge(status: order.status),
        ],
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [0.78, 0.66, 0.72, 0.44, 0.5, 0.28, 0.36, 0.11];
    final path = Path();
    final fillPath = Path();
    for (var i = 0; i < points.length; i++) {
      final x = size.width * i / (points.length - 1);
      final y = size.height * points[i];
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, Paint()..color = AppColors.primary.withValues(alpha: 0.1));
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
