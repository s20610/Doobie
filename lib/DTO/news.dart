import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String title;
  final String summary;
  final String url;
  final String imgThumb;

  News({
    required this.title,
    required this.summary,
    required this.url,
    required this.imgThumb,
  });

  News.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : title = snapshot.data()['title'],
        summary = snapshot.data()['summary'],
        url = snapshot.data()['url'],
        imgThumb = snapshot.data()['imgThumb'];
}
