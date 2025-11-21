import 'package:flutter/foundation.dart';

/// Application configuration based on build variant
class AppConfig {
  AppConfig._();

  /// Current environment
  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  /// Check if running in development
  static bool get isDevelopment => environment == 'development';

  /// Check if running in staging
  static bool get isStaging => environment == 'staging';

  /// Check if running in production
  static bool get isProduction => environment == 'production';

  /// API base URL based on environment
  static String get apiBaseUrl {
    switch (environment) {
      case 'production':
        return 'https://api.zenx.app/graphql';
      case 'staging':
        return 'https://api-staging.zenx.app/graphql';
      case 'development':
      default:
        return 'https://api-dev.zenx.app/graphql';
    }
  }

  /// WebSocket URL for subscriptions
  static String get websocketUrl {
    switch (environment) {
      case 'production':
        return 'wss://api.zenx.app/graphql';
      case 'staging':
        return 'wss://api-staging.zenx.app/graphql';
      case 'development':
      default:
        return 'ws://api-dev.zenx.app/graphql';
    }
  }

  /// JWT token expiry duration (15 minutes)
  static const Duration tokenExpiry = Duration(minutes: 15);

  /// Refresh token expiry duration (7 days)
  static const Duration refreshTokenExpiry = Duration(days: 7);

  /// Token refresh threshold (5 minutes before expiry)
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);

  /// Cache TTL configurations
  static const Duration cacheUserSessionTTL = Duration(minutes: 15);
  static const Duration cacheExerciseLibraryTTL = Duration(hours: 1);
  static const Duration cacheRecentWorkoutsTTL = Duration(minutes: 5);
  static const Duration cacheUserProfileTTL = Duration(minutes: 30);
  static const Duration cachePersonalRecordTTL = Duration(hours: 1);

  /// Pagination defaults
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  /// Request batching
  static const Duration batchDelay = Duration(milliseconds: 50);
  static const int maxBatchSize = 10;

  /// Enable verbose logging
  static bool get enableVerboseLogging => !isProduction;

  /// Enable debug overlays
  static bool get enableDebugOverlays => kDebugMode && isDevelopment;

  /// App version
  static const String appVersion = '1.0.0';

  /// Build number
  static const String buildNumber = String.fromEnvironment(
    'BUILD_NUMBER',
    defaultValue: '1',
  );

  /// Full version string
  static String get fullVersion => '$appVersion+$buildNumber';
}

