import 'package:demo/comment_screen.dart';
import 'package:demo/graphql_query.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _UserListState();
}
class _UserListState extends State<UserListScreen>{
  List<bool> isFavorite = [];
  bool isCommentShow = false;
  List<String> lstAvatar = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Query(
        options: QueryOptions(document: gql(GraphqlQuery.getAllPost)), 
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}){
          if(result.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(result.hasException){
            print(result.exception.toString());
            return Center(
              child: Text("Error: ${result.exception.toString()}"),
            );
          }
          final List posts = result.data!['posts']['data'];
          for(int i = 0 ; i < posts.length; ++i)
            isFavorite.add(false);
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
              final post = posts[index];
              return 
                Stack(
                  children: [
                    Card(
                      color: Color(0xffc8d9e6),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // USER INFORMATION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Image.asset('assets/image/avatar.png', width: 30, height: 30,),
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage(lstAvatar[index % 5]),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(right: 20),
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     border: Border.all(
                                //       width: 1.0,
                                //       color: Colors.black
                                //     )
                                //   ),
                                //   child: Icon(Icons.person, size: 30,),
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(post['user']['username']),
                                    Text(post['user']['email'])
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            //CONTENT OF POST 
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      post['title'],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),  
                                    ),
                                    Text(
                                      post['body'],
                                      textAlign: TextAlign.justify,  
                                    ),
                                  ],
                                ),  
                              )
                            ),
                            // SizedBox(height: 10,),
                            //BOTTOM NAVIGATOR
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 5,),
                                IconButton(
                                  onPressed: (){
                                    setState(() {
                                        if(isFavorite[index] == true)
                                          isFavorite[index] = false;
                                        else isFavorite[index] = true;
                                    });
                                  }, 
                                  icon: isFavorite[index] ? Icon(Icons.favorite, color: Colors.red,)  :Icon(Icons.favorite_border)
                                ),
                                IconButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen(id: int.parse(post['id']))));
                                  }, 
                                icon: Icon(Icons.comment_outlined),
                                )
                              ],

                            )
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
    );
  }
}