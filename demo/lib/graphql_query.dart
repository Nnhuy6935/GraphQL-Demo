class GraphqlQuery {
  // static String readAllUser= """
  //   query {
  //     users {
  //       data {
  //         id
  //         name
  //         username
  //         phone
  //       }
  //     }
  //   }
  // """;
  // static var userinput = {
  //   "userinput": {
  //     "name" : "Nguyen thi như Ý",
  //     "username": "nnhuy",
  //     "email": "myemail@gmail.com"
  //   }
  // };
  // static String createUser = """
  // mutation(
  //   $userinput: CreateUserInput!
  // ){
  //   createUser(input: $userinput){
  //     name,
  //     username,
  //     email,
  //   }
  // }
  // """;

 

  static String getAllPost = """
    query{
      posts{
        data{
          id
          title
          body
          user{
            username
            email
          }
        }
      }
    }

  """;
  // static String getAllComment = """
  //   query{
  //     comments{
  //       data{
  //         id
  //         email
  //         name
  //         body
  //         post{
  //           id
  //           title
  //           body
  //         }
  //       }
  //     }
  //   }
  // """;

  static String getCommentWithId(int id){
    return """
      query{
        comment(id: $id){
          name
          email
          body
          id
        }
      }
    """;
  }
  //USED
  static String getCommentFromPostId(int id){
    return 
    """
      query {
        post(
          id: $id){
          title
          body
          user{
            username
            email
          }
          comments{
            data{
              id
              name
              email
              body
            }
          }
        }
      }
    """;
  }
  // static String getPostWithId(int id){
  //   return """
  //     query{
  //       post(id: $id){

  //       }
  //     }
  //   """;
  // }
  //USED 
  static String addCommentToPost(
    ){
    return r'''
    mutation($commentInput: CreateCommentInput!){
      createComment(input : $commentInput){
				id
        name
        email
        body
      }
    }
    ''';
  }
  static String updateComment = r'''
   mutation(
      $idUpdate: ID!
      $inputUpdate: UpdateCommentInput!
    ){
      updateComment(id: $idUpdate, input: $inputUpdate){
        id 
        name
        email
        body
      }
    }
  ''';
}

String sampleData = """
  {
    "idUpdate": 1,
    "inputUpdate": {
      "name" : "Nguyen thi như Ý",
      "body": "update to this ",
      "email": "myemail@gmail.com"
    }
  }
""";