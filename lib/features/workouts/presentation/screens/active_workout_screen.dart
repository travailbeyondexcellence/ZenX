import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design/design_tokens.dart';
import '../../../../core/design/hevy_colors.dart';

/// Active workout screen - Log Workout (matches screenshot exactly)
class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  final String workoutId;

  const ActiveWorkoutScreen({
    super.key,
    required this.workoutId,
  });

  @override
  ConsumerState<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  DateTime? _startTime;
  bool _isPaused = false;
  bool _isTimerMode = true; // true = Timer, false = Stopwatch
  Duration _timerDuration = const Duration(minutes: 1); // Default 1 minute
  
  // Mock data - TODO: Replace with actual data from database
  final List<WorkoutExercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _elapsed = DateTime.now().difference(_startTime!);
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _timer?.cancel();
      } else {
        _startTimer();
      }
    });
  }

  String formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) {
      return '${seconds}s';
    }
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes < 60) {
      return '${minutes}min';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  String _formatTimer(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _adjustTimer(int seconds) {
    setState(() {
      _timerDuration = Duration(
        seconds: (_timerDuration.inSeconds + seconds).clamp(0, 3600),
      );
    });
  }

  void _addExercise() {
    // TODO: Navigate to exercise selector
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: const Text('Exercise selector coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _finishWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finish Workout'),
        content: Text('Duration: ${formatDuration(_elapsed)}\n\nSave this workout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalVolume = _exercises.fold<double>(
      0.0,
      (sum, exercise) => sum + exercise.sets.fold<double>(
        0.0,
        (setSum, set) => setSum + (set.weight * (set.reps ?? 0)),
      ),
    );
    final totalSets = _exercises.fold<int>(
      0,
      (sum, exercise) => sum + exercise.sets.length,
    );

    return Scaffold(
      backgroundColor: HevyColors.background,
      appBar: AppBar(
        backgroundColor: HevyColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          color: HevyColors.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Log Workout',
          style: TextStyle(
            fontSize: DesignTokens.titleLarge,
            fontWeight: FontWeight.w600,
            color: HevyColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingS),
            child: Container(
              decoration: BoxDecoration(
                color: HevyColors.surface,
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                border: Border.all(color: HevyColors.border),
              ),
              child: IconButton(
                icon: const Icon(Icons.timer_outlined),
                color: HevyColors.textPrimary,
                tooltip: 'Timer',
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: DesignTokens.paddingScreen,
              left: DesignTokens.spacingS,
              top: DesignTokens.spacingS,
              bottom: DesignTokens.spacingS,
            ),
            child: ElevatedButton(
              onPressed: _finishWorkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: HevyColors.primary,
                foregroundColor: HevyColors.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingL,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Finish',
                style: TextStyle(
                  fontSize: DesignTokens.bodyLarge,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _exercises.isEmpty
          ? _EmptyWorkoutState(
              onAddExercise: _addExercise,
              duration: _elapsed,
              volume: totalVolume,
              sets: totalSets,
            )
          : ListView(
              padding: const EdgeInsets.all(DesignTokens.paddingScreen),
              children: [
                // Metrics
                _WorkoutMetrics(
                  duration: _elapsed,
                  volume: totalVolume,
                  sets: totalSets,
                ),
                const SizedBox(height: DesignTokens.spacingXL),
                // Clock section
                _ClockSection(
                  isTimerMode: _isTimerMode,
                  timerDuration: _timerDuration,
                  onToggleMode: () {
                    setState(() {
                      _isTimerMode = !_isTimerMode;
                    });
                  },
                  onAdjustTimer: _adjustTimer,
                ),
                const SizedBox(height: DesignTokens.spacingXL),
                // Exercise list
                ..._exercises.asMap().entries.map((entry) {
                  final index = entry.key;
                  final exercise = entry.value;
                  return _ExerciseCard(
                    exercise: exercise,
                    exerciseIndex: index,
                    onAddSet: () => _addSet(index),
                    onUpdateSet: (setIndex, reps, weight) =>
                        _updateSet(index, setIndex, reps, weight),
                    onToggleComplete: (setIndex) =>
                        _toggleSetComplete(index, setIndex),
                  );
                }),
                const SizedBox(height: DesignTokens.spacingM),
                OutlinedButton.icon(
                  onPressed: _addExercise,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Exercise'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
    );
  }

  void _addSet(int exerciseIndex) {
    setState(() {
      final exercise = _exercises[exerciseIndex];
      final lastSet = exercise.sets.isNotEmpty ? exercise.sets.last : null;
      exercise.sets.add(WorkoutSet(
        reps: lastSet?.reps ?? 10,
        weight: lastSet?.weight ?? 0.0,
        completed: false,
      ));
    });
  }

  void _updateSet(int exerciseIndex, int setIndex, int? reps, double? weight) {
    setState(() {
      final set = _exercises[exerciseIndex].sets[setIndex];
      set.reps = reps ?? set.reps;
      set.weight = weight ?? set.weight;
    });
  }

  void _toggleSetComplete(int exerciseIndex, int setIndex) {
    setState(() {
      _exercises[exerciseIndex].sets[setIndex].completed =
          !_exercises[exerciseIndex].sets[setIndex].completed;
    });
  }
}

class _WorkoutMetrics extends StatelessWidget {
  final Duration duration;
  final double volume;
  final int sets;

  const _WorkoutMetrics({
    required this.duration,
    required this.volume,
    required this.sets,
  });

  String formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) {
      return '${seconds}s';
    }
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes < 60) {
      return '${minutes}min';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingL),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: HevyColors.border),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _MetricItem(
              label: 'Duration',
              value: formatDuration(duration),
              valueColor: HevyColors.primary,
              alignStart: true,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: HevyColors.border,
          ),
          Expanded(
            child: _MetricItem(
              label: 'Volume',
              value: '${volume.toStringAsFixed(0)} kg',
              alignStart: true,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: HevyColors.border,
          ),
          Expanded(
            child: _MetricItem(
              label: 'Sets',
              value: sets.toString(),
              alignStart: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool alignStart;

  const _MetricItem({
    required this.label,
    required this.value,
    this.valueColor,
    this.alignStart = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignStart ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: DesignTokens.bodySmall,
            color: HevyColors.textSecondary,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingXXS),
        Text(
          value,
          style: TextStyle(
            fontSize: DesignTokens.titleMedium,
            fontWeight: FontWeight.w600,
            color: valueColor ?? HevyColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ClockSection extends StatelessWidget {
  final bool isTimerMode;
  final Duration timerDuration;
  final VoidCallback onToggleMode;
  final Function(int) onAdjustTimer;

  const _ClockSection({
    required this.isTimerMode,
    required this.timerDuration,
    required this.onToggleMode,
    required this.onAdjustTimer,
  });

  String _formatTimer(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HevyColors.surfaceElevated,
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 18,
                  color: HevyColors.textSecondary,
                ),
                SizedBox(width: DesignTokens.spacingS),
                Text(
                  'Clock',
                  style: TextStyle(
                    fontSize: DesignTokens.titleMedium,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingM),
            // Timer/Stopwatch toggle
            Row(
              children: [
                Expanded(
                  child: _ModeToggle(
                    label: 'Timer',
                    isSelected: isTimerMode,
                    onTap: () {
                      if (!isTimerMode) onToggleMode();
                    },
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingS),
                Expanded(
                  child: _ModeToggle(
                    label: 'Stopwatch',
                    isSelected: !isTimerMode,
                    onTap: () {
                      if (isTimerMode) onToggleMode();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingXL),
            // Circular timer
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: HevyColors.primary,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    _formatTimer(timerDuration),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w300,
                      color: HevyColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingXL),
            // Adjust buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => onAdjustTimer(-15),
                  child: const Text(
                    '-15s',
                    style: TextStyle(
                      fontSize: DesignTokens.bodyLarge,
                      color: HevyColors.primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Start timer
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HevyColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: DesignTokens.bodyLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => onAdjustTimer(15),
                  child: const Text(
                    '+15s',
                    style: TextStyle(
                      fontSize: DesignTokens.bodyLarge,
                      color: HevyColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeToggle({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingS),
        decoration: BoxDecoration(
          color: isSelected ? HevyColors.primary : HevyColors.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.bodyMedium,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : HevyColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Empty workout state - matches screenshot exactly
class _EmptyWorkoutState extends StatelessWidget {
  final VoidCallback onAddExercise;
  final Duration duration;
  final double volume;
  final int sets;

  const _EmptyWorkoutState({
    required this.onAddExercise,
    required this.duration,
    required this.volume,
    required this.sets,
  });

  String formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) {
      return '${seconds}s';
    }
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    if (minutes < 60) {
      return '${minutes}min';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.paddingScreen),
      child: Column(
        children: [
          _WorkoutMetrics(
            duration: duration,
            volume: volume,
            sets: sets,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 72,
                  color: HevyColors.textSecondary.withValues(alpha: 0.4),
                ),
                const SizedBox(height: DesignTokens.spacingL),
                const Text(
                  'Get started',
                  style: TextStyle(
                    fontSize: DesignTokens.titleLarge,
                    fontWeight: FontWeight.w600,
                    color: HevyColors.textPrimary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingS),
                const Text(
                  'Add an exercise to start your workout',
                  style: TextStyle(
                    fontSize: DesignTokens.bodyMedium,
                    color: HevyColors.textSecondary,
                  ),
                ),
                const SizedBox(height: DesignTokens.spacingXL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onAddExercise,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Add Exercise',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HevyColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: DesignTokens.spacingM,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: DesignTokens.spacingXL),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                    backgroundColor: HevyColors.surface,
                    foregroundColor: HevyColors.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                      side: const BorderSide(color: HevyColors.border),
                    ),
                  ),
                  child: const Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingM),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingM),
                    backgroundColor: HevyColors.surface,
                    foregroundColor: HevyColors.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                      side: const BorderSide(color: HevyColors.border),
                    ),
                  ),
                  child: const Text(
                    'Discard Workout',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingXL),
        ],
      ),
    );
  }
}

/// Exercise card widget
class _ExerciseCard extends StatelessWidget {
  final WorkoutExercise exercise;
  final int exerciseIndex;
  final VoidCallback onAddSet;
  final Function(int, int?, double?) onUpdateSet;
  final Function(int) onToggleComplete;

  const _ExerciseCard({
    required this.exercise,
    required this.exerciseIndex,
    required this.onAddSet,
    required this.onUpdateSet,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HevyColors.surfaceElevated,
      margin: const EdgeInsets.only(bottom: DesignTokens.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: const TextStyle(
                fontSize: DesignTokens.titleMedium,
                fontWeight: FontWeight.w600,
                color: HevyColors.textPrimary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingM),
            ...exercise.sets.asMap().entries.map((entry) {
              final index = entry.key;
              final set = entry.value;
              return _SetRow(
                set: set,
                setIndex: index,
                onUpdate: (reps, weight) => onUpdateSet(index, reps, weight),
                onToggleComplete: () => onToggleComplete(index),
              );
            }),
            const SizedBox(height: DesignTokens.spacingS),
            OutlinedButton.icon(
              onPressed: onAddSet,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Set'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  final WorkoutSet set;
  final int setIndex;
  final Function(int?, double?) onUpdate;
  final VoidCallback onToggleComplete;

  const _SetRow({
    required this.set,
    required this.setIndex,
    required this.onUpdate,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacingS),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '${setIndex + 1}',
              style: const TextStyle(
                fontSize: DesignTokens.bodyMedium,
                color: HevyColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Reps',
                hintStyle: const TextStyle(color: HevyColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusS),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final reps = int.tryParse(value);
                onUpdate(reps, set.weight);
              },
            ),
          ),
          const SizedBox(width: DesignTokens.spacingS),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Weight',
                hintStyle: const TextStyle(color: HevyColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusS),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final weight = double.tryParse(value);
                onUpdate(set.reps, weight);
              },
            ),
          ),
          const SizedBox(width: DesignTokens.spacingS),
          SizedBox(
            width: 40,
            child: Checkbox(
              value: set.completed,
              onChanged: (_) => onToggleComplete(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Data models (temporary - will be replaced with actual entities)
class WorkoutExercise {
  final String id;
  final String name;
  final List<WorkoutSet> sets;

  WorkoutExercise({
    required this.id,
    required this.name,
    required this.sets,
  });
}

class WorkoutSet {
  int? reps;
  double weight;
  bool completed;

  WorkoutSet({
    this.reps,
    required this.weight,
    required this.completed,
  });
}
