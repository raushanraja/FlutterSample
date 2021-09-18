import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

ValueNotifier<GraphQLClient> getClient({
  required String uri,
  String? subscriptionUri,
  String? token,
}) {
  Link link = HttpLink(uri);
  if (subscriptionUri != null) {
    final WebSocketLink websocketLink = WebSocketLink(subscriptionUri,
        config: const SocketClientConfig(
            inactivityTimeout: Duration(seconds: 600)));

    final AuthLink authLink = AuthLink(
      // getToken: () async => 'Bearer ',
      // OR
      getToken: () => 'bearer $token',
    );
    link = Link.split((request) => request.isSubscription, websocketLink, link);
    if (token != null) {
      link = authLink.concat(link);
    }
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link,
    ),
  );
}

/// Wraps the root application with the `graphql_flutter` client.
/// We use the cache for all state management.
class ClientProvider extends StatelessWidget {
  ClientProvider(
      {Key? key,
      required this.child,
      required String uri,
      String? subscriptionUri,
      String? token})
      : client = getClient(
          uri: uri,
          subscriptionUri: subscriptionUri,
          token: token,
        ),
        super(key: key);

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}
