import 'package:flutter/material.dart';
import '../../auth/presentation/login_screen.dart';
import 'admin_dashboard_screen.dart';
import 'admin_drivers_screen.dart';
import 'admin_pricing_screen.dart';

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          AdminDashboardScreen(onLogout: _logout),
          const AdminDriversScreen(),
          const AdminPricingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), activeIcon: Icon(Icons.groups), label: 'Driver'),
          BottomNavigationBarItem(icon: Icon(Icons.sell_outlined), activeIcon: Icon(Icons.sell), label: 'Tarif'),
        ],
      ),
    );
  }
}
