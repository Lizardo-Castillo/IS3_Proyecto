import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> updateProfileData({
    required String name,
    required String phone,
  }) async {
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser!.uid).set({
        'name': name,
        'phone': phone,
      }, SetOptions(merge: true));
    }
  }

  Future<void> updateEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    if (currentUser != null && currentUser!.email != newEmail) {
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );

      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updateEmail(newEmail);

      // Opcionalmente actualiza también en Firestore
      await _firestore.collection('users').doc(currentUser!.uid).set({
        'email': newEmail,
      }, SetOptions(merge: true));
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (currentUser != null && currentUser!.email != null) {
      final credential = EmailAuthProvider.credential(
        email: currentUser!.email!,
        password: currentPassword,
      );

      await currentUser!.reauthenticateWithCredential(credential);
      await currentUser!.updatePassword(newPassword);
    }
  }
}
