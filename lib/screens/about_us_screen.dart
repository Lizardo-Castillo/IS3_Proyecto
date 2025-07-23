import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD99898),
        iconTheme: const IconThemeData(color: Colors.brown),
        title: const Text(
          'SOBRE NOSOTROS',
          style: TextStyle(
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Smart Budget: Tu aliado en el control de tus finanzas.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Somos un equipo apasionado por aprobar Ingeniería de Software 3. '
                'Creamos Smart Budget con el objetivo de ayudarte a tomar el control de tu dinero '
                'de forma fácil, clara, accesible, y no gastar como nuestro gran amigo Lizardo.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                'Creemos que una buena gestión financiera no debería requerir conocimientos técnicos. '
                'Nuestra app está diseñada para ofrecerte herramientas simples pero potentes para que puedas:',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _BulletPoint('Registrar tus ingresos y gastos diarios'),
              _BulletPoint('Establecer metas de ahorro'),
              _BulletPoint('Analizar tus hábitos financieros'),
              _BulletPoint('Planificar tu presupuesto mensual'),
              SizedBox(height: 20),
              Text(
                'Nuestro compromiso es brindarte una experiencia segura, útil y sin complicaciones. '
                'Porque cuando entiendes tus finanzas, tomas mejores decisiones para tu futuro.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 24),
              Text(
                'Contáctanos:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 8),
              Text('📧 kcornejop@unsa.edu.pe'),
              Text('📱 Síguenos en redes sociales: @SmartBudgetApp'),
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

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.brown),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
