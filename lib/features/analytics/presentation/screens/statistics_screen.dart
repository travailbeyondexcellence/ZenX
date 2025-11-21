import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Statistics main screen (Hevy style)
class StatisticsScreen extends BaseScreen {
  const StatisticsScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: const Text('Statistics'),
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
    // Mock data - in real app, this would come from state management
    final activeDays = [4, 5, 6, 8]; // Days with workouts (Tue 4, Wed 5, Thu 6, Sat 8)
    final weekStart = DateTime(2025, 11, 3); // Monday, Nov 3

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Last 7 days body graph section
          Padding(
            padding: const EdgeInsets.all(DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Last 7 days body graph',
                      style: TextStyle(
                        fontSize: DesignTokens.bodyLarge,
                        fontWeight: FontWeight.w600,
                        color: HevyColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline),
                      color: HevyColors.textSecondary,
                      onPressed: () {
                        // TODO: Show help dialog
                      },
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingM),

                // Weekly calendar
                _WeeklyCalendar(
                  weekStart: weekStart,
                  activeDays: activeDays,
                  onDayTap: (day) {
                    // TODO: Filter by day
                  },
                ),
                const SizedBox(height: DesignTokens.spacingL),

                // Anatomical models
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Front view
                    Expanded(
                      child: _AnatomicalModel(
                        isFront: true,
                        highlightedMuscles: {
                          'Chest': HevyColors.primary,
                          'Shoulders': HevyColors.primary,
                          'Biceps': HevyColors.primary,
                          'Forearms': HevyColors.primary,
                        },
                      ),
                    ),
                    SizedBox(width: DesignTokens.spacingM),
                    // Back view
                    Expanded(
                      child: _AnatomicalModel(
                        isFront: false,
                        highlightedMuscles: {
                          'Lats': HevyColors.primary,
                          'Upper Back': HevyColors.primary,
                          'Shoulders': HevyColors.primary,
                          'Triceps': HevyColors.primary,
                          'Forearms': HevyColors.primary,
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(color: HevyColors.border, height: 32),

          // Advanced statistics section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Advanced statistics',
                  style: TextStyle(
                    fontSize: DesignTokens.bodySmall,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textSecondary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingM),

                // Set count per muscle group
                _StatisticCard(
                  icon: Icons.trending_up,
                  title: 'Set count per muscle group',
                  description: 'Number of sets logged for each muscle group.',
                  onTap: () => context.push('/analytics/set-count-per-muscle'),
                ),
                const SizedBox(height: DesignTokens.spacingS),

                // Muscle distribution (Chart)
                _StatisticCard(
                  icon: Icons.multiline_chart,
                  title: 'Muscle distribution (Chart)',
                  description: 'Compare your current and previous muscle distributions.',
                  onTap: () => context.push('/analytics/muscle-distribution'),
                ),
                const SizedBox(height: DesignTokens.spacingS),

                // Muscle distribution (Body)
                _StatisticCard(
                  icon: Icons.person,
                  title: 'Muscle distribution (Body)',
                  description: 'Weekly heat map of muscles worked.',
                  onTap: () => context.push('/analytics/body-distribution'),
                ),
                const SizedBox(height: DesignTokens.spacingS),

                // Main exercises
                _StatisticCard(
                  icon: Icons.fitness_center,
                  title: 'Main exercises',
                  description: 'List of exercises you do most often.',
                  onTap: () {
                    // TODO: Navigate to main exercises
                  },
                ),
                const SizedBox(height: DesignTokens.spacingS),

                // Leaderboard Exercises
                _StatisticCard(
                  icon: Icons.emoji_events,
                  title: 'Leaderboard Exercises',
                  description: 'List of the leaderboard-eligible exercises.',
                  onTap: () {
                    // TODO: Navigate to leaderboard exercises
                  },
                ),
                const SizedBox(height: DesignTokens.spacingS),

                // Monthly Report
                _StatisticCard(
                  icon: Icons.description,
                  title: 'Monthly Report',
                  description: 'Recap of your monthly workouts and statistics.',
                  onTap: () => context.push('/analytics/monthly-report'),
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

class _WeeklyCalendar extends StatelessWidget {
  final DateTime weekStart;
  final List<int> activeDays;
  final Function(int) onDayTap;

  const _WeeklyCalendar({
    required this.weekStart,
    required this.activeDays,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final day = weekStart.add(Duration(days: index));
        final isActive = activeDays.contains(day.day);
        
        return Expanded(
          child: GestureDetector(
            onTap: () => onDayTap(day.day),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingS),
              decoration: BoxDecoration(
                color: HevyColors.surfaceElevated,
                borderRadius: BorderRadius.circular(DesignTokens.radiusS),
              ),
              child: Column(
                children: [
                  Text(
                    weekdays[index],
                    style: const TextStyle(
                      fontSize: DesignTokens.bodySmall,
                      color: HevyColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingXXS),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive ? HevyColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: DesignTokens.bodyMedium,
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? HevyColors.textPrimary
                              : HevyColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AnatomicalModel extends StatelessWidget {
  final bool isFront;
  final Map<String, Color> highlightedMuscles;

  const _AnatomicalModel({
    required this.isFront,
    required this.highlightedMuscles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: HevyColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
      ),
      child: CustomPaint(
        painter: _AnatomicalModelPainter(
          isFront: isFront,
          highlightedMuscles: highlightedMuscles,
        ),
      ),
    );
  }
}

class _AnatomicalModelPainter extends CustomPainter {
  final bool isFront;
  final Map<String, Color> highlightedMuscles;

  _AnatomicalModelPainter({
    required this.isFront,
    required this.highlightedMuscles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = HevyColors.textSecondary;
    
    // Simplified anatomical figure (similar to body_distribution_screen)
    // Head
    canvas.drawCircle(
      Offset(centerX, size.height * 0.15),
      size.width * 0.1,
      paint,
    );
    
    // Torso
    final torsoPath = Path()
      ..moveTo(centerX - size.width * 0.15, size.height * 0.25)
      ..lineTo(centerX - size.width * 0.15, size.height * 0.6)
      ..lineTo(centerX + size.width * 0.15, size.height * 0.6)
      ..lineTo(centerX + size.width * 0.15, size.height * 0.25)
      ..close();
    canvas.drawPath(torsoPath, paint);
    
    // Arms
    if (isFront) {
      canvas.drawLine(
        Offset(centerX - size.width * 0.15, size.height * 0.35),
        Offset(centerX - size.width * 0.35, size.height * 0.5),
        paint,
      );
      canvas.drawLine(
        Offset(centerX + size.width * 0.15, size.height * 0.35),
        Offset(centerX + size.width * 0.35, size.height * 0.5),
        paint,
      );
    } else {
      canvas.drawLine(
        Offset(centerX - size.width * 0.15, size.height * 0.35),
        Offset(centerX - size.width * 0.3, size.height * 0.45),
        paint,
      );
      canvas.drawLine(
        Offset(centerX + size.width * 0.15, size.height * 0.35),
        Offset(centerX + size.width * 0.3, size.height * 0.45),
        paint,
      );
    }
    
    // Legs
    canvas.drawLine(
      Offset(centerX - size.width * 0.08, size.height * 0.6),
      Offset(centerX - size.width * 0.08, size.height * 0.85),
      paint,
    );
    canvas.drawLine(
      Offset(centerX + size.width * 0.08, size.height * 0.6),
      Offset(centerX + size.width * 0.08, size.height * 0.85),
      paint,
    );
    
    // Highlight muscles (similar to body_distribution_screen)
    final highlightPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    
    // Chest/Back highlight
    if ((isFront && highlightedMuscles.containsKey('Chest')) ||
        (!isFront && highlightedMuscles.containsKey('Lats'))) {
      highlightPaint.color = highlightedMuscles['Chest'] ?? 
                             highlightedMuscles['Lats'] ?? 
                             HevyColors.primary;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.4),
          width: size.width * 0.25,
          height: size.height * 0.15,
        ),
        highlightPaint,
      );
    }
    
    // Shoulders
    if (highlightedMuscles.containsKey('Shoulders')) {
      highlightPaint.color = highlightedMuscles['Shoulders']!;
      canvas.drawCircle(
        Offset(centerX - size.width * 0.25, size.height * 0.35),
        size.width * 0.08,
        highlightPaint,
      );
      canvas.drawCircle(
        Offset(centerX + size.width * 0.25, size.height * 0.35),
        size.width * 0.08,
        highlightPaint,
      );
    }
    
    // Arms
    if (highlightedMuscles.containsKey('Biceps') || 
        highlightedMuscles.containsKey('Triceps')) {
      highlightPaint.color = highlightedMuscles['Biceps'] ?? 
                             highlightedMuscles['Triceps'] ?? 
                             HevyColors.primary;
      canvas.drawCircle(
        Offset(centerX - size.width * 0.3, size.height * 0.45),
        size.width * 0.06,
        highlightPaint,
      );
      canvas.drawCircle(
        Offset(centerX + size.width * 0.3, size.height * 0.45),
        size.width * 0.06,
        highlightPaint,
      );
    }
    
    // Forearms
    if (highlightedMuscles.containsKey('Forearms')) {
      highlightPaint.color = highlightedMuscles['Forearms']!;
      canvas.drawCircle(
        Offset(centerX - size.width * 0.32, size.height * 0.5),
        size.width * 0.05,
        highlightPaint,
      );
      canvas.drawCircle(
        Offset(centerX + size.width * 0.32, size.height * 0.5),
        size.width * 0.05,
        highlightPaint,
      );
    }
    
    // Upper back
    if (!isFront && highlightedMuscles.containsKey('Upper Back')) {
      highlightPaint.color = highlightedMuscles['Upper Back']!;
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, size.height * 0.3),
          width: size.width * 0.2,
          height: size.height * 0.1,
        ),
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _StatisticCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _StatisticCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacingM),
        decoration: BoxDecoration(
          color: HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingS),
              decoration: BoxDecoration(
                color: HevyColors.surfaceElevated,
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
              ),
              child: Icon(
                icon,
                color: HevyColors.primary,
                size: DesignTokens.iconMedium, // 24dp
              ),
            ),
            const SizedBox(width: DesignTokens.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: DesignTokens.bodyLarge,
                      fontWeight: FontWeight.w600,
                      color: HevyColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingXXS),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: DesignTokens.bodySmall,
                      color: HevyColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: HevyColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

