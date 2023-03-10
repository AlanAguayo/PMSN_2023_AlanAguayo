class PostModel {
  int? idPost;
  String? dscPost;
  String? datePost;

  PostModel({this.idPost, this.dscPost, this.datePost});

/*
//El equivalente al de arriba
  PostModel(int idPost) {
    this.idPost = idPost;
  }
*/

  //Constructor nombrado
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      idPost: map['idPost'],
      dscPost: map['dscPost'],
      datePost: map['datePost'],
    );
  }

/*
//Retorna un map
  factory PostModel.toMap(Map<String, dynamic> map) {
    return {
      'idPost': this.idPost,
      'dscPost': this.dscPost,
      'datePost': this.datePost,
    };
  }
  */
}
