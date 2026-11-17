import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_components.dart';

/// Default initial authentication view with direct UI-only navigation.
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.onLogin,
    required this.onNavigateToSignUp,
  });

  final VoidCallback onLogin;
  final VoidCallback onNavigateToSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthCardScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: BrandLogo()),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Welcome back',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Sign in to explore deals, track orders, and shop effortlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.5,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const LabeledInputField(
            label: 'Username / Email',
            hintText: 'Enter your username or email',
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          LabeledInputField(
            label: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => widget.onLogin(),
            suffixIcon: PasswordVisibilityButton(
              isObscured: _obscurePassword,
              onToggle: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
          const SizedBox(height: 18),
          PrimaryActionButton(
            label: 'Log In',
            onPressed: widget.onLogin,
          ),
          const SizedBox(height: 14),
          const OrDivider(),
          const SizedBox(height: 14),
          GoogleSignInButton(
            onPressed: widget.onLogin,
          ),
          const SizedBox(height: 16),
          AuthSwitchFooter(
            promptText: "Don't have an account? ",
            actionText: 'Sign up here',
            onTap: widget.onNavigateToSignUp,
          ),
        ],
      ),
    );
  }
}
