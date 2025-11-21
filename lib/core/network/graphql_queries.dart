/// GraphQL queries and mutations for ZenX
/// These will be used by the GraphQL client to communicate with the API Gateway

class GraphQLQueries {
  GraphQLQueries._();

  // Authentication
  static const String login = '''
    mutation Login(\$email: String!, \$password: String!) {
      login(email: \$email, password: \$password) {
        accessToken
        refreshToken
        user {
          id
          email
          name
        }
      }
    }
  ''';

  static const String register = '''
    mutation Register(\$email: String!, \$password: String!, \$name: String!) {
      register(email: \$email, password: \$password, name: \$name) {
        accessToken
        refreshToken
        user {
          id
          email
          name
        }
      }
    }
  ''';

  // Workouts
  static const String getWorkouts = '''
    query GetWorkouts(\$userId: ID!, \$limit: Int, \$offset: Int) {
      workouts(userId: \$userId, limit: \$limit, offset: \$offset) {
        id
        userId
        name
        notes
        startedAt
        completedAt
        durationSeconds
        totalVolumeKg
        createdAt
        updatedAt
      }
    }
  ''';

  static const String getWorkout = '''
    query GetWorkout(\$id: ID!) {
      workout(id: \$id) {
        id
        userId
        name
        notes
        startedAt
        completedAt
        durationSeconds
        totalVolumeKg
        exercises {
          id
          exerciseId
          orderIndex
          exercise {
            id
            name
            primaryMuscleGroup
          }
          sets {
            id
            setNumber
            reps
            weightKg
            rpe
            notes
            completed
          }
        }
        createdAt
        updatedAt
      }
    }
  ''';

  static const String createWorkout = '''
    mutation CreateWorkout(\$input: CreateWorkoutInput!) {
      createWorkout(input: \$input) {
        id
        userId
        name
        createdAt
      }
    }
  ''';

  static const String updateWorkout = '''
    mutation UpdateWorkout(\$id: ID!, \$input: UpdateWorkoutInput!) {
      updateWorkout(id: \$id, input: \$input) {
        id
        name
        notes
        updatedAt
      }
    }
  ''';

  // Exercises
  static const String getExercises = '''
    query GetExercises(\$category: String, \$muscleGroup: String, \$limit: Int, \$offset: Int) {
      exercises(category: \$category, muscleGroup: \$muscleGroup, limit: \$limit, offset: \$offset) {
        id
        name
        description
        category
        primaryMuscleGroup
        secondaryMuscleGroups
        equipmentRequired
        difficultyLevel
        isCustom
        createdAt
      }
    }
  ''';

  static const String getExercise = '''
    query GetExercise(\$id: ID!) {
      exercise(id: \$id) {
        id
        name
        description
        category
        primaryMuscleGroup
        secondaryMuscleGroups
        equipmentRequired
        difficultyLevel
        isCustom
        createdAt
      }
    }
  ''';

  // Analytics
  static const String getPersonalRecords = '''
    query GetPersonalRecords(\$userId: ID!, \$exerciseId: ID) {
      personalRecords(userId: \$userId, exerciseId: \$exerciseId) {
        id
        userId
        exerciseId
        recordType
        value
        achievedAt
        workoutId
      }
    }
  ''';

  // Profile
  static const String getBodyMeasurements = '''
    query GetBodyMeasurements(\$userId: ID!, \$limit: Int, \$offset: Int) {
      bodyMeasurements(userId: \$userId, limit: \$limit, offset: \$offset) {
        id
        userId
        measurementDate
        weightKg
        bodyFatPercentage
        muscleMassKg
        measurements
        createdAt
      }
    }
  ''';
}

/// GraphQL subscriptions for real-time updates
class GraphQLSubscriptions {
  GraphQLSubscriptions._();

  static const String workoutUpdates = '''
    subscription WorkoutUpdates(\$workoutId: ID!) {
      workoutUpdates(workoutId: \$workoutId) {
        id
        type
        data
        timestamp
      }
    }
  ''';

  static const String notifications = '''
    subscription Notifications(\$userId: ID!) {
      notifications(userId: \$userId) {
        id
        type
        title
        body
        data
        read
        createdAt
      }
    }
  ''';
}









