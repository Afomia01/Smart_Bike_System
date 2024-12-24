import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String name, String phone, String email, String password) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });
  }


  Future<void> deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  Future<void> updateUserName(String name) async {
    return await userCollection.doc(uid).update({'name': name,});
  }

  Future<void> updateUserPhone(String phone) async {
    return await userCollection.doc(uid).update({'phone': phone});
  }

  Future<void> updateUserEmail(String email) async {
    return await userCollection.doc(uid).update({'email': email});
  }

  Future<void> updateUserpassword(String password) async {
    return await userCollection.doc(uid).update({'password': password});
  }

  Stream<UserModel?> get userData {
    return userCollection.doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return UserModel(
          uid: uid!,
          name: snapshot.get('name'),
          phone: snapshot.get('phone'),
          email: snapshot.get('email'),
          password: snapshot.get('password'),
        );
      } else {
        return null;
      }
    });
  }
}
