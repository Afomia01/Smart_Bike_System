import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/bike.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  
  // Reference to user collection
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  
  // Reference to bike collection
  final CollectionReference bikeCollection = FirebaseFirestore.instance.collection('bikes');

  // Update user data
  Future<void> updateUserData(String name, String phone, String email, String password) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });
  }

  // Delete user data
  Future<void> deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  // Update user name
  Future<void> updateUserName(String name) async {
    return await userCollection.doc(uid).update({'name': name});
  }

  // Update user phone
  Future<void> updateUserPhone(String phone) async {
    return await userCollection.doc(uid).update({'phone': phone});
  }

  // Update user email
  Future<void> updateUserEmail(String email) async {
    return await userCollection.doc(uid).update({'email': email});
  }

  // Update user password
  Future<void> updateUserpassword(String password) async {
    return await userCollection.doc(uid).update({'password': password});
  }

  // Get user data stream
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

  // Add bike data
  Future<void> addBikeData(Bike bike) async {
    return await bikeCollection.doc(bike.id).set(bike.toJson());
  }

  // Get bike data stream
  Stream<Bike?> getBikeData(String bikeId) {
    return bikeCollection.doc(bikeId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return Bike.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  // Update bike lock status
  Future<void> updateBikeLock(String bikeId, String status, String command) async {
    return await bikeCollection.doc(bikeId).update({
      'lock.status': status,
      'lock.command': command,
      'lock.lastUpdated': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
