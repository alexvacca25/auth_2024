import 'package:auth_2024/controllers/auth_controller.dart';
import 'package:auth_2024/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Page4 extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedBirthDate;
  final ProfileController _profilecontroller = Get.find();
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen circular con icono de cámara
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      ''), // Puedes cambiar esto por la imagen real del usuario
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                    onPressed: () {
                      // Aquí puedes manejar el cambio de imagen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Función para cambiar foto')),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Campo de texto para el nombre
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            // Campo de texto para el correo electrónico
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),

            // Campo de texto para WhatsApp
            TextField(
              controller: _whatsappController,
              decoration: InputDecoration(
                labelText: 'WhatsApp',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Campo de texto para celular
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Celular',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Campo de selección de fecha de nacimiento
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedBirthDate != null
                        ? 'Fecha de nacimiento: ${DateFormat('dd/MM/yyyy').format(_selectedBirthDate!)}'
                        : 'Seleccione su fecha de nacimiento',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectBirthDate(context),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Botón para guardar cambios
            ElevatedButton(
              onPressed: () {
                print('*********************************');
                final String idProfile =
                    _authController.userlogueado!.uid.toString();
                print(idProfile);
                _profilecontroller.saveProfile(
                    idProfile,
                    _nameController.text,
                    _emailController.text,
                    _whatsappController.text,
                    _phoneController.text,
                    DateTime.now());
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para seleccionar la fecha de nacimiento
  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }
}
