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

  static Future<Map<DateTime, Map<String, double>>> getGroupedDataByDate() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('transactions')
        .orderBy('fecha')
        .get();

    final grouped = <DateTime, Map<String, double>>{};

    for (var doc in querySnapshot.docs) {
      final fecha = (doc['fecha'] as Timestamp).toDate();
      final tipo = doc['tipo'];
      final monto = (doc['monto'] as num).toDouble();

      final fechaKey = DateTime(fecha.year, fecha.month, fecha.day); // Agrupar solo por día

      grouped[fechaKey] ??= {'ingresos': 0.0, 'gastos': 0.0};
      if (tipo == 'Ingreso') {
        grouped[fechaKey]!['ingresos'] = grouped[fechaKey]!['ingresos']! + monto;
      } else {
        grouped[fechaKey]!['gastos'] = grouped[fechaKey]!['gastos']! + monto;
      }
    }

    return grouped;
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