import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Edit Profile screen (Hevy style)
class EditProfileScreen extends BaseScreen {
  const EditProfileScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: const Text('Edit Profile'),
      titleTextStyle: const TextStyle(
        fontSize: DesignTokens.titleLarge,
        fontWeight: FontWeight.w600,
        color: HevyColors.textPrimary,
      ),
      backgroundColor: HevyColors.background,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () {
            // TODO: Save profile changes
            context.pop();
          },
          child: const Text(
            'Done',
            style: TextStyle(
              color: HevyColors.primary,
              fontSize: DesignTokens.bodyLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // Mock data - in real app, this would come from state management
    final nameController = TextEditingController(text: 'Kris M');
    final bioController = TextEditingController(text: 'Describe yourself');
    final linkController = TextEditingController(text: 'instagram.com/User');
    String selectedSex = 'Male';
    String? selectedBirthday;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: DesignTokens.spacingL),

          // Profile picture
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Open image picker
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HevyColors.surfaceElevated,
                      border: Border.all(
                        color: HevyColors.border,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: DesignTokens.iconXLarge, // 48dp (max size)
                      color: HevyColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingS),
                GestureDetector(
                  onTap: () {
                    // TODO: Open image picker
                  },
                  child: const Text(
                    'Change Picture',
                    style: TextStyle(
                      color: HevyColors.primary,
                      fontSize: DesignTokens.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingXL),

          // Public profile data section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Public profile data',
                  style: TextStyle(
                    fontSize: DesignTokens.bodySmall,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textSecondary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingM),

                // Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: DesignTokens.bodyLarge,
                        color: HevyColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: HevyColors.textPrimary),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: HevyColors.border),

                // Bio
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: DesignTokens.spacingS),
                      child: Text(
                        'Bio',
                        style: TextStyle(
                          fontSize: DesignTokens.bodyLarge,
                          color: HevyColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: bioController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: HevyColors.textTertiary),
                        decoration: const InputDecoration(
                          hintText: 'Describe yourself',
                          hintStyle: TextStyle(color: HevyColors.textTertiary),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: HevyColors.border),

                // Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Link',
                      style: TextStyle(
                        fontSize: DesignTokens.bodyLarge,
                        color: HevyColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: linkController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: HevyColors.textPrimary),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingXL),

          // Private data section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Private data',
                      style: TextStyle(
                        fontSize: DesignTokens.bodySmall,
                        fontWeight: FontWeight.w600,
                        color: HevyColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingXS),
                    GestureDetector(
                      onTap: () {
                        // TODO: Show info dialog
                      },
                      child: const Icon(
                        Icons.help_outline,
                        size: DesignTokens.iconSmall, // 16dp
                        color: HevyColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingM),

                // Sex
                InkWell(
                  onTap: () {
                    // TODO: Show sex selector
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sex',
                        style: TextStyle(
                          fontSize: DesignTokens.bodyLarge,
                          color: HevyColors.textPrimary,
                        ),
                      ),
                      Text(
                        selectedSex,
                        style: const TextStyle(
                          fontSize: DesignTokens.bodyLarge,
                          color: HevyColors.primary,
                        ),
                      ),
                    ],
                  ),

                ),
                const Divider(color: HevyColors.border),

                // Birthday
                InkWell(
                  onTap: () async {
                    // TODO: Show date picker
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      // TODO: Update selected birthday
                      selectedBirthday = '${date.day}/${date.month}/${date.year}';
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Birthday',
                        style: TextStyle(
                          fontSize: DesignTokens.bodyLarge,
                          color: HevyColors.textPrimary,
                        ),
                      ),
                      Text(
                        selectedBirthday ?? 'Select',
                        style: TextStyle(
                          fontSize: DesignTokens.bodyLarge,
                          color: HevyColors.primary,
                        ),
                      ),
                    ],
                  ),

                ),
                const Divider(color: HevyColors.border),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingXL),
        ],
      ),
    );
  }
}


