import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doobie/services/cloud/cloud_storage_constants.dart';

class UserData {
  final String userEmail;
  final List<String> triedStrains;

  UserData({required this.userEmail, required this.triedStrains});

  factory UserData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return UserData(
        userEmail: snapshot.id,
        triedStrains: data![triedStrainsArrayFieldName] is Iterable
            ? List.from(data![triedStrainsArrayFieldName])
            : List.empty(growable: true));
  }
}
