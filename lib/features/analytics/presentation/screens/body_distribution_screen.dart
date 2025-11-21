import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Body distribution screen (Hevy style)
class BodyDistributionScreen extends BaseScreen {
  const BodyDistributionScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: const Text('Body distribution'),
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
    // Mock data - in a real app, this would come from analytics
    final selectedWeek = DateTime(2025, 11, 4); // Week starting Nov 2
    final weekStart = selectedWeek.subtract(Duration(days: selectedWeek.weekday % 7));
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    final activeDays = [2, 3, 4, 5, 8]; // Days with workouts
    
    final muscleData = [
      _MuscleData(name: 'Total', sets: 72),
      _MuscleData(name: 'Abdominals', sets: 0),
      _MuscleData(name: 'Abductors', sets: 0),
      _MuscleData(name: 'Adductors', sets: 0),
      _MuscleData(name: 'Biceps', sets: 10),
      _MuscleData(name: 'Calves', sets: 0),
      _MuscleData(name: 'Cardio', sets: 2),
      _MuscleData(name: 'Chest', sets: 34),
      _MuscleData(name: 'Forearms', sets: 7),
      _MuscleData(name: 'Full Body', sets: 0),
      _MuscleData(name: 'Glutes', sets: 0),
      _MuscleData(name: 'Hamstrings', sets: 0),
      _MuscleData(name: 'Lats', sets: 8.5),
      _MuscleData(name: 'Lower Back', sets: 0),
      _MuscleData(name: 'Neck', sets: 1),
      _MuscleData(name: 'Quadriceps', sets: 0),
      _MuscleData(name: 'Shoulders', sets: 8),
      _MuscleData(name: 'Traps', sets: 2),
      _MuscleData(name: 'Triceps', sets: 14),
      _MuscleData(name: 'Upper Back', sets: 10.5),
      _MuscleData(name: 'Other', sets: 0),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date range selector
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.paddingScreen,
              vertical: DesignTokens.spacingM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: HevyColors.textPrimary,
                  onPressed: () {
                    // TODO: Previous week
                  },
                ),
                Text(
                  '${DateFormat('dd').format(weekStart)}-${DateFormat('dd MMMM yyyy').format(weekEnd)}',
                  style: const TextStyle(
                    fontSize: DesignTokens.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  color: HevyColors.textPrimary,
                  onPressed: () {
                    // TODO: Next week
                  },
                ),
              ],
            ),
          ),

          // Weekly calendar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: _WeeklyCalendar(
              weekStart: weekStart,
              activeDays: activeDays,
              onDayTap: (day) {
                // TODO: Filter by day
              },
            ),
          ),

          const SizedBox(height: DesignTokens.spacingL),

          // Anatomical models
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Row(
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
          ),

          const SizedBox(height: DesignTokens.spacingXL),

          // Muscle list header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Muscle',
                  style: TextStyle(
                    fontSize: DesignTokens.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
                Text(
                  'Sets',
                  style: TextStyle(
                    fontSize: DesignTokens.bodyMedium,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: DesignTokens.spacingS),

          // Muscle groups list
          ...muscleData.map((muscle) => _MuscleListItem(muscle: muscle)),
          
          const SizedBox(height: DesignTokens.spacingL),
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
    final weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
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
      height: 300,
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
    
    // Simplified anatomical figure
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
      // Front view arms
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
      // Back view arms (slightly different angle)
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
    
    // Highlight muscles
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

class _MuscleData {
  final String name;
  final double sets;

  _MuscleData({
    required this.name,
    required this.sets,
  });
}

class _MuscleListItem extends StatelessWidget {
  final _MuscleData muscle;

  const _MuscleListItem({required this.muscle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.paddingScreen,
        vertical: DesignTokens.spacingXXS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            muscle.name,
            style: const TextStyle(
              fontSize: DesignTokens.bodyMedium,
              color: HevyColors.textPrimary,
            ),
          ),
          Text(
            muscle.sets == muscle.sets.toInt()
                ? muscle.sets.toInt().toString()
                : muscle.sets.toString(),
            style: const TextStyle(
              fontSize: DesignTokens.bodyMedium,
              color: HevyColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

