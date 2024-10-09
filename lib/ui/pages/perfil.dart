// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, String> userData;

  const ProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100], // Fondo gris claro
        // appBar: AppBar(
        //   backgroundColor: Colors.green[600], // Verde moderno para el AppBar
        //   title: const Text('Perfil'),
        //   centerTitle: true,
        // ),
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${userData['first_name']} ${userData['last_name']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  userData['numero_documento_usuario'] == '1'
                      ? 'C.C :  ${userData['numero_documento_usuario']}'
                      : userData['numero_documento_usuario'] == '2'
                          ? 'T.I.: ${userData['numero_documento_usuario']}'
                          : userData['numero_documento_usuario'] == '3'
                              ? 'C.E : ${userData['numero_documento_usuario']}'
                              : 'P.S : ${userData['numero_documento_usuario']}',
                  style: const TextStyle(fontSize: 18),
                ),
                // Text(
                //   'N: ${userData['numero_documento_usuario']}',
                //   style: const TextStyle(fontSize: 18),
                // ),
                const SizedBox(height: 10),
                const Text(
                  'Nombre Programa:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        AssetImage('images/1.jpg'), // Imagen de perfil
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'About me',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'There are many variations of passages of lorem ipsum avalible',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Semana',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          Text('4'),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Mes',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          Text('21'),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'Año',
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          Text('231'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.phone),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${userData['Telefono']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${userData['Correo']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${userData['Correo']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(userData['Genero'] == 'Masculino'
                              ? Icons.male
                              : userData['Genero'] == 'Femenino'
                                  ? Icons.female
                                  : Icons.transgender),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${userData['Correo']}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () {
                        showEditProfileModal(context, userData);
                      },
                      child: const Text('Editar Perfil')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showEditProfileModal(BuildContext context, Map<String, String> userData) {
    TextEditingController nameController = TextEditingController(text: userData['first_name']);
    TextEditingController lastNameController = TextEditingController(text: userData['last_name']);
    TextEditingController emailController = TextEditingController(text: userData['email']);
    TextEditingController phoneController = TextEditingController(text: userData['phone']);
    TextEditingController birthDateController = TextEditingController(text: userData['birth_date']);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Perfil'),
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Correo'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Número de teléfono'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Fecha de nacimiento'),
              ),
              TextField(

                decoration: InputDecoration(labelText: 'Genero'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
