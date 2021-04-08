import 'package:cloud_firestore/cloud_firestore.dart';

class Articles {
  final String title,content;
  final Timestamp timestamp;
  final String author;

  Articles(this.title, this.content, this.timestamp, this.author);
}