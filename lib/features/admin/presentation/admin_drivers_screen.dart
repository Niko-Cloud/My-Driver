import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/mock_data.dart';

enum _DriverFilter { all, active, inactive }

class AdminDriversScreen extends StatefulWidget {
  const AdminDriversScreen({super.key});

  @override
  State<AdminDriversScreen> createState() => _AdminDriversScreenState();
}

class _AdminDriversScreenState extends State<AdminDriversScreen> {
  _DriverFilter _filter = _DriverFilter.all;
  final _drivers = List.of(managedDrivers);

  List<ManagedDriver> get _filtered => switch (_filter) {
        _DriverFilter.all => _drivers,
        _DriverFilter.active => _drivers.where((d) => d.isActive).toList(),
        _DriverFilter.inactive => _drivers.where((d) => !d.isActive).toList(),
      };

  void _addDriver() {
    setState(() {
      _drivers.add(ManagedDriver(name: 'Driver Baru ${_drivers.length + 1}', vehicle: 'Belum diatur', plate: '-', isActive: true, isCar: false));
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Driver baru ditambahkan')));
  }

  void _toggleActive(ManagedDriver driver) {
    setState(() {
      final i = _drivers.indexOf(driver);
      _drivers[i] = ManagedDriver(name: driver.name, vehicle: driver.vehicle, plate: driver.plate, isActive: !driver.isActive, isCar: driver.isCar);
    });
  }

  void _delete(ManagedDriver driver) {
    setState(() => _drivers.remove(driver));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Driver', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: _addDriver,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), border: Border.all(color: AppColors.border, width: 1.5)),
              child: const Row(
                children: [
                  Icon(Icons.search, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 10),
                  Text('Cari nama driver...', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _FilterChip(label: 'Semua (${_drivers.length})', selected: _filter == _DriverFilter.all, onTap: () => setState(() => _filter = _DriverFilter.all)),
                const SizedBox(width: 8),
                _FilterChip(label: 'Aktif', selected: _filter == _DriverFilter.active, onTap: () => setState(() => _filter = _DriverFilter.active)),
                const SizedBox(width: 8),
                _FilterChip(label: 'Nonaktif', selected: _filter == _DriverFilter.inactive, onTap: () => setState(() => _filter = _DriverFilter.inactive)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              itemCount: _filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final driver = _filtered[i];
                return _DriverTile(driver: driver, onToggle: () => _toggleActive(driver), onDelete: () => _delete(driver));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: selected ? AppColors.textPrimary : const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(9)),
        child: Text(label, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}

class _DriverTile extends StatelessWidget {
  const _DriverTile({required this.driver, required this.onToggle, required this.onDelete});

  final ManagedDriver driver;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: driver.isActive ? 1 : 0.6,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(12)),
              child: Icon(driver.isCar ? Icons.directions_car : Icons.two_wheeler, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700)),
                  Text('${driver.vehicle} · ${driver.plate}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            GestureDetector(
              onTap: onToggle,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(color: driver.isActive ? AppColors.primarySoft : const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  driver.isActive ? 'Aktif' : 'Nonaktif',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: driver.isActive ? AppColors.primaryDark : AppColors.textSecondary),
                ),
              ),
            ),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
