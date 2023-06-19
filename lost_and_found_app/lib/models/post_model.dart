import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? itemName;
  final String? location;
  final String? description;

  PostModel(this.itemName, this.location, this.description);

  factory PostModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
      snapshot['itemName'],
      snapshot['location'],
      snapshot['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'itemName': itemName,
        'location': location,
        'description': description,
      };
}
