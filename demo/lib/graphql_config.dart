//url : https://countries.trevorblades.com/
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// class GraphQLConfiguration{
//   static HttpLink httpLink = HttpLink(
//     'https://countries.trevorblades.com/',
//   );
//   static ValueNotifier<GraphQLClient> initializeClient(){
//     ValueNotifier<GraphQLClient> client = ValueNotifier(
//       GraphQLClient(
//         link: httpLink,
//         cache: GraphQLCache(store: InMemoryStore(),)
//       ),
//     );
//     return client;
//   }
//   static GraphQLClient client = GraphQLClient(
//     link: httpLink,
//     cache: GraphQLCache(store: InMemoryStore()),
//   );
// }


class GraphQLConfiguration{
  static HttpLink httpLink = HttpLink(
    'https://graphqlzero.almansi.me/api',
  );
  static ValueNotifier<GraphQLClient> initializeClient(){
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore(),)
      ),
    );
    return client;
  }
  static GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}





