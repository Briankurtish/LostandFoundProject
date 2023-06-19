import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';

class FirestoreHelper {
  static Stream<List<PostModel>> read() {
    final postCollection = FirebaseFirestore.instance.collection("posts");

    return postCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  static Future upload(PostModel post) async {
    final postCollection = FirebaseFirestore.instance.collection("posts");

    final docRef = postCollection.doc();

    final newPost = {
      'itemName': post.itemName,
      'description': post.description,
      'location': post.location,
      'username': post.username,
      // Add the username to the post
    };

    try {
      await docRef.set(newPost);
    } catch (e) {
      print("Some error occurred: $e");
    }
  }
}
