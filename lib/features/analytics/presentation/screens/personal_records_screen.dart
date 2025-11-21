import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Personal records screen (Hevy style)
class PersonalRecordsScreen extends BaseScreen {
  const PersonalRecordsScreen({super.key});

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
        'Personal Records',
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
    // Mock data - TODO: Replace with actual data
    final records = [
      _PRRecord(
        exercise: 'Bench Press',
        value: 100.0,
        type: '1RM',
        date: DateTime.now().subtract(const Duration(days: 2)),
        workoutId: '1',
      ),
      _PRRecord(
        exercise: 'Squat',
        value: 150.0,
        type: '1RM',
        date: DateTime.now().subtract(const Duration(days: 5)),
        workoutId: '2',
      ),
      _PRRecord(
        exercise: 'Deadlift',
        value: 180.0,
        type: '1RM',
        date: DateTime.now().subtract(const Duration(days: 7)),
        workoutId: '3',
      ),
      _PRRecord(
        exercise: 'Bench Press',
        value: 12,
        type: 'Max Reps',
        date: DateTime.now().subtract(const Duration(days: 10)),
        workoutId: '4',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.paddingScreen),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return _PRRecordCard(record: record);
      },
    );
  }
}

/// PR record model
class _PRRecord {
  final String exercise;
  final double value;
  final String type;
  final DateTime date;
  final String workoutId;

  _PRRecord({
    required this.exercise,
    required this.value,
    required this.type,
    required this.date,
    required this.workoutId,
  });
}

/// PR record card
class _PRRecordCard extends StatelessWidget {
  final _PRRecord record;

  const _PRRecordCard({required this.record});

  String _formatValue(double value, String type) {
    if (type == '1RM' || type == 'max_volume') {
      return '${value.toStringAsFixed(1)} kg';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingM),
              decoration: BoxDecoration(
                color: HevyColors.accentOrange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
              ),
              child: const Icon(
                Icons.emoji_events,
                color: HevyColors.accentOrange,
                size: DesignTokens.iconLarge, // 32dp
              ),
            ),
            const SizedBox(width: DesignTokens.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.exercise,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: DesignTokens.spacingXS),
                  Row(
                    children: [
                      Text(
                        _formatValue(record.value, record.type),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: HevyColors.accentOrange,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(width: DesignTokens.spacingXS),
                      Chip(
                        label: Text(record.type),
                        backgroundColor: HevyColors.surfaceElevated,
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingXXS),
                  Text(
                    _formatDate(record.date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
