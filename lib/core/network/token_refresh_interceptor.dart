import '../utils/result.dart';
import '../errors/failures.dart';
import 'security.dart';

/// Token refresh interceptor for handling JWT token expiration
class TokenRefreshInterceptor {
  TokenRefreshInterceptor._();

  /// Refresh access token using refresh token
  static Future<Result<String>> refreshToken() async {
    try {
      final refreshToken = await SecurityManager.getRefreshToken();
      if (refreshToken == null) {
        return const Result.failure(
          Failure.network(message: 'No refresh token available'),
        );
      }

      // TODO: Implement GraphQL mutation to refresh token
      // This would call the API Gateway's refreshToken mutation
      // For now, return a placeholder

      // Example:
      // final client = GraphQLClient(...);
      // final result = await client.mutate(
      //   MutationOptions(
      //     document: gql(GraphQLQueries.refreshToken),
      //     variables: {'refreshToken': refreshToken},
      //   ),
      // );

      // if (result.hasException) {
      //   return Result.failure(
      //     Failure.network(message: result.exception.toString()),
      //   );
      // }

      // final newAccessToken = result.data?['refreshToken']['accessToken'];
      // final expiry = DateTime.parse(result.data?['refreshToken']['expiresAt']);

      // await SecurityManager.saveAccessToken(newAccessToken, expiry);

      // return Result.success(newAccessToken);

      return const Result.failure(
        Failure.network(message: 'Token refresh not implemented'),
      );
    } catch (e) {
      return Result.failure(
        Failure.network(message: e.toString()),
      );
    }
  }

  /// Check and refresh token if needed
  static Future<Result<String?>> ensureValidToken() async {
    final isExpired = await SecurityManager.isTokenExpired();
    if (!isExpired) {
      final token = await SecurityManager.getAccessToken();
      return Result.success(token);
    }

    final needsRefresh = await SecurityManager.needsRefresh();
    if (!needsRefresh) {
      // Token expired but can't refresh
      await SecurityManager.clearAuthData();
      return const Result.failure(
        Failure.network(message: 'Token expired and cannot be refreshed'),
      );
    }

    // Attempt to refresh
    final refreshResult = await refreshToken();
    return refreshResult.when(
      success: (newToken) => Result.success(newToken),
      failure: (failure) {
        // If refresh fails, clear auth data
        SecurityManager.clearAuthData();
        return Result.failure(failure);
      },
    );
  }
}

