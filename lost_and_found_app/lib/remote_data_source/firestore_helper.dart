import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post_model.dart';

class FirestoreHelper {
  static Stream<List<PostModel>> read() {
    final postCollection = FirebaseFirestore.instance
        .collection("posts"); // Getting access to the user collection

    return postCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  static Future upload(PostModel post) async {
    final postCollection = FirebaseFirestore.instance
        .collection("posts"); // Getting access to the user collection

    final docRef = postCollection.doc();

    final newPost = PostModel(
      post.itemName,
      post.location,
      post.description,
    ).toJson();

    try {
      await docRef.set(newPost);
    } catch (e) {
      print("Some error occured $e");
    }
  }
}
