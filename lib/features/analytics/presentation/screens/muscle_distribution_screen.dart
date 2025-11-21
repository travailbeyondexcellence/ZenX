import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Muscle distribution screen with radar chart (Hevy style)
class MuscleDistributionScreen extends BaseScreen {
  const MuscleDistributionScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: const Text('Muscle distribution'),
      titleTextStyle: const TextStyle(
        fontSize: DesignTokens.titleLarge,
        fontWeight: FontWeight.w600,
        color: HevyColors.textPrimary,
      ),
      backgroundColor: HevyColors.background,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.help_outline),
          color: HevyColors.textSecondary,
          onPressed: () {
            // TODO: Show help dialog
          },
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined),
          color: HevyColors.textSecondary,
          onPressed: () {
            // TODO: Share statistics
          },
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    // Mock data matching the images
    const selectedDateRange = 'Last 30 days';
    
    // Current period data
    final currentData = {
      'Back': 0.4,
      'Chest': 0.9,
      'Core': 0.5,
      'Shoulders': 0.7,
      'Arms': 1.0,
      'Legs': 0.3,
    };
    
    // Previous period data
    final previousData = {
      'Back': 0.4,
      'Chest': 0.7,
      'Core': 0.5,
      'Shoulders': 0.5,
      'Arms': 0.8,
      'Legs': 0.3,
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date range selector
          Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: _FilterButton(
              label: selectedDateRange,
              onTap: () {
                // TODO: Show date range picker
              },
            ),
          ),

          // Radar chart
          Container(
            height: 350,
            margin: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            padding: const EdgeInsets.all(DesignTokens.spacingL),
            decoration: BoxDecoration(
              color: HevyColors.surface,
              borderRadius: BorderRadius.circular(DesignTokens.radiusL),
            ),
            child: _RadarChart(
              currentData: currentData,
              previousData: previousData,
            ),
          ),

          const SizedBox(height: DesignTokens.spacingM),

          // Legend
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(
                  color: HevyColors.primary,
                  label: 'Current',
                ),
                SizedBox(width: DesignTokens.spacingL),
                _LegendItem(
                  color: HevyColors.textTertiary,
                  label: 'Previous',
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingXL),

          // Summary cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: 'Workouts',
                    value: '13',
                    change: '+3',
                  ),
                ),
                SizedBox(width: DesignTokens.spacingM),
                Expanded(
                  child: _SummaryCard(
                    label: 'Duration',
                    value: '15h 43min',
                    change: '+2h 24min',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingM),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: 'Volume',
                    value: '65k kg',
                    change: '+21k kg',
                  ),
                ),
                SizedBox(width: DesignTokens.spacingM),
                Expanded(
                  child: _SummaryCard(
                    label: 'Sets',
                    value: '162',
                    change: '+43',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingXL),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingM,
          vertical: DesignTokens.spacingS,
        ),
        decoration: BoxDecoration(
          color: HevyColors.surfaceElevated,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.bodyMedium,
                color: HevyColors.textPrimary,
              ),
            ),
            const SizedBox(width: DesignTokens.spacingXS),
            const Icon(
              Icons.keyboard_arrow_down,
              color: HevyColors.textSecondary,
              size: DesignTokens.iconSmall, // 16dp (closest to 20)
            ),
          ],
        ),
      ),
    );
  }
}

class _RadarChart extends StatelessWidget {
  final Map<String, double> currentData;
  final Map<String, double> previousData;

  const _RadarChart({
    required this.currentData,
    required this.previousData,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadarChartPainter(
        currentData: currentData,
        previousData: previousData,
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final Map<String, double> currentData;
  final Map<String, double> previousData;

  _RadarChartPainter({
    required this.currentData,
    required this.previousData,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * 0.8;
    
    final axes = ['Back', 'Chest', 'Core', 'Shoulders', 'Arms', 'Legs'];
    final angleStep = (2 * 3.14159) / axes.length;
    
    // Draw grid circles - make more visible on black background
    final gridPaint = Paint()
      ..color = HevyColors.textTertiary.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    for (int i = 1; i <= 5; i++) {
      canvas.drawCircle(center, radius * (i / 5), gridPaint);
    }
    
    // Draw axes lines - make more visible
    final axisPaint = Paint()
      ..color = HevyColors.textTertiary.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    for (int i = 0; i < axes.length; i++) {
      final angle = (i * angleStep) - (3.14159 / 2); // Start from top
      final labelRadius = radius * 1.25;
      
      // Calculate end point using proper trigonometry
      final endX = center.dx + radius * 1.1 * math.cos(angle);
      final endY = center.dy + radius * 1.1 * math.sin(angle);
      final endPoint = Offset(endX, endY);
      
      canvas.drawLine(center, endPoint, axisPaint);
      
      // Draw axis labels using proper trigonometry
      final labelX = center.dx + labelRadius * math.cos(angle);
      final labelY = center.dy + labelRadius * math.sin(angle);
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: axes[i],
          style: const TextStyle(
            color: HevyColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(labelX - textPainter.width / 2, labelY - textPainter.height / 2),
      );
    }
    
    // Draw previous data polygon - make more visible
    final previousPath = Path();
    final previousPaint = Paint()
      ..color = HevyColors.textTertiary.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final previousStroke = Paint()
      ..color = HevyColors.textTertiary.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    
    bool firstPoint = true;
    for (int i = 0; i < axes.length; i++) {
      final angle = (i * angleStep) - (3.14159 / 2);
      final value = previousData[axes[i]] ?? 0.0;
      final distance = radius * value;
      // Use proper trigonometry for positioning
      final x = center.dx + distance * math.cos(angle);
      final y = center.dy + distance * math.sin(angle);
      
      if (firstPoint) {
        previousPath.moveTo(x, y);
        firstPoint = false;
      } else {
        previousPath.lineTo(x, y);
      }
    }
    previousPath.close();
    canvas.drawPath(previousPath, previousPaint);
    canvas.drawPath(previousPath, previousStroke);
    
    // Draw current data polygon - make more visible
    final currentPath = Path();
    final currentPaint = Paint()
      ..color = HevyColors.primary.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final currentStroke = Paint()
      ..color = HevyColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0; // Thicker for visibility
    
    firstPoint = true;
    for (int i = 0; i < axes.length; i++) {
      final angle = (i * angleStep) - (3.14159 / 2);
      final value = currentData[axes[i]] ?? 0.0;
      final distance = radius * value;
      // Use proper trigonometry for positioning
      final x = center.dx + distance * math.cos(angle);
      final y = center.dy + distance * math.sin(angle);
      
      if (firstPoint) {
        currentPath.moveTo(x, y);
        firstPoint = false;
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();
    canvas.drawPath(currentPath, currentPaint);
    canvas.drawPath(currentPath, currentStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: DesignTokens.spacingXS),
        Text(
          label,
          style: const TextStyle(
            fontSize: DesignTokens.bodySmall,
            color: HevyColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String change;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingM),
      decoration: BoxDecoration(
        color: HevyColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: DesignTokens.titleLarge,
              fontWeight: FontWeight.bold,
              color: HevyColors.textPrimary,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingXXS),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                size: DesignTokens.iconSmall, // 16dp (closest to 14)
                color: HevyColors.success,
              ),
              const SizedBox(width: DesignTokens.spacingXXS),
              Text(
                change,
                style: const TextStyle(
                  fontSize: DesignTokens.bodySmall,
                  color: HevyColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingXXS),
          Text(
            label,
            style: const TextStyle(
              fontSize: DesignTokens.bodySmall,
              color: HevyColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

