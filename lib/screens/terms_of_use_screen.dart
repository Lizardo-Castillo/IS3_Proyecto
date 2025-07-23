import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD99898),
        iconTheme: const IconThemeData(color: Colors.brown),
        title: const Text(
          'TÉRMINOS DE USO',
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Última actualización: [fecha]',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Bienvenido/a a Smart Budget. Al utilizar nuestra aplicación móvil, aceptas cumplir con los siguientes Términos de Uso. Te recomendamos leerlos cuidadosamente antes de continuar usando la aplicación.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              SizedBox(height: 24),

              Text(
                '1. Uso de la Aplicación',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 6),
              Text(
                'Smart Budget es una herramienta diseñada para ayudarte a gestionar tus finanzas personales. '
                'El uso de esta aplicación debe hacerse con fines lícitos y personales. '
                'Está prohibido usar la app para actividades fraudulentas o ilegales.',
              ),
              SizedBox(height: 16),

              Text(
                '2. Registro y Seguridad',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 6),
              Text(
                'Para acceder a ciertas funciones, es posible que debas crear una cuenta. '
                'Es tu responsabilidad mantener la confidencialidad de tu información de acceso. '
                'No compartas tus credenciales con terceros.',
              ),
              SizedBox(height: 16),

              Text(
                '3. Contenido del Usuario',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 6),
              Text(
                'Puedes registrar tus ingresos, gastos y otra información financiera. '
                'Tú conservas la propiedad de tus datos, pero nos otorgas permiso para procesarlos '
                'y analizarlos para mejorar tu experiencia.',
              ),
              SizedBox(height: 16),

              Text(
                '4. Responsabilidad',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 6),
              Text(
                'Smart Budget no ofrece asesoramiento financiero profesional. '
                'Las decisiones tomadas a partir de la app son responsabilidad del usuario. '
                'No garantizamos resultados financieros ni la precisión absoluta de todos los cálculos.',
              ),
              SizedBox(height: 16),

              Text(
                '5. Modificaciones',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 6),
              Text(
                'Nos reservamos el derecho de actualizar estos términos en cualquier momento. '
                'Te notificaremos cambios importantes por medio de la app o el correo electrónico registrado.',
              ),
              SizedBox(height: 24),

              Center(
                child: Text(
                  'SmartBudget',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
