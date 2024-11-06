import 'package:demo/components/comments.dart';
import 'package:demo/graphql_query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommentScreen extends StatefulWidget{
  late int id ;
  CommentScreen({
    required int id,
  }){
    this.id = id;
  }
  @override
  State<StatefulWidget> createState() => _CommentState();
}

class _CommentState extends State<CommentScreen>{
  late int id;
  var cmtController = TextEditingController();
  @override
  void initState() {
    super.initState();
    this.id = widget.id;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Query(
        options: QueryOptions(document: gql(GraphqlQuery.getCommentFromPostId(id))), 
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}){
          print("COME TO BUILDER");
          if(result.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(result.hasException){
            print("ERROR NHA ...." + result.exception.toString());
            return Center(
              child: Text("Error: ${result.exception.toString()}"),
            );
          }
          final List comments = result.data?['post']['comments']['data'];
          final postTitle = result.data?['post']['title'];
          final postBody = result.data?['post']['body'];
          final user = result.data?['post']['user'];
          

          return Column(
            children: [
              
              // Expanded(
              //   child: Post(postTitle: postTitle, postContent: postBody, user: user),
              // ),
              Expanded(
                child: Comment(data: comments, context: context ,),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 50,
                child: 
                Mutation(
                  options: MutationOptions(
                    document: gql(GraphqlQuery.addCommentToPost()),
                    onCompleted: (dynamic resultData){
                      if(resultData != null){
                        print(resultData);
                        showResultAddComment(resultData);
                      }else{
                        print("result data is null");
                      }
                    },  
                    onError: (error){
                      return Center(
                        child: Text(
                          "Error: ${error.toString()}",
                          style: TextStyle(
                            color: Colors.red
                          ),  
                        ),
                      );
                    }
                  ), 
                  builder: (RunMutation runMutation, QueryResult? result){
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cmtController,
                            decoration: InputDecoration(
                              hintText: "Enter your comment",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                )
                              )
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            var cmtContent = cmtController.value.text;
                            // print(cmtContent);
                            runMutation(
                              {
                                "commentInput" : {
                                    "name": "My Name",
                                    "email" : "newuser@gmail.com", 
                                    "body": cmtContent
                                }
                              }
                            );
                            cmtController = TextEditingController();
                          }, 
                          icon: Icon(Icons.send)
                        )
                      ],
                    );
                  }
                )
              )             
            ],
          );
        }
      ),
    );
  }
  
  void showResultAddComment(dynamic result){
    showDialog(
      context: context, 
      builder: (ctx)=> AlertDialog(
        title:  Text("Add New Comment"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              result['createComment']['name'],
            ),
            Text(
              result['createComment']['email'],
            ),
            Text(
              result['createComment']['body'],
            ),

          ],
        ),
        actions: <Widget> [
          TextButton(
            onPressed: (){
              Navigator.of(ctx).pop();
            }, 
            child: Text("Ok")
          )
        ],
      )
    );
  }
}