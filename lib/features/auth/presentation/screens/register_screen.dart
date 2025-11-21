import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Register screen
class RegisterScreen extends BaseScreen {
  const RegisterScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: HevyColors.textPrimary,
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Create Account',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: DesignTokens.spacingXL),
            // Title
            Text(
              'Join ZenX',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingXS),
            Text(
              'Start tracking your fitness journey',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingXXXL),
            
            // Name field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your name',
                prefixIcon: Icon(Icons.person_outlined),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingM),
            
            // Email field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: DesignTokens.spacingM),
            
            // Password field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Create a password',
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              obscureText: true,
            ),
            const SizedBox(height: DesignTokens.spacingM),
            
            // Confirm Password field
            const TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              obscureText: true,
            ),
            const SizedBox(height: DesignTokens.spacingL),
            
            // Register button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement registration logic
                // For now, navigate to home
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.paddingButtonVertical,
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Create Account'),
            ),
            const SizedBox(height: DesignTokens.spacingM),
            
            // Login link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

