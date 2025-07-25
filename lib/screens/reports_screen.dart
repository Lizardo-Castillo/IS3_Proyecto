import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/transaction_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  double _limite = 1000.0; // Límite por defecto
  double _ingresoInicial = 0.0; // Ingreso inicial por defecto
  bool _limitExceeded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        
        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          print('Datos cargados desde Firebase: $data'); // Debug
          setState(() {
            _limite = (data['limite'] as num?)?.toDouble() ?? 1000.0;
            _ingresoInicial = (data['IngresoInicial'] as num?)?.toDouble() ?? 0.0;
            _isLoading = false;
          });
          print('Límite: $_limite, Ingreso inicial: $_ingresoInicial'); // Debug
        } else {
          print('Documento no existe, usando valores por defecto'); // Debug
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error al cargar datos: $e'); // Debug
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Usuario no autenticado'); // Debug
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        print('Guardando datos: Límite=$_limite, Ingreso inicial=$_ingresoInicial'); // Debug
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({
          'limite': _limite,
          'IngresoInicial': _ingresoInicial,
        }, SetOptions(merge: true));
        
        print('Datos guardados exitosamente'); // Debug
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos guardados correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Error al guardar: $e'); // Debug
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar los datos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print('Usuario no autenticado para guardar'); // Debug
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Usuario no autenticado'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      body: SafeArea(
        child: Column(
          children: [
            // Header con nombre de usuario y botón home
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.brown, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        user != null ? user.email!.split('@').first : 'Usuario',
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.brown
                        )
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.search, color: Colors.brown, size: 28),
                  ),
                ],
              ),
            ),

            // Botones de navegación
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavButton(icon: Icons.calendar_today, label: 'FECHA', onTap: () {}),
                  _NavButton(icon: Icons.add_circle_outline, label: 'AÑADIR', onTap: () => Navigator.pushNamed(context, '/add')),
                  _NavButton(icon: Icons.bar_chart, label: 'GRÁFICOS', onTap: () {}),
                  _NavButton(icon: Icons.receipt_long, label: 'INFORMES', isActive: true, onTap: () {}),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Contenido principal
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : StreamBuilder<QuerySnapshot>(
                stream: TransactionService.getTransactionsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: Text('No hay datos disponibles'));
                  }

                  return FutureBuilder<Map<String, double>>(
                    future: TransactionService.calcularResumen(snapshot.data!),
                    builder: (context, resumenSnapshot) {
                      if (!resumenSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final gastos = resumenSnapshot.data!['gastos']!;
                      final ingresos = resumenSnapshot.data!['ingresos']!;

                      // Verificar si se excede el límite
                      _limitExceeded = gastos > _limite;

                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            // Sección de ingresos
                            Row(
                              children: [
                                Expanded(
                                  child: _EditableInfoCard(
                                    title: 'INGRESO INICIAL',
                                    value: 'S/ ${_ingresoInicial.toStringAsFixed(2)}',
                                    onTap: () => _showIngresoInicialDialog(),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _InfoCard(
                                    title: 'INGRESO TOTAL',
                                    value: 'S/ ${(_ingresoInicial + ingresos).toStringAsFixed(2)}',
                                    isEmpty: false,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Sección de límite
                            _LimitCard(
                              limite: _limite,
                              isExceeded: _limitExceeded,
                              onLimitChanged: (newLimit) {
                                setState(() {
                                  _limite = newLimit;
                                });
                              },
                            ),

                            const SizedBox(height: 16),

                            // Ganancia o pérdida neta
                            _InfoCard(
                              title: 'GANANCIA O PÉRDIDA NETA',
                              value: 'S/ ${((_ingresoInicial + ingresos) - gastos).toStringAsFixed(2)}',
                              subtitle: 'INGRESOS TOTALES - GASTOS TOTALES',
                              isEmpty: false,
                            ),

                            const SizedBox(height: 16),

                            // Botón de guardar
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ElevatedButton.icon(
                                onPressed: _saveUserData,
                                icon: const Icon(Icons.save, color: Colors.white),
                                label: const Text(
                                  'GUARDAR CAMBIOS',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Imagen del cerdito
                            _PiggyImage(
                              isLimitExceeded: _limitExceeded,
                              gastos: gastos,
                              limite: _limite,
                            ),

                            const SizedBox(height: 20),

                            // Footer con nombre de la app
                            Text(
                              'SmartBudget',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.brown[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showIngresoInicialDialog() {
    print('Abriendo diálogo de ingreso inicial'); // Debug
    final TextEditingController controller = TextEditingController();
    controller.text = _ingresoInicial.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Establecer Ingreso Inicial'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Ingreso inicial',
              prefixText: 'S/ ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newIngreso = double.tryParse(controller.text) ?? _ingresoInicial;
                print('Nuevo ingreso ingresado: $newIngreso'); // Debug
                setState(() {
                  _ingresoInicial = newIngreso;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive ? Colors.brown : Colors.brown.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.brown,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final bool isEmpty;

  const _InfoCard({
    required this.title,
    required this.value,
    this.subtitle,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD99898),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          if (!isEmpty)
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.arrow_back, size: 16, color: Colors.brown),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _EditableInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _EditableInfoCard({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tarjeta de ingreso inicial tocada'); // Debug
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFD99898),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.brown.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const Icon(
                  Icons.edit,
                  size: 16,
                  color: Colors.brown,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LimitCard extends StatelessWidget {
  final double limite;
  final bool isExceeded;
  final Function(double) onLimitChanged;

  const _LimitCard({
    required this.limite,
    required this.isExceeded,
    required this.onLimitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isExceeded ? Colors.red.withOpacity(0.8) : const Color(0xFFD99898),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LÍMITE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isExceeded ? Colors.white : Colors.brown,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'S/ ${limite.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isExceeded ? Colors.white : Colors.brown,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _showLimitDialog(context),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: isExceeded ? Colors.white : Colors.brown,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLimitDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text = limite.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Establecer Límite'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Límite de gastos',
              prefixText: 'S/ ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final newLimit = double.tryParse(controller.text) ?? limite;
                onLimitChanged(newLimit);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

class _PiggyImage extends StatelessWidget {
  final bool isLimitExceeded;
  final double gastos;
  final double limite;

  const _PiggyImage({
    required this.isLimitExceeded,
    required this.gastos,
    required this.limite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Imagen del cerdito
        Container(
          width: 150,
          height: 150,
          child: isLimitExceeded
              ? Image.asset(
                  'assets/cerdito_llorando.png', // Cerdito llorando
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.sentiment_very_dissatisfied,
                      size: 100,
                      color: Colors.red,
                    );
                  },
                )
              : Image.asset(
                  'assets/logo.png', // Cerdito feliz
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      size: 100,
                      color: Colors.green,
                    );
                  },
                ),
        ),
        
        const SizedBox(height: 16),
        
        // Mensaje
        if (isLimitExceeded)
          Text(
            'LÍMITE EXCEDIDO',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          )
        else
          Text(
            'DENTRO DEL LÍMITE',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        
        const SizedBox(height: 8),
        
        // Información adicional
        Text(
          'Gastos: S/ ${gastos.toStringAsFixed(2)} / S/ ${limite.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}