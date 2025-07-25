import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserConfigService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> guardarIngresoInicial(double ingreso) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('usuarios').doc(uid).set(
        {'ingresoInicial': ingreso},
        SetOptions(merge: true),
      );
    }
  }

  static Future<void> guardarLimite(double limite) async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('usuarios').doc(uid).set(
        {'limite': limite},
        SetOptions(merge: true),
      );
    }
  }

  static Future<Map<String, dynamic>> obtenerConfiguracion() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await _firestore.collection('usuarios').doc(uid).get();
      return doc.exists ? doc.data()! : {};
    }
    return {};
  }
}
