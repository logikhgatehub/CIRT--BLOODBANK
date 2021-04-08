import 'package:blood_donor/Application/models/appointments.dart';
import 'package:blood_donor/Application/models/articles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);

  final FirebaseFirestore _firestore;

  Stream<List<Articles>> getArticles() {
    return FirebaseFirestore.instance
        .collection('articles')
        .orderBy('timestamp')
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((document) => Articles(document['title'], document['content'],
              document['timestamp'], document['author']))
          .toList();
    });
  }
}
