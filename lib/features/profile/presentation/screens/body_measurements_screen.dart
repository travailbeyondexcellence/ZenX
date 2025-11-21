import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Body measurements screen (Hevy style)
class BodyMeasurementsScreen extends BaseScreen {
  const BodyMeasurementsScreen({super.key});

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
        'Body Measurements',
        style: TextStyle(
          fontSize: DesignTokens.titleLarge,
          fontWeight: FontWeight.w600,
          color: HevyColors.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          color: HevyColors.textPrimary,
          onPressed: () {
            // TODO: Add new measurement
          },
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // Mock data - TODO: Replace with actual data
    final measurements = [
      _Measurement(
        date: DateTime.now(),
        weight: 75.5,
        bodyFat: 15.0,
      ),
      _Measurement(
        date: DateTime.now().subtract(const Duration(days: 7)),
        weight: 76.0,
        bodyFat: 15.5,
      ),
      _Measurement(
        date: DateTime.now().subtract(const Duration(days: 14)),
        weight: 76.5,
        bodyFat: 16.0,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(DesignTokens.paddingScreen),
      children: [
        // Current stats
        Card(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Column(
              children: [
                Text(
                  'Current',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: DesignTokens.spacingM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      label: 'Weight',
                      value: '${measurements.first.weight} kg',
                      icon: Icons.monitor_weight,
                    ),
                    _StatItem(
                      label: 'Body Fat',
                      value: '${measurements.first.bodyFat}%',
                      icon: Icons.percent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: DesignTokens.spacingXL),

        // History
        Text(
          'History',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: DesignTokens.spacingM),
        ...measurements.map((measurement) {
          return Card(
            margin: const EdgeInsets.only(bottom: DesignTokens.spacingM),
            child: ListTile(
              title: Text(_formatDate(measurement.date)),
              subtitle: Row(
                children: [
                  Text('Weight: ${measurement.weight} kg'),
                  const SizedBox(width: DesignTokens.spacingM),
                  Text('Body Fat: ${measurement.bodyFat}%'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: View/edit measurement
              },
            ),
          );
        }),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Measurement model
class _Measurement {
  final DateTime date;
  final double weight;
  final double bodyFat;

  _Measurement({
    required this.date,
    required this.weight,
    required this.bodyFat,
  });
}

/// Stat item widget
class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: HevyColors.primary,
          size: DesignTokens.iconLarge, // 32dp
        ),
        const SizedBox(height: DesignTokens.spacingS),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: HevyColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: DesignTokens.spacingXXS),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
