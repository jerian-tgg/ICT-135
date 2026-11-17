import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_components.dart';

/// E-commerce registration prototype view with direct navigation back to login.
class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.onNavigateToLogin,
  });

  final VoidCallback onNavigateToLogin;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _receiveDealsUpdates = true;

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
              'Create your account',
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
              'Join Lendly for faster checkout and personalized offers.',
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
            label: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Icons.badge_outlined,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          const LabeledInputField(
            label: 'Email Address',
            hintText: 'you@example.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
          LabeledInputField(
            label: 'Password',
            hintText: 'Create a password',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => widget.onNavigateToLogin(),
            suffixIcon: PasswordVisibilityButton(
              isObscured: _obscurePassword,
              onToggle: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              setState(() => _receiveDealsUpdates = !_receiveDealsUpdates);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _receiveDealsUpdates,
                      onChanged: (checked) {
                        setState(() => _receiveDealsUpdates = checked ?? false);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Send me exclusive deals and product updates',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryActionButton(
            label: 'Create Account',
            onPressed: widget.onNavigateToLogin,
          ),
          const SizedBox(height: 20),
          AuthSwitchFooter(
            promptText: 'Already have an account? ',
            actionText: 'Log in',
            onTap: widget.onNavigateToLogin,
          ),
        ],
      ),
    );
  }
}
