import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final CollectionReference transactions = FirebaseFirestore.instance.collection('transactions');

  // A. Añadir una transacción
  Future<void> addTransaction({
    required String usuario,
    required String tipo,
    required String categoria,
    required double monto,
    required DateTime fecha,
  }) async {
    await transactions.add({
      'usuario': usuario,
      'tipo': tipo,
      'categoria': categoria,
      'monto': monto,
      'fecha': fecha,
    });
  }

  // B. Obtener las transacciones (stream)
  static Stream<QuerySnapshot> getTransactionsStream() {
    return FirebaseFirestore.instance
        .collection('transactions')
        .orderBy('fecha', descending: true)
        .snapshots();
  }

  // C. Calcular resumen de gastos, ingresos y saldo
  static Future<Map<String, double>> calcularResumen(QuerySnapshot snapshot) async {
    double gastos = 0;
    double ingresos = 0;

    for (var doc in snapshot.docs) {
      double monto = (doc['monto'] as num).toDouble();
      String tipo = doc['tipo'];

      if (tipo == 'Gasto') {
        gastos += monto;
      } else {
        ingresos += monto;
      }
    }

    double saldo = ingresos - gastos;
    return {'gastos': gastos, 'ingresos': ingresos, 'saldo': saldo};
  }

  Future<void> updateTransaction({
    required String id,
    required String tipo,
    required String categoria,
    required double monto,
    required DateTime fecha,
  }) async {
    await transactions.doc(id).update({
      'tipo': tipo,
      'categoria': categoria,
      'monto': monto,
      'fecha': fecha,
    });
  }

  Future<void> deleteTransaction(String id) async {
    await transactions.doc(id).delete();
  }
}
