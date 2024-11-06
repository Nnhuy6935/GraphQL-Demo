import 'package:demo/graphql_query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Comment extends StatefulWidget{
  late List comments ;
  late BuildContext context;
  Comment({required List data,
  required BuildContext context}){
    this.comments = data;
    this.context = context;
  } 
  @override
  State<StatefulWidget> createState() => _CommentState();
  
}

class _CommentState extends State<Comment> {
  late BuildContext ctx;
  late List comments ;
  List<bool> isEdit = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.comments = widget.comments;
    this.ctx = widget.context;
    for(int i = 0 ; i < comments.length; ++i)
      isEdit.add(false);
  }
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index){
            final comment = comments[index];
            final editController = TextEditingController(text: comment['body']);
            return Container(
              margin: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //AVATAR
                  Container(
                    width: 30,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_add_alt_1_rounded),
                  ),
                  //COMMENT INFRORMATION
                  Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //USER EMAIL
                      Text(
                        comment['email'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      //COMMENT CONTENT 
                      (isEdit[index]) ?
                        TextFormField(
                          controller: editController,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 4,
                        ) :
                        Text(
                          comment['body'].toString().replaceAll('\n', ' '),
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      //EDIT BUTTON 
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red, size: 20,),
                          (!isEdit[index]) ? 
                          TextButton(
                            onPressed: (){
                              //UPDATE COMMENT 
                              setState(() {
                                isEdit[index] = !isEdit[index];
                              });
                              // showEditDialog(int.parse(comment['id']), comment['name'], comment['email'], comment['body']);
                            }, 
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Colors.blue.shade400
                              ),  
                            ),
                          ) : 
                          Mutation(
                            options:MutationOptions(
                              document: gql(GraphqlQuery.updateComment),
                              onCompleted: (dynamic resultData){
                                if(resultData != null){
                                  /// show dialog to inform result here 
                                  print("UPDATE SUCCESS");
                                  showEditDialog(resultData);
                                }else {
                                  print("result data is null");
                                }
                              },
                              onError: (error){
                                print("ERROR --" + error.toString());
                              }
                            ), 
                            builder: (RunMutation runMutation, QueryResult? result){
                              return TextButton(
                                onPressed: (){
                                  setState(() {
                                    isEdit[index] = !isEdit[index];
                                  });
                                  runMutation(
                                    {
                                      "idUpdate" : comment['id'],
                                      "inputUpdate": {
                                        "name" : comment['name'],
                                        "body" : editController.value.text,
                                        "email": comment['email'],
                                      }
                                    }
                                  );
                                }, 
                                child:Text("Save"),
                              );
                            }
                          )
                        ],
                      )
                    ],
                  ),
                  )
                ],
              ),
            );
          }
        );
  }

  void showEditDialog(dynamic resultdata){
    bool isGetResult = false;
    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        title: Text("Update Comment Result"),
        content: Text(
          resultdata['updateComment']['body'],
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(ctx).pop();
            }, 
            child: Text("OK"),
          )
        ],
      ),
    );
  }
  
}

