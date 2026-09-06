import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';
import '../../../core/widgets/format.dart';
import 'driver_active_order_screen.dart';

class DriverInboxScreen extends StatefulWidget {
  const DriverInboxScreen({super.key, required this.onLogout});

  final VoidCallback onLogout;

  @override
  State<DriverInboxScreen> createState() => _DriverInboxScreenState();
}

class _DriverInboxScreenState extends State<DriverInboxScreen> {
  bool _online = true;
  bool _hasRequest = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Pesanan Masuk', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                        Text(
                          _online ? 'Kamu online · siap menerima order' : 'Kamu sedang offline',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Switch(value: _online, activeTrackColor: AppColors.primary, onChanged: (v) => setState(() => _online = v)),
                  IconButton(onPressed: widget.onLogout, icon: const Icon(Icons.logout, size: 20)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatColumn(value: 'Rp 86.000', label: 'Hari ini'),
                    _VDivider(),
                    _StatColumn(value: '7', label: 'Trip selesai'),
                    _VDivider(),
                    _StatColumn(value: '4.9', label: 'Rating'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _hasRequest
                  ? ListView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      children: [
                        _RequestCard(
                          onDecline: () => setState(() => _hasRequest = false),
                          onAccept: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DriverActiveOrderScreen())).then((_) {
                            if (mounted) setState(() => _hasRequest = false);
                          }),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
                          child: Opacity(
                            opacity: 0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(color: const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(8)),
                                      child: const Text('Menunggu', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary)),
                                    ),
                                    const Text('Antrian · 2', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Jl. Braga → Balai Kota', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
                                    Text(formatRupiah(12500), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Text('Belum ada pesanan masuk', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.onAccept, required this.onDecline});

  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.primary, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(8)),
                child: const Text('Permintaan Baru', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
              ),
              const Text('Terima dalam 00:12', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.danger)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              Text(incomingRequest.pickup, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          Padding(padding: const EdgeInsets.only(left: 3.5), child: Container(width: 1, height: 14, color: AppColors.border)),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.textPrimary, borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Text(incomingRequest.destination, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${incomingRequest.distanceKm} km · ${incomingRequest.etaMinutes} mnt', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
              Text(formatRupiah(incomingRequest.price), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onDecline,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor: const Color(0xFFF0F1EE),
                    foregroundColor: AppColors.textSecondary,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  ),
                  child: const Text('Tolak', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                  ),
                  child: const Text('Terima', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5)),
                ),
              ),
            ],
          ),
        ],
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
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
        Text(label, style: const TextStyle(fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) => Container(width: 1, height: 30, color: AppColors.border);
}
