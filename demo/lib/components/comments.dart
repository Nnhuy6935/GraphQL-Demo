import 'package:flutter/material.dart';

class Comments extends StatelessWidget{
  late List comments ;
  Comments({required List data}){
    this.comments = data;
  } 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index){
            final comment = comments[index];
            return Container(
              margin: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                  Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment['email'],
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
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
                    ],
                  ),
                  )
                ],
              ),
            );
          }
        );

  }
  
}


// class Post extends StatelessWidget{
//   late dynamic post;
//   late dynamic user;
//   Post({required var post,
//     required var user,
//   }) {
//     this.post = post;
//     this.user = user;
//   }
//   @override
//   Widget build(BuildContext context) {
//     print("USER ---- " +user);
//     print("POST ----" + post);
//     return Center(child: Text("TEMP Data"),);
//     // Card(
//     //   color: Color(0xffc8d9e6),
//     //   child: Padding(
//     //     padding: EdgeInsets.all(10),
//     //     child: Column(
//     //       children: [
//     //         //USER INFORMATION 
//     //         Row(
//     //           mainAxisAlignment: MainAxisAlignment.start,
//     //           children: [
//     //             Container(
//     //               margin: EdgeInsets.only(right: 20),
//     //               decoration: BoxDecoration(
//     //                 shape: BoxShape.circle,
//     //                 border: Border.all(
//     //                   width: 1.0,
//     //                   color: Colors.black
//     //                 )
//     //               ),
//     //               child: Icon(Icons.person, size: 30,),
//     //             ),
//     //             Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 Text(post['username']),
//     //                 Text(post['email'])
//     //               ],
//     //             )
//     //           ],
//     //         ),
//     //         SizedBox(height: 20,),
//     //         //CONTENT OF POST 
//     //         Container(
//     //           margin: EdgeInsets.all(5),
//     //           padding: EdgeInsets.all(15),
//     //           decoration: BoxDecoration(
//     //             borderRadius: BorderRadius.circular(5),
//     //             border: Border.all(
//     //               color: Colors.black,
//     //               width: 1.0
//     //             ),
//     //           ),
//     //           child: Padding(
//     //             padding: EdgeInsets.all(10),
//     //             child: Column(
//     //               children: [
//     //                 Text(
//     //                   post['title'],
//     //                   textAlign: TextAlign.justify,
//     //                   style: TextStyle(
//     //                     fontSize: 18,
//     //                     fontWeight: FontWeight.bold,
//     //                   ),
//     //                 ),
//     //                 Text(
//     //                   post['body'],
//     //                   textAlign: TextAlign.justify,

//     //                 )
//     //               ],
//     //             ),  
//     //           ),
//     //         )
//     //       ],
//     //     ),  
//     //   ),
//     // );
//   }
  
// }