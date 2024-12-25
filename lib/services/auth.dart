import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/user.dart' as myapp_user;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create user obj based on FirebaseUser
  myapp_user.UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? myapp_user.UserModel(uid: user.uid, name: '', phone: '', email: user.email!, password: '') : null;
  }

  // Auth change user stream
  Stream<myapp_user.UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Register with email and password
  Future<myapp_user.UserModel?> registerWithEmailAndPassword(String name, String phone, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      // Create a new UserModel object
      myapp_user.UserModel newUser = myapp_user.UserModel(
        uid: user!.uid,
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<myapp_user.UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
