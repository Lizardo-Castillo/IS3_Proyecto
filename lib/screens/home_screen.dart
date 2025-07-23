import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/transaction_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('SmartBudget', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nombre y fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Nombre con botón de perfil
                Row(
                  children: [
                    const Text(
                      'Karla Cornejo', 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.brown
                      )
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/profile'),
                      icon: const Icon(Icons.person, color: Colors.brown),
                      iconSize: 24,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: IconButton.styleFrom(
                        minimumSize: const Size(32, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text('1 de Julio del 2025'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Resumen
            StreamBuilder<QuerySnapshot>(
              stream: TransactionService.getTransactionsStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return FutureBuilder<Map<String, double>>(
                  future: TransactionService.calcularResumen(snapshot.data!),
                  builder: (context, resumenSnapshot) {
                    if (!resumenSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final gastos = resumenSnapshot.data!['gastos']!;
                    final ingresos = resumenSnapshot.data!['ingresos']!;
                    final saldo = resumenSnapshot.data!['saldo']!;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _ResumenItem(label: 'Gastos', amount: '-S/ ${gastos.toStringAsFixed(2)}', color: Colors.red),
                        _ResumenItem(label: 'Ingresos', amount: '+S/ ${ingresos.toStringAsFixed(2)}', color: Colors.green),
                        _ResumenItem(label: 'Saldo', amount: 'S/ ${saldo.toStringAsFixed(2)}', color: Colors.black),
                      ],
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(icon: Icons.add_circle_outline, label: 'AÑADIR', onTap: () => Navigator.pushNamed(context, '/add')),
                _ActionButton(icon: Icons.bar_chart, label: 'GRÁFICOS', onTap: () => Navigator.pushNamed(context, '/charts')),
                _ActionButton(icon: Icons.receipt_long, label: 'INFORMES', onTap: () => Navigator.pushNamed(context, '/reports')),
              ],
            ),

            const SizedBox(height: 24),

            // Lista de transacciones
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: TransactionService.getTransactionsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No hay transacciones.'));
                  }

                  final transactions = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final doc = transactions[index];
                      final nombre = doc['categoria'];
                      final monto = (doc['monto'] as num).toDouble();
                      final tipo = doc['tipo'];

                      return _TransactionItem(
                        nombre: nombre,
                        monto: tipo == 'Gasto' ? -monto : monto,
                        onEdit: () {
                          Navigator.pushNamed(context, '/edit', arguments: {
                            'id': doc.id,
                            'tipo': tipo,
                            'categoria': nombre,
                            'monto': monto,
                            'fecha': (doc['fecha'] as Timestamp).toDate(),
                          });
                        },
                        onDelete: () async {
                          final service = TransactionService();
                          await service.deleteTransaction(doc.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown[200],
        backgroundColor: const Color(0xFFD99898),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

// Widgets reutilizables
class _ResumenItem extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const _ResumenItem({required this.label, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(color: Colors.brown, shape: CircleBorder()),
          child: IconButton(icon: Icon(icon), color: Colors.white, onPressed: onTap),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String nombre;
  final double monto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TransactionItem({
    required this.nombre,
    required this.monto,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isGasto = monto < 0;

    return ListTile(
      leading: const Icon(Icons.monetization_on, color: Colors.brown),
      title: Text(nombre),
      subtitle: Text(isGasto ? 'Gasto' : 'Ingreso'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${isGasto ? '-' : '+'}S/ ${monto.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isGasto ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Editar')),
              const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}