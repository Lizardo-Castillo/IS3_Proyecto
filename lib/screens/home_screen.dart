import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'SmartBudget',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Nombre del usuario y fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Karla Cornejo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // lógica de seleccionar fecha
                  },
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text('1 de Julio del 2025'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Resumen: Gastos, Ingresos, Saldo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _ResumenItem(label: 'Gastos', amount: '-S/ 45', color: Colors.red),
                _ResumenItem(label: 'Ingresos', amount: '+S/ 100', color: Colors.green),
                _ResumenItem(label: 'Saldo', amount: 'S/ 55', color: Colors.black),
              ],
            ),
            const SizedBox(height: 20),

            // Botones: Añadir, Gráficos, Informes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: Icons.add_circle_outline,
                  label: 'AÑADIR',
                  onTap: () => Navigator.pushNamed(context, '/add'),
                ),
                _ActionButton(
                  icon: Icons.bar_chart,
                  label: 'GRÁFICOS',
                  onTap: () => Navigator.pushNamed(context, '/charts'),
                ),
                _ActionButton(
                  icon: Icons.receipt_long,
                  label: 'INFORMES',
                  onTap: () => Navigator.pushNamed(context, '/reports'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Lista de transacciones
            Expanded(
              child: ListView(
                children: const [
                  _TransactionItem(nombre: 'Compras', monto: -10),
                  _TransactionItem(nombre: 'Luz', monto: -35),
                  // Puedes seguir agregando más
                ],
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

// Widget para resumen de gastos/ingresos/saldo
class _ResumenItem extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;

  const _ResumenItem({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

// Widget para botones centrales: AÑADIR, GRÁFICOS, INFORMES
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: ShapeDecoration(
            color: Colors.brown,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Widget para una transacción
class _TransactionItem extends StatelessWidget {
  final String nombre;
  final int monto;

  const _TransactionItem({
    required this.nombre,
    required this.monto,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.monetization_on, color: Colors.brown),
      title: Text(nombre),
      trailing: Text(
        (monto < 0 ? '-S/' : '+S/') + monto.abs().toString(),
        style: TextStyle(
          color: monto < 0 ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
