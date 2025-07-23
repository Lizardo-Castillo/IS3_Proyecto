import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'es'; // Idioma por defecto: español


  void _selectLanguage(String langCode) {
    setState(() {
      _selectedLanguage = langCode;
    });

    // Aquí podrías guardar la preferencia en almacenamiento local si lo deseas
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Idioma seleccionado: ${_languageName(langCode)}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD99898),
        title: const Text(
          'Seleccionar Idioma',
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildLanguageOption('es', 'Español', Icons.language),
          _buildLanguageOption('en', 'Inglés', Icons.g_translate),
          _buildLanguageOption('fr', 'Francés', Icons.translate),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name, IconData icon) {
    final isSelected = _selectedLanguage == code;

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
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.brown)
            : null,
        onTap: () => _selectLanguage(code),
      ),
    );
  }

  String _languageName(String code) {
    switch (code) {
      case 'es':
        return 'Español';
      case 'en':
        return 'Inglés';
      case 'fr':
        return 'Francés';
      default:
        return 'Desconocido';
    }
  }
}
