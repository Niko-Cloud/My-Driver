import 'package:flutter/material.dart';
import '../features/auth/presentation/login_screen.dart';
import 'theme.dart';

class MyDriverApp extends StatelessWidget {
  const MyDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laju',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
