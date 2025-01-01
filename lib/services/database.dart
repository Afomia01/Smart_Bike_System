import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/bike.dart';
import 'package:myapp/models/lock.dart'; // Import the Lock model

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  
  // Reference to user collection in Firestore
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  
  // Reference to bike collection in Firestore
  final CollectionReference bikeCollection = FirebaseFirestore.instance.collection('bikes');

  // Reference to bike lock status in Realtime Database
  final DatabaseReference bikeLockDatabase = FirebaseDatabase.instance.ref().child('bike_locks');

  // Update user data in Firestore
  Future<void> updateUserData(String name, String phone, String email, String password) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });
  }

  // Delete user data in Firestore
  Future<void> deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  // Update user name in Firestore
  Future<void> updateUserName(String name) async {
    return await userCollection.doc(uid).update({'name': name});
  }

  // Update user phone in Firestore
  Future<void> updateUserPhone(String phone) async {
    return await userCollection.doc(uid).update({'phone': phone});
  }

  // Update user email in Firestore
  Future<void> updateUserEmail(String email) async {
    return await userCollection.doc(uid).update({'email': email});
  }

  // Update user password in Firestore
  Future<void> updateUserpassword(String password) async {
    return await userCollection.doc(uid).update({'password': password});
  }

  // Get user data stream from Firestore
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

  // Add bike data in Firestore
  Future<void> addBikeData(Bike bike) async {
    return await bikeCollection.doc(bike.id).set(bike.toJson());
  }

  // Get bike data stream from Firestore
  Stream<Bike?> getBikeData(String bikeId) {
    return bikeCollection.doc(bikeId).snapshots().map((snapshot) {
      if (snapshot.exists) {
        return Bike.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }

  // Update bike lock status in Realtime Database
  Future<void> updateBikeLock(String bikeId, Lock lock) async {
    return await bikeLockDatabase.child(bikeId).update(lock.toJson());
  }

  // Get bike lock status stream from Realtime Database
  Stream<Lock?> getBikeLockStatus(String bikeId) {
    return bikeLockDatabase.child(bikeId).onValue.map((event) {
      return event.snapshot.value != null ? Lock.fromJson(Map<String, dynamic>.from(event.snapshot.value as Map)) : null;
    });
  }
}
