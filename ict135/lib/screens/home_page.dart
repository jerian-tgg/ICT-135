import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/auth_components.dart';

/// Minimal blank app shell with top navigation bar and Log Out button.
class BlankHomePage extends StatelessWidget {
  const BlankHomePage({
    super.key,
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 640;

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 14 : 28,
                    vertical: 12,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(child: BrandLogo(compact: true)),
                          const SizedBox(width: 12),
                          _LogoutButton(
                            isCompact: isCompact,
                            onPressed: onLogout,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.border,
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    required this.isCompact,
    required this.onPressed,
  });

  final bool isCompact;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.logout_rounded, size: 16),
      label: const Text('Log Out'),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return AppColors.primarySoft.withValues(alpha: 0.45);
          }
          return AppColors.background;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return AppColors.primaryHover;
          }
          return AppColors.textPrimary;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return const BorderSide(color: AppColors.primaryHover);
          }
          return const BorderSide(color: AppColors.borderStrong);
        }),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: isCompact ? 10 : 14,
            vertical: isCompact ? 10 : 12,
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(Size(0, 40)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
