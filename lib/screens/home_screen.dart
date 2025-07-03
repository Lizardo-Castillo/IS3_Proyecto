import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD99898),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Encabezado
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person, color: Colors.brown),
                      SizedBox(width: 8),
                      Text(
                        'Karla Cornejo',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.search, color: Colors.brown),
                ],
              ),
              const SizedBox(height: 16),

              // Opciones de navegación
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  IconLabel(icon: Icons.calendar_month, label: 'FECHA'),
                  IconLabel(icon: Icons.add_circle_outline, label: 'AÑADIR'),
                  IconLabel(icon: Icons.bar_chart, label: 'GRÁFICOS'),
                  IconLabel(icon: Icons.attach_money, label: 'INFORMES'),
                ],
              ),
              const SizedBox(height: 24),

              // Resumen
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SummaryItem(label: 'GASTOS', value: '-45'),
                  SummaryItem(label: 'INGRESOS', value: '0'),
                  SummaryItem(label: 'SALDO', value: '-45'),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                '1 DE   JULIO DEL 2025',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 16),

              // Lista de gastos
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'GASTOS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              const TransactionItem(icon: Icons.shopping_cart, title: 'COMPRAS', amount: -10),
              const TransactionItem(icon: Icons.lightbulb_outline, title: 'LUZ', amount: -35),

              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'INGRESOS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),

              const SizedBox(height: 32),
              const Text(
                'SmartBudget',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.brown),
        Text(label, style: const TextStyle(color: Colors.brown)),
      ],
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const SummaryItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.brown)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 20, color: Colors.brown)),
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int amount;

  const TransactionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.brown),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
      ),
      trailing: Text(
        '$amount',
        style: const TextStyle(color: Colors.brown),
      ),
    );
  }
}
