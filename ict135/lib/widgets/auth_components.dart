import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// E-commerce brand mark and wordmark used across auth screens and app bar.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.compact = false,
  });

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final badgeSize = compact ? 32.0 : 44.0;
    final iconSize = compact ? 18.0 : 24.0;
    final radius = compact ? 9.0 : 12.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: badgeSize,
          height: badgeSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.28),
                blurRadius: compact ? 8 : 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.shopping_bag_rounded,
            color: Colors.white,
            size: iconSize,
          ),
        ),
        SizedBox(width: compact ? 8 : 12),
        Flexible(
          child: Text(
            'Lendly',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: compact ? 17 : 23,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// Responsive centered card layout for authentication views.
class AuthCardScaffold extends StatelessWidget {
  const AuthCardScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceMuted,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final isShortViewport = constraints.maxHeight < 680;
            final horizontalOuter = isMobile ? 14.0 : 24.0;
            final verticalOuter = isShortViewport ? 14.0 : 24.0;
            final cardPadding = isMobile ? 20.0 : (isShortViewport ? 24.0 : 30.0);

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primarySoft.withValues(alpha: 0.35),
                    AppColors.surfaceMuted,
                    AppColors.surfaceMuted,
                  ],
                  stops: const [0.0, 0.35, 1.0],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalOuter,
                    vertical: verticalOuter,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(cardPadding),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textPrimary.withValues(alpha: 0.06),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Labeled input field using the prototype surface, border, and typography tokens.
class LabeledInputField extends StatelessWidget {
  const LabeledInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: AppColors.textSecondary,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Show/hide password toggle icon button.
class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    super.key,
    required this.isObscured,
    required this.onToggle,
  });

  final bool isObscured;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      tooltip: isObscured ? 'Show password' : 'Hide password',
      icon: Icon(
        isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 20,
        color: AppColors.textSecondary,
      ),
    );
  }
}

/// Primary brand button (#29B6F6 default, #0288D1 hover/active).
class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundResolver = WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered) ||
          states.contains(WidgetState.focused)) {
        return AppColors.primaryHover;
      }
      return AppColors.primary;
    });

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: backgroundResolver,
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          overlayColor: const WidgetStatePropertyAll(AppColors.primaryHover),
          elevation: const WidgetStatePropertyAll(0),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(label)),
      ),
    );
  }
}

/// Clean white social auth button featuring a multicolor Google 'G' vector mark.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed) ||
                states.contains(WidgetState.hovered)) {
              return AppColors.surfaceMuted;
            }
            return AppColors.background;
          }),
          foregroundColor: const WidgetStatePropertyAll(AppColors.textPrimary),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 14),
          ),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.focused)) {
              return const BorderSide(color: AppColors.borderStrong, width: 1.2);
            }
            return const BorderSide(color: AppColors.border, width: 1.1);
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleGIcon(size: 20),
              SizedBox(width: 12),
              Text(
                'Sign in with Google',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Self-contained vector rendering of the multicolor Google 'G' icon.
class GoogleGIcon extends StatelessWidget {
  const GoogleGIcon({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GoogleGPainter(),
      ),
    );
  }
}

class _GoogleGPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.shortestSide * 0.46;
    final innerR = size.shortestSide * 0.255;
    final stroke = outerR - innerR;
    final barHalf = stroke * 0.46;

    final outerRect = Rect.fromCircle(center: Offset(cx, cy), radius: outerR);
    final innerRect = Rect.fromCircle(center: Offset(cx, cy), radius: innerR);

    void drawArcSegment(double startAngle, double sweepAngle, Color color) {
      final path = Path()
        ..moveTo(
          cx + outerR * math.cos(startAngle),
          cy + outerR * math.sin(startAngle),
        )
        ..arcTo(outerRect, startAngle, sweepAngle, false)
        ..lineTo(
          cx + innerR * math.cos(startAngle + sweepAngle),
          cy + innerR * math.sin(startAngle + sweepAngle),
        )
        ..arcTo(innerRect, startAngle + sweepAngle, -sweepAngle, false)
        ..close();
      canvas.drawPath(path, Paint()..color = color);
    }

    // Yellow (left) and Red (top) and Green (bottom) arcs with slight overlap to prevent hairline seams.
    drawArcSegment(2.55, 1.18, const Color(0xFFFBBC05));
    drawArcSegment(-2.58, 1.84, const Color(0xFFEA4335));
    drawArcSegment(0.65, 1.94, const Color(0xFF34A853));

    // Blue right-lower arc + horizontal center crossbar.
    final thetaTop = -math.asin(barHalf / outerR);
    final thetaInner = math.asin(barHalf / innerR);
    const blueEnd = 0.68;

    final bluePath = Path()
      ..moveTo(cx, cy - barHalf)
      ..lineTo(cx + outerR * math.cos(thetaTop), cy - barHalf)
      ..arcTo(outerRect, thetaTop, blueEnd - thetaTop, false)
      ..lineTo(
        cx + innerR * math.cos(blueEnd),
        cy + innerR * math.sin(blueEnd),
      )
      ..arcTo(innerRect, blueEnd, thetaInner - blueEnd, false)
      ..lineTo(cx, cy + barHalf)
      ..close();

    canvas.drawPath(bluePath, Paint()..color = const Color(0xFF4285F4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Horizontal divider labeled "or".
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
      ],
    );
  }
}

/// Bottom navigation prompt switching between Login and Sign-Up views.
class AuthSwitchFooter extends StatefulWidget {
  const AuthSwitchFooter({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  @override
  State<AuthSwitchFooter> createState() => _AuthSwitchFooterState();
}

class _AuthSwitchFooterState extends State<AuthSwitchFooter> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            widget.promptText,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Text(
                  widget.actionText,
                  style: TextStyle(
                    color: _hovered
                        ? AppColors.primaryHover
                        : AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: _hovered
                        ? TextDecoration.underline
                        : TextDecoration.none,
                    decorationColor: AppColors.primaryHover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
