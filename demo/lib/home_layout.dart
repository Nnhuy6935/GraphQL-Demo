import 'package:demo/graphql_config.dart';
import 'package:demo/list_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeLayout extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.initializeClient(), 
      child: MaterialApp(
        title: "GraphQL User Demo",
        home: UserListScreen(),
      )
    );
    
  }
}