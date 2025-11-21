import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Settings screen (Hevy style)
class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: const Text('Settings'),
      titleTextStyle: const TextStyle(
        fontSize: DesignTokens.titleLarge,
        fontWeight: FontWeight.w600,
        color: HevyColors.textPrimary,
      ),
      backgroundColor: HevyColors.background,
      elevation: 0,
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        // Account section
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.paddingScreen,
            vertical: DesignTokens.spacingM,
          ),
          child: Text(
            'Account',
            style: TextStyle(
              fontSize: DesignTokens.bodySmall,
              fontWeight: FontWeight.w600,
              color: HevyColors.textSecondary,
            ),
          ),
        ),
        _SettingsListItem(
          icon: Icons.person,
          title: 'Profile',
          onTap: () => context.push('/profile/edit'),
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.lock,
          title: 'Account',
          onTap: () {
            // TODO: Navigate to account settings
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.star,
          title: 'Manage Subscription',
          subtitle: 'PRO',
          onTap: () {
            // TODO: Navigate to subscription management
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.notifications,
          title: 'Notifications',
          onTap: () {
            // TODO: Navigate to notifications settings
          },
        ),
        const SizedBox(height: DesignTokens.spacingL),

        // Preferences section
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.paddingScreen,
            vertical: DesignTokens.spacingM,
          ),
          child: Text(
            'Preferences',
            style: TextStyle(
              fontSize: DesignTokens.bodySmall,
              fontWeight: FontWeight.w600,
              color: HevyColors.textSecondary,
            ),
          ),
        ),
        _SettingsListItem(
          icon: Icons.fitness_center,
          title: 'Workouts',
          onTap: () => context.push('/profile/workout-settings'),
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.shield,
          title: 'Privacy & Social',
          onTap: () {
            // TODO: Navigate to privacy settings
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.straighten,
          title: 'Units',
          onTap: () {
            // TODO: Navigate to units settings
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.language,
          title: 'Language',
          onTap: () {
            // TODO: Navigate to language settings
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.favorite,
          title: 'Apple Health',
          onTap: () {
            // TODO: Navigate to Apple Health integration
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.link,
          title: 'Integrations',
          onTap: () {
            // TODO: Navigate to integrations
          },
        ),
        const SizedBox(height: DesignTokens.spacingL),

        // Guides section
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.paddingScreen,
            vertical: DesignTokens.spacingM,
          ),
          child: Text(
            'Guides',
            style: TextStyle(
              fontSize: DesignTokens.bodySmall,
              fontWeight: FontWeight.w600,
              color: HevyColors.textSecondary,
            ),
          ),
        ),
        _SettingsListItem(
          icon: Icons.info_outline,
          title: 'Getting Started Guide',
          onTap: () {
            // TODO: Show getting started guide
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.help_outline,
          title: 'Routine Help',
          onTap: () {
            // TODO: Show routine help
          },
        ),
        const SizedBox(height: DesignTokens.spacingL),

        // Help section
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.paddingScreen,
            vertical: DesignTokens.spacingM,
          ),
          child: Text(
            'Help',
            style: TextStyle(
              fontSize: DesignTokens.bodySmall,
              fontWeight: FontWeight.w600,
              color: HevyColors.textSecondary,
            ),
          ),
        ),
        _SettingsListItem(
          icon: Icons.help_outline,
          title: 'Frequently Asked Questions',
          onTap: () {
            // TODO: Show FAQ
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.email,
          title: 'Contact Us',
          onTap: () {
            // TODO: Open contact form
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.star_outline,
          title: 'Review Hevy on the App Store',
          onTap: () {
            // TODO: Open app store review
          },
        ),
        const Divider(color: HevyColors.border, height: 1),
        _SettingsListItem(
          icon: Icons.info,
          title: 'About',
          onTap: () => context.push('/profile/about'),
        ),
        const SizedBox(height: DesignTokens.spacingL),

        // Follow Us section
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DesignTokens.paddingScreen,
            vertical: DesignTokens.spacingM,
          ),
          child: Text(
            'Follow us @hevyapp',
            style: TextStyle(
              fontSize: DesignTokens.bodySmall,
              fontWeight: FontWeight.w600,
              color: HevyColors.textSecondary,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SocialIcon(icon: Icons.camera_alt, color: Colors.purple),
              _SocialIcon(icon: Icons.play_arrow, color: Colors.red),
              _SocialIcon(icon: Icons.music_note, color: Colors.black),
              _SocialIcon(icon: Icons.facebook, color: Colors.blue),
              _SocialIcon(icon: Icons.reddit, color: Colors.orange),
              _SocialIcon(icon: Icons.close, color: Colors.black),
            ],
          ),
        ),
        const SizedBox(height: DesignTokens.spacingXL),
      ],
    );
  }
}

class _SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsListItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: HevyColors.textPrimary),
      title: Row(
        children: [
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(right: DesignTokens.spacingXS),
              child: Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: DesignTokens.bodySmall,
                  color: HevyColors.textSecondary,
                ),
              ),
            ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: HevyColors.textPrimary,
                fontSize: DesignTokens.bodyLarge,
              ),
            ),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: HevyColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _SocialIcon({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}

/// Settings switch tile
class _SettingsSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// Settings radio tile
class _SettingsRadioTile extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _SettingsRadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
/// Settings list tile
class _SettingsListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsListTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

