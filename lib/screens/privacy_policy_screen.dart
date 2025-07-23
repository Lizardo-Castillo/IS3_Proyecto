import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD99898),
        title: const Text(
          'POLÍTICA DE PRIVACIDAD',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFD99898),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Última actualización: [Fecha]',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'En SmartBudget, tu privacidad es una prioridad. Esta política explica cómo '
                'recopilamos, usamos y protegemos tu información.',
                style: TextStyle(color: Colors.brown),
              ),
              SizedBox(height: 20),
              _SectionTitle('1. Información que Recopilamos'),
              _SectionBody(
                'Información personal: nombre, correo electrónico, datos de acceso.\n'
                'Datos financieros ingresados por el usuario: ingresos, gastos, metas, etc.\n'
                'Datos técnicos: dispositivo, sistema operativo, identificadores únicos.',
              ),
              SizedBox(height: 12),
              _SectionTitle('2. Cómo Usamos tu Información'),
              _SectionBody(
                'Para brindarte mejores servicios de control financiero.\n'
                'Para personalizar tu experiencia con gráficos, alertas y recomendaciones.\n'
                'Para mejorar la funcionalidad y seguridad de la app.',
              ),
              SizedBox(height: 12),
              _SectionTitle('3. Almacenamiento y Seguridad'),
              _SectionBody(
                'Tus datos son almacenados de forma segura. Usamos cifrado y buenas prácticas '
                'para proteger tu información. No compartimos tus datos personales con terceros sin tu consentimiento.',
              ),
              SizedBox(height: 12),
              _SectionTitle('4. Terceros y Servicios Externos'),
              _SectionBody(
                'Podemos integrar servicios externos (como pasarelas de pago o análisis de uso). '
                'Estos servicios tienen sus propias políticas de privacidad.',
              ),
              SizedBox(height: 12),
              _SectionTitle('5. Tus Derechos'),
              _SectionBody(
                'Puedes acceder, corregir o eliminar tu información en cualquier momento desde la app '
                'o contactándonos a [tu correo de soporte].',
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'SmartBudget',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
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

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.brown,
        fontSize: 16,
      ),
    );
  }
}

class _SectionBody extends StatelessWidget {
  final String text;
  const _SectionBody(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.brown,
        height: 1.4,
      ),
    );
  }
}
