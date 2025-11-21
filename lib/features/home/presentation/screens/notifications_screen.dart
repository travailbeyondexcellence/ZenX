import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Notifications screen (Hevy Pro style)
class NotificationsScreen extends BaseScreen {
  const NotificationsScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: HevyColors.textPrimary,
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Notifications',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
      backgroundColor: HevyColors.background,
      elevation: 0,
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual notifications when available
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 80,
            color: HevyColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: DesignTokens.spacingXL),
          const Text(
            'No recent notifications',
            style: TextStyle(
              fontSize: DesignTokens.titleLarge,
              fontWeight: FontWeight.w600,
              color: HevyColors.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingM),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.spacingXXL),
            child: Text(
              "We'll notify you when you have new activity",
              style: TextStyle(
                fontSize: DesignTokens.bodyMedium,
                color: HevyColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}







