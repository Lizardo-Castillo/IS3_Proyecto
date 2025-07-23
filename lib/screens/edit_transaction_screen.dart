import 'package:flutter/material.dart';
import 'package:proyecto_final/services/transaction_service.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({super.key});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String tipo;
  late String categoria;
  late double monto;
  late DateTime fecha;
  late String id;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    id = args['id'];
    tipo = args['tipo'];
    categoria = args['categoria'];
    monto = args['monto'];
    fecha = args['fecha'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Editar Transacción', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: tipo,
                decoration: _inputDecoration('Tipo'),
                items: ['Ingreso', 'Gasto']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (value) => setState(() => tipo = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: categoria,
                decoration: _inputDecoration('Categoría'),
                onChanged: (val) => categoria = val,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: monto.toString(),
                decoration: _inputDecoration('Monto'),
                keyboardType: TextInputType.number,
                onChanged: (val) => monto = double.tryParse(val) ?? 0,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await TransactionService().updateTransaction(
                      id: id,
                      tipo: tipo,
                      categoria: categoria,
                      monto: monto,
                      fecha: fecha,
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
