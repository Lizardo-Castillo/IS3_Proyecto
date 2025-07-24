import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFFE3E3),
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                        user?.email ?? 'Usuario',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    icon: const Icon(Icons.home, color: Colors.brown, size: 28),
                  ),
                ],
              ),
            ),

            // Menú
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFD99898),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _ProfileMenuItem(
                      icon: Icons.settings,
                      title: 'PERFIL',
                      onTap: () => Navigator.pushNamed(context, '/profile_settings'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.attach_money,
                      title: 'MONEDA',
                      onTap: () => Navigator.pushNamed(context, '/currency_settings'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.delete_sweep,
                      title: 'ELIMINAR TODOS LOS DATOS',
                      onTap: () => _showDeleteAllDataDialog(context),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.language,
                      title: 'IDIOMA',
                      onTap: () => Navigator.pushNamed(context, '/language_settings'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.description,
                      title: 'TÉRMINOS DE USO',
                      onTap: () => Navigator.pushNamed(context, '/terms_of_use'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.privacy_tip,
                      title: 'POLÍTICA DE PRIVACIDAD',
                      onTap: () => Navigator.pushNamed(context, '/privacy_policy'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.group,
                      title: 'SOBRE NOSOTROS',
                      onTap: () => Navigator.pushNamed(context, '/about_us'),
                    ),
                    _ProfileMenuItem(
                      icon: Icons.logout,
                      title: 'CERRAR SESIÓN',
                      onTap: () => _showLogoutDialog(context),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'SmartBudget',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.brown[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAllDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar todos los datos'),
        content: const Text(
          '¿Estás seguro de que quieres eliminar *todas* las transacciones? Esta acción no se puede deshacer.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cierra el diálogo

              try {
                // Obtener TODAS las transacciones sin importar el usuario
                final snapshot = await FirebaseFirestore.instance
                    .collection('transactions')
                    .get();

                // Eliminar cada documento
                for (final doc in snapshot.docs) {
                  await doc.reference.delete();
                }

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Todas las transacciones han sido eliminadas')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al eliminar transacciones: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut();
              // Elimina todas las pantallas anteriores del historial
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/', // o la ruta de tu pantalla de login
                (Route<dynamic> route) => false,
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.brown.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.brown.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.brown, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.brown.withOpacity(0.6), size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
