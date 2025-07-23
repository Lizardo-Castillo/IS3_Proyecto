import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Cargar datos actuales del usuario
    _loadUserData();
  }

  void _loadUserData() {
    // Aquí cargarías los datos actuales del usuario desde tu servicio/base de datos
    _nameController.text = "Karla Cornejo";
    _emailController.text = "karla@example.com";
    _phoneController.text = "+51 999 888 777";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      const Text(
                        'Karla Cornejo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.home, color: Colors.brown, size: 28),
                  ),
                ],
              ),
            ),

            // Botón PERFIL activo
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFD99898),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.settings, color: Colors.brown, size: 24),
                  const SizedBox(width: 16),
                  const Text(
                    'PERFIL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Formulario de edición
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _ProfileEditButton(
                      icon: Icons.person,
                      title: 'EDITAR NOMBRE',
                      controller: _nameController,
                      onTap: () => _showEditDialog(
                        context,
                        'Editar Nombre',
                        _nameController,
                        TextInputType.text,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ProfileEditButton(
                      icon: Icons.email,
                      title: 'EDITAR CORREO',
                      controller: _emailController,
                      onTap: () => _showEditDialog(
                        context,
                        'Editar Correo',
                        _emailController,
                        TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _ProfileEditButton(
                      icon: Icons.lock,
                      title: 'EDITAR CONTRASEÑA',
                      controller: _passwordController,
                      isPassword: true,
                      onTap: () => _showPasswordDialog(context),
                    ),
                    const SizedBox(height: 12),
                    _ProfileEditButton(
                      icon: Icons.security,
                      title: 'CONFIRMAR CONTRASEÑA',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      onTap: () => _showPasswordDialog(context),
                    ),
                    const SizedBox(height: 12),
                    _ProfileEditButton(
                      icon: Icons.phone,
                      title: 'EDITAR TELÉFONO',
                      controller: _phoneController,
                      onTap: () => _showEditDialog(
                        context,
                        'Editar Teléfono',
                        _phoneController,
                        TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Botón Guardar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'GUARDAR CAMBIOS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer con nombre de la app
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

  void _showEditDialog(BuildContext context, String title, TextEditingController controller, TextInputType inputType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              hintText: 'Ingresa el nuevo valor',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {}); // Actualizar la UI
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title actualizado correctamente')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar Contraseña'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña actual',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nueva contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar nueva contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contraseña actualizada correctamente')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Las contraseñas no coinciden')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _saveChanges() {
    // Aquí implementarías la lógica para guardar todos los cambios
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Todos los cambios han sido guardados correctamente'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _ProfileEditButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController? controller;
  final bool isPassword;
  final VoidCallback onTap;

  const _ProfileEditButton({
    required this.icon,
    required this.title,
    this.controller,
    this.isPassword = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFD99898),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.brown.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
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
              Icon(
                icon,
                color: Colors.brown,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}