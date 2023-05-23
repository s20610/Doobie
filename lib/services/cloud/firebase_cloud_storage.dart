import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doobie/DTO/comment.dart';
import 'package:doobie/DTO/news.dart';
import 'package:doobie/DTO/user_data.dart';
import 'package:doobie/DTO/weed_strain.dart';
import 'package:doobie/services/cloud/cloud_storage_constants.dart';

class FirebaseCloudStorage {
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();

  FirebaseCloudStorage._sharedInstance();

  factory FirebaseCloudStorage() => _shared;

  final weedStrains =
      FirebaseFirestore.instance.collection(weedStrainsCollectionName);
  final comments =
      FirebaseFirestore.instance.collection(commentsCollectionName);
  final userData =
      FirebaseFirestore.instance.collection(userDataCollectionName);
  final news =
  FirebaseFirestore.instance.collection(newsCollectionName);

  Stream<Iterable<WeedStrain>> getAllWeedStrains() => weedStrains
      .snapshots()
      .map((event) => event.docs.map((doc) => WeedStrain.fromSnapshot(doc)));

  //Comments methods
  Future<Comments> getAllCommentsUnderStrain(
      {required String strainName}) async {
    final docReference = comments.doc(strainName);
    final doc = await docReference.get();
    if (doc.exists) {
      final allComments = Comments.fromSnapshot(doc);
      return allComments;
    } else {
      await docReference.set({commentsArrayFieldName: []});
      return Comments(strainName: strainName, allComments: []);
    }
  }

  Future<void> createNewComment(
      {required String strainName,
      required String userEmail,
      required String commentText}) async {
    //Try to get all comments from firestore
    final docReference = comments.doc(strainName);
    final doc = await docReference.get();

    final userComment = Comment(userEmail: userEmail, text: commentText);

    if (doc.exists) {
      //Add user comment to existing array of comments
      final commentsObjectFromFirestore = Comments.fromSnapshot(doc);
      commentsObjectFromFirestore.allComments.add(userComment);
      await docReference.update(
          {commentsArrayFieldName: commentsObjectFromFirestore.allComments});
    } else {
      //Create new comments object in firestore with user comment
      final List<Comment> listOfCommentsWithNewComment = [userComment];
      await comments
          .doc(strainName)
          .set({commentsArrayFieldName: listOfCommentsWithNewComment});
    }
  }

  Future<void> deleteComment(
      {required String strainName, required Comment commentToDelete}) async {
    final docReference = comments.doc(strainName);
    final doc = await docReference.get();

    final commentsObjectFromFirestore = Comments.fromSnapshot(doc);
    commentsObjectFromFirestore.allComments.removeWhere((comment) =>
        comment.userEmail == commentToDelete.userEmail &&
        comment.text == commentToDelete.text);

    await docReference.update(
        {commentsArrayFieldName: commentsObjectFromFirestore.allComments});
  }

  //User data methods
  Future<UserData> getUserData({required String userEmail}) async {
    final docReference = userData.doc(userEmail);
    final doc = await docReference.get();
    if (doc.exists) {
      final userData = UserData.fromSnapshot(doc);
      return userData;
    } else {
      await docReference.set({triedStrainsArrayFieldName: []});
      return UserData(userEmail: userEmail, triedStrains: []);
    }
  }

  Future<bool> isStrainInTriedStrains(
      {required String userEmail, required String strainName}) async {
    final docReference = userData.doc(userEmail);
    final doc = await docReference.get();

    if (doc.exists) {
      final userDataObjectFromFirestore = UserData.fromSnapshot(doc);
      return userDataObjectFromFirestore.triedStrains.contains(strainName);
    } else {
      return false;
    }
  }

  Future<void> addStrainToTriedStrains(
      {required String userEmail, required String strainName}) async {
    final docReference = userData.doc(userEmail);
    final doc = await docReference.get();

    if (doc.exists) {
      final userDataObjectFromFirestore = UserData.fromSnapshot(doc);
      userDataObjectFromFirestore.triedStrains.add(strainName);
      await docReference.update({
        triedStrainsArrayFieldName: userDataObjectFromFirestore.triedStrains
      });
    } else {
      final List<String> listOfTriedStrainsWithNewStrain = [strainName];
      await userData
          .doc(userEmail)
          .set({triedStrainsArrayFieldName: listOfTriedStrainsWithNewStrain});
    }
  }

  Future<void> removeStrainFromTriedStrains(
      {required String userEmail, required String strainName}) async {
    final docReference = userData.doc(userEmail);
    final doc = await docReference.get();

    final userDataObjectFromFirestore = UserData.fromSnapshot(doc);
    userDataObjectFromFirestore.triedStrains
        .removeWhere((triedStrain) => triedStrain == strainName);

    await docReference.update(
        {triedStrainsArrayFieldName: userDataObjectFromFirestore.triedStrains});
  }

  Stream<Iterable<News>> getAllNews() => news
      .snapshots()
      .map((event) => event.docs.map((doc) => News.fromSnapshot(doc)));
}
