import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/database_helper.dart';
import '../firebase/post_collection.dart';
import '../models/post_model.dart';
import '../provider/flags_provider.dart';

class ModalAddPost extends StatefulWidget {
  const ModalAddPost({super.key, this.postModel});

  final PostModel? postModel;

  @override
  State<ModalAddPost> createState() => _ModalAddPostState();
}

class _ModalAddPostState extends State<ModalAddPost> {
  PostCollection? postCollection;
  DatabaseHelper? database;
  TextEditingController txtDescPost = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = DatabaseHelper();
    postCollection = PostCollection();
    txtDescPost.text =
        widget.postModel != null ? widget.postModel!.dscPost! : "";
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
        title: widget.postModel == null
            ? const Text('Adding Post')
            : const Text('Editing Post'),
        content: SizedBox(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: txtDescPost,
                maxLines: 5,
              ),
              IconButton(
                onPressed: () {
                  if (widget.postModel == null) {
                    postCollection!
                        .insertPost(
                      PostModel(
                        dscPost: txtDescPost.text,
                        datePost: DateTime.now().toString(),
                      ),
                    )
                        .then((value) {
                      var msg = 'Publicacion insertado!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });

                    /*database!.INSERTAR("tblPost", {
                      'dscPost': txtDescPost.text,
                      'datePost': DateTime.now().toString(),
                    }).then((value) {
                      var msg = value > 0
                          ? 'Publicacion insertado!'
                          : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });*/
                  } else {
                    postCollection!
                        .updatePost(
                      PostModel(
                        dscPost: txtDescPost.text,
                        datePost: DateTime.now().toString(),
                      ),
                      widget.postModel!.idPost.toString(),
                    )
                        .then((value) {
                      var msg = 'Publicacion insertado!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });
                    /*database!
                        .ACTUALIZAR(
                            "tblPost",
                            {
                              'idPost': widget.postModel!.idPost,
                              'dscPost': txtDescPost.text,
                              'datePost': DateTime.now().toString(),
                            },
                            'idPost')
                        .then((value) {
                      var msg = value > 0
                          ? 'Publicacion editada!'
                          : 'Ocurrio un error!';
                      final snackBar = SnackBar(content: Text(msg));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      flags.setUpdate();
                    });*/
                  }
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}
