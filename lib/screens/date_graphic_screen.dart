import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectorFecha extends StatefulWidget {
  final void Function(DateTime) onFechaSeleccionada;

  const SelectorFecha({Key? key, required this.onFechaSeleccionada}) : super(key: key);

  @override
  _SelectorFechaState createState() => _SelectorFechaState();
}

class _SelectorFechaState extends State<SelectorFecha> {
  DateTime? _fechaSeleccionada;

  void _mostrarSelectorFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale("es", "ES"), // Idioma español
    );

    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
      });
      widget.onFechaSeleccionada(fecha);
    }
  }

  @override
  Widget build(BuildContext context) {
    String textoFecha = _fechaSeleccionada != null
        ? DateFormat('dd/MM/yyyy').format(_fechaSeleccionada!)
        : 'Seleccionar Fecha';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Fecha seleccionada: $textoFecha"),
        ElevatedButton.icon(
          onPressed: _mostrarSelectorFecha,
          icon: Icon(Icons.calendar_today),
          label: Text("Escoger Fecha"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[300],
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
