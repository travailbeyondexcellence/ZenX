import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import 'security.dart';
import 'rate_limiter.dart';

/// GraphQL client provider with authentication
final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final httpLink = HttpLink(
    AppConfig.apiBaseUrl,
  );

  final authLink = AuthLink(
    getToken: () async {
      final token = await SecurityManager.getAccessToken();
      return token != null ? 'Bearer $token' : null;
    },
  );

  // Error link for handling authentication errors and rate limiting
  final errorLink = Link.function(
    (request, [forward]) {
      // Check rate limit before making request
      final rateLimiter = GraphQLRateLimiter();
      if (!rateLimiter.canMakeRequest()) {
        rateLimiter.waitIfNeeded();
      }
      rateLimiter.recordRequest();

      return forward!(request).map((response) {
        if (response.errors != null) {
          for (final error in response.errors!) {
            // Handle token expiration
            if (error.extensions?['code'] == 'UNAUTHENTICATED') {
              // Trigger token refresh
              // This would be handled by a token refresh interceptor
            }
            // Handle rate limiting errors
            if (error.extensions?['code'] == 'RATE_LIMIT_EXCEEDED') {
              // Wait and retry
              // This would be handled by retry logic
            }
          }
        }
        return response;
      });
    },
  );

  final link = Link.from([
    errorLink,
    authLink,
    httpLink,
  ]);

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
});

/// GraphQL client provider for queries and mutations
final graphqlProvider = Provider<GraphQLClient>((ref) {
  return ref.watch(graphqlClientProvider);
});

