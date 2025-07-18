import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime selectedDate = DateTime.now();
  String transactionType = 'Gasto';
  String? selectedCategory;

  final List<String> categoriasGasto = [
    "Compras", "Alimentos", "Celular", "Internet",
    "Agua", "Luz", "Ropa", "Auto",
    "Hijos", "Educación", "Diversión", "Viajes",
    "Salud", "Mascotas", "Regalos"
  ];

  final List<String> categoriasIngreso = [
    "Salario", "Inversiones", "Trabajo Parcial"
  ];

  void _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'Selecciona una fecha',
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categorias =
        transactionType == 'Gasto' ? categoriasGasto : categoriasIngreso;

    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Añadir Movimiento',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Karla Cornejo",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 16),

            // Selector de tipo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Gasto"),
                  selected: transactionType == "Gasto",
                  selectedColor: Colors.red[300],
                  onSelected: (selected) {
                    setState(() => transactionType = "Gasto");
                  },
                ),
                const SizedBox(width: 12),
                ChoiceChip(
                  label: const Text("Ingreso"),
                  selected: transactionType == "Ingreso",
                  selectedColor: Colors.green[300],
                  onSelected: (selected) {
                    setState(() => transactionType = "Ingreso");
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Selector de fecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Fecha:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_month),
                  label: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
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
            const SizedBox(height: 16),

            // Categorías
            const Text(
              "Selecciona una categoría:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categorias.map((cat) {
                final selected = selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: selected,
                  selectedColor: transactionType == "Gasto" ? Colors.red[200] : Colors.green[200],
                  onSelected: (_) {
                    setState(() => selectedCategory = cat);
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            // Botón AÑADIR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // lógica para guardar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'AÑADIR',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
