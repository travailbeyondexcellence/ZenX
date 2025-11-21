import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/base_screen.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Workout list screen - Matches screenshot exactly
class WorkoutListScreen extends BaseScreen {
  const WorkoutListScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: HevyColors.background,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Workout',
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
    final routines = _generateMockRoutines();
    
    return SafeArea(
      top: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                DesignTokens.paddingScreen,
                DesignTokens.spacingXL,
                DesignTokens.paddingScreen,
                DesignTokens.spacingM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Start',
                    style: TextStyle(
                      fontSize: DesignTokens.titleLarge,
                      fontWeight: FontWeight.w600,
                      color: HevyColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  _QuickStartButton(
                    onTap: () => context.push('/workouts/active'),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.paddingScreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Routines',
                        style: TextStyle(
                          fontSize: DesignTokens.titleLarge,
                          fontWeight: FontWeight.w600,
                          color: HevyColors.textPrimary,
                        ),
                      ),
                      _IconSquareButton(
                        icon: Icons.add,
                        onTap: () {
                          // TODO: Add routine
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingM),
                  Row(
                    children: [
                      Expanded(
                        child: _RoutineActionButton(
                          icon: Icons.assignment_outlined,
                          label: 'New Routine',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacingM),
                      Expanded(
                        child: _RoutineActionButton(
                          icon: Icons.search_rounded,
                          label: 'Explore',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingL),
                  _MyRoutinesSection(routines: routines),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                DesignTokens.paddingScreen,
                DesignTokens.spacingXL,
                DesignTokens.paddingScreen,
                DesignTokens.spacingXXXL,
              ),
              child: const _WorkoutProgressBanner(),
            ),
          ),
        ],
      ),
    );
  }

  List<_Routine> _generateMockRoutines() {
    return [
      _Routine(
        name: 'Arms',
        exercises: [
          'Triceps Rope Pushdown',
          'Reverse Bar Grip Triceps',
          'Overhead Triceps Extension (Cable)',
          'Bicep Curl (Dumbbell)',
          'Hammer Curl (Dumbbell)',
        ],
      ),
      _Routine(
        name: 'Back workout',
        exercises: [
          'Pull Up',
          'Seated Cable Row - V Grip (Cable)',
          'Lat Pulldown (Cable)',
          'Iso-Lateral Row (Machine)',
          'Bent Over Row (Barbell)',
        ],
      ),
      _Routine(
        name: 'Push',
        exercises: [
          'Bench Press (Barbell)',
          'Shoulder Press (Dumbbell)',
          'Incline Bench Press (Barbell)',
          'Lateral Raise (Dumbbell)',
        ],
      ),
    ];
  }
}

class _QuickStartButton extends StatelessWidget {
  final VoidCallback onTap;

  const _QuickStartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DesignTokens.radiusL),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.paddingScreen,
          vertical: DesignTokens.spacingL,
        ),
        decoration: BoxDecoration(
          color: HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          border: Border.all(color: HevyColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingS),
              decoration: BoxDecoration(
                color: HevyColors.surfaceElevated,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
              child: const Icon(
                Icons.add,
                color: HevyColors.textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: DesignTokens.spacingM),
            const Expanded(
              child: Text(
                'Start Empty Workout',
                style: TextStyle(
                  fontSize: DesignTokens.titleLarge,
                  fontWeight: FontWeight.w600,
                  color: HevyColors.textPrimary,
                ),
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

class _RoutineActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _RoutineActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(DesignTokens.radiusL),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusL),
          border: Border.all(color: HevyColors.border),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingL,
          vertical: DesignTokens.spacingL,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingXS),
              decoration: BoxDecoration(
                color: HevyColors.surfaceElevated,
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
              ),
              child: Icon(
                icon,
                color: HevyColors.textPrimary,
                size: 18,
              ),
            ),
            const SizedBox(width: DesignTokens.spacingS),
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.bodyLarge,
                fontWeight: FontWeight.w600,
                color: HevyColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyRoutinesSection extends StatefulWidget {
  final List<_Routine> routines;

  const _MyRoutinesSection({required this.routines});

  @override
  State<_MyRoutinesSection> createState() => _MyRoutinesSectionState();
}

class _MyRoutinesSectionState extends State<_MyRoutinesSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Icon(
                _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                color: HevyColors.textPrimary,
                size: 20,
              ),
              const SizedBox(width: DesignTokens.spacingXS),
              Text(
                'My Routines (${widget.routines.length})',
                style: const TextStyle(
                  fontSize: DesignTokens.bodyLarge,
                  fontWeight: FontWeight.w500,
                  color: HevyColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: DesignTokens.spacingM),
          ...widget.routines.map((routine) => Padding(
                padding: const EdgeInsets.only(bottom: DesignTokens.spacingM),
                child: _RoutineCard(routine: routine),
              )),
        ],
      ],
    );
  }
}

class _RoutineCard extends StatelessWidget {
  final _Routine routine;

  const _RoutineCard({required this.routine});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HevyColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        border: Border.all(color: HevyColors.border),
      ),
      padding: const EdgeInsets.all(DesignTokens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  routine.name,
                  style: const TextStyle(
                    fontSize: DesignTokens.titleLarge,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
                color: HevyColors.textSecondary,
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingS),
          Text(
            routine.exercises.join(', '),
            style: const TextStyle(
              fontSize: DesignTokens.bodyMedium,
              color: HevyColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: DesignTokens.spacingL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push('/workouts/active'),
              style: ElevatedButton.styleFrom(
                backgroundColor: HevyColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                ),
              ),
              child: const Text(
                'Start Routine',
                style: TextStyle(
                  fontSize: DesignTokens.bodyLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconSquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconSquareButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: HevyColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: HevyColors.border),
          ),
          child: Icon(icon, size: 18, color: HevyColors.textPrimary),
        ),
      ),
    );
  }
}

class _WorkoutProgressBanner extends StatelessWidget {
  const _WorkoutProgressBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingL),
      decoration: BoxDecoration(
        color: HevyColors.surface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusL),
        border: Border.all(color: HevyColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workout in Progress',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: DesignTokens.spacingM),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                    backgroundColor: HevyColors.surfaceElevated,
                    foregroundColor: HevyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text(
                    'Resume',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingM),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                    backgroundColor: HevyColors.surfaceElevated,
                    foregroundColor: HevyColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                    ),
                  ),
                  icon: const Icon(Icons.close),
                  label: const Text(
                    'Discard',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Routine {
  final String name;
  final List<String> exercises;

  _Routine({
    required this.name,
    required this.exercises,
  });
}
