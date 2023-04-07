import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practicauno/models/post_model.dart';
import 'package:practicauno/widgets/item_post_widget.dart';

import '../firebase/post_collection.dart';

class ListPostCloudScreen extends StatefulWidget {
  const ListPostCloudScreen({super.key});

  @override
  State<ListPostCloudScreen> createState() => _ListPostCloudScreenState();
}

class _ListPostCloudScreenState extends State<ListPostCloudScreen> {
  PostCollection? postCollection;

  @override
  void initState() {
    super.initState();
    postCollection = PostCollection();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postCollection!.getAllPost(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final dscPost = snapshot.data!.docs[index].get('dscPost');
                final datePost = snapshot.data!.docs[index].get('datePost');
                return ItemPostWidget(
                  postModel: PostModel(
                      dscPost: dscPost, datePost: datePost.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Algo salio mal! :()'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
