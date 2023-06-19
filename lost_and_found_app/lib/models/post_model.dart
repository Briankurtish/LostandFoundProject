import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  // Username of the post creator
  final String? itemName;
  final String? description;
  final String? location;
  final String? username;

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      snapshot['itemName'],
      snapshot['description'],
      snapshot['location'],
      snapshot['username'],
    );
  }

  PostModel(this.itemName, this.description, this.location, this.username);

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'description': description,
        'location': location,
        'username': username,
      };
}
