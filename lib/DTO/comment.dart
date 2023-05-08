import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doobie/services/cloud/cloud_storage_constants.dart';

class Comments {
  final String strainName;
  final List<Comment> allComments;

  Comments({required this.strainName, required this.allComments});

  factory Comments.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final comments = Comments(
        strainName: snapshot.id,
        allComments:
            List<Comment>.from(data![commentsArrayFieldName].map((comment) {
          return Comment(
              userEmail: comment[commentUserEmailFieldName],
              text: comment[commentTextFieldName]);
        })));
    return comments;
  }
}

class Comment {
  final String userEmail;
  final String text;

  Comment({required this.userEmail, required this.text});
}
