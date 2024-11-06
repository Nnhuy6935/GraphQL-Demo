class GraphqlQuery {

 

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
