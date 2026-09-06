import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../admin/presentation/admin_shell.dart';
import '../../customer/presentation/customer_shell.dart';
import '../../driver/presentation/driver_shell.dart';

enum _AuthTab { login, signup }

enum _Role { customer, driver }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _AuthTab _tab = _AuthTab.login;
  _Role _role = _Role.customer;

  void _enter() {
    final destination = switch (_role) {
      _Role.customer => const CustomerShell(),
      _Role.driver => const DriverShell(),
    };
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => destination));
  }

  void _enterAsAdmin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AdminShell()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                  child: const Icon(Icons.location_on, color: AppColors.primary, size: 34),
                ),
                const SizedBox(height: 14),
                const Text('Laju', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: -0.5)),
                const SizedBox(height: 4),
                const Text('Cepat, aman, terpercaya.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primarySoft)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AuthTabs(tab: _tab, onChanged: (t) => setState(() => _tab = t)),
                  const SizedBox(height: 20),
                  const Text('Nomor HP atau Email', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  const TextField(decoration: InputDecoration(hintText: '0812xxxxxxx')),
                  const SizedBox(height: 14),
                  const Text('Kata Sandi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  const SizedBox(height: 6),
                  const TextField(obscureText: true, decoration: InputDecoration(hintText: '••••••••')),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Lupa kata sandi?', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Saya adalah:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _RoleChip(
                          label: 'Penumpang',
                          icon: Icons.person_outline,
                          selected: _role == _Role.customer,
                          onTap: () => setState(() => _role = _Role.customer),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _RoleChip(
                          label: 'Driver',
                          icon: Icons.two_wheeler,
                          selected: _role == _Role.driver,
                          onTap: () => setState(() => _role = _Role.driver),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(label: _tab == _AuthTab.login ? 'Masuk' : 'Daftar', onPressed: _enter),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => setState(() => _tab = _tab == _AuthTab.login ? _AuthTab.signup : _AuthTab.login),
                      child: Text.rich(
                        TextSpan(
                          text: _tab == _AuthTab.login ? 'Belum punya akun? ' : 'Sudah punya akun? ',
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                          children: [
                            TextSpan(
                              text: _tab == _AuthTab.login ? 'Daftar sekarang' : 'Masuk',
                              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: _enterAsAdmin,
                      child: const Text('Mode Admin', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthTabs extends StatelessWidget {
  const _AuthTabs({required this.tab, required this.onChanged});

  final _AuthTab tab;
  final ValueChanged<_AuthTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFF0F1EE), borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Expanded(child: _AuthTabButton(label: 'Masuk', selected: tab == _AuthTab.login, onTap: () => onChanged(_AuthTab.login))),
          Expanded(child: _AuthTabButton(label: 'Daftar', selected: tab == _AuthTab.signup, onTap: () => onChanged(_AuthTab.signup))),
        ],
      ),
    );
  }
}

class _AuthTabButton extends StatelessWidget {
  const _AuthTabButton({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          boxShadow: selected ? [const BoxShadow(color: Color(0x0F000000), blurRadius: 3, offset: Offset(0, 1))] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.w700 : FontWeight.w600, color: selected ? AppColors.textPrimary : AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.label, required this.icon, required this.selected, required this.onTap});

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: 1.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? AppColors.primaryDark : AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: selected ? AppColors.primaryDark : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
