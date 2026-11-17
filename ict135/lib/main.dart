import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

enum _AppView {
  login,
  signUp,
  home,
}

/// Self-contained e-commerce UI-only prototype with direct screen navigation.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _AppView _currentView = _AppView.login;

  void _navigateTo(_AppView view) {
    setState(() => _currentView = view);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lendly — E-Commerce Prototype',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 0.025),
            end: Offset.zero,
          ).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },
        child: switch (_currentView) {
          _AppView.login => LoginPage(
              key: const ValueKey(_AppView.login),
              onLogin: () => _navigateTo(_AppView.home),
              onNavigateToSignUp: () => _navigateTo(_AppView.signUp),
            ),
          _AppView.signUp => SignUpPage(
              key: const ValueKey(_AppView.signUp),
              onNavigateToLogin: () => _navigateTo(_AppView.login),
            ),
          _AppView.home => BlankHomePage(
              key: const ValueKey(_AppView.home),
              onLogout: () => _navigateTo(_AppView.login),
            ),
        },
      ),
    );
  }
}
