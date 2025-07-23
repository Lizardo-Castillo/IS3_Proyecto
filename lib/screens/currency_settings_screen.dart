import 'package:flutter/material.dart';

class CurrencySettingsScreen extends StatefulWidget {
  const CurrencySettingsScreen({super.key});

  @override
  State<CurrencySettingsScreen> createState() => _CurrencySettingsScreenState();
}

class _CurrencySettingsScreenState extends State<CurrencySettingsScreen> {
  String _selectedCurrency = 'PEN'; // Moneda por defecto (Sol)

  void _selectCurrency(String currencyCode) {
    setState(() {
      _selectedCurrency = currencyCode;
    });

    // Aquí podrías guardar la preferencia en almacenamiento local si deseas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Moneda seleccionada: $currencyCode')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD99898),
        title: const Text(
          'Seleccionar Moneda',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCurrencyOption('PEN', 'Sol Peruano', 'S/.', Icons.currency_exchange),
          _buildCurrencyOption('USD', 'Dólar Estadounidense', '\$', Icons.attach_money),
          _buildCurrencyOption('EUR', 'Euro', '€', Icons.euro),
        ],
      ),
    );
  }

  Widget _buildCurrencyOption(String code, String name, String symbol, IconData icon) {
    final isSelected = _selectedCurrency == code;

    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Colors.brown.withOpacity(0.15) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.brown, size: 28),
        title: Text(
          name,
          style: const TextStyle(fontSize: 16, color: Colors.brown),
        ),
        subtitle: Text(
          '$symbol ($code)',
          style: const TextStyle(fontSize: 14, color: Colors.brown),
        ),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.brown)
            : null,
        onTap: () => _selectCurrency(code),
      ),
    );
  }
}
