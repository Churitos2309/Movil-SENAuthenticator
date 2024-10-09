import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ObjetosAprendizPage extends StatefulWidget {
  const ObjetosAprendizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ObjetosAprendizPageState createState() => _ObjetosAprendizPageState();
}

class _ObjetosAprendizPageState extends State<ObjetosAprendizPage> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  XFile? _image;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>(); // Key para el formulario

  static const Color primaryColor =
      Color(0xFF39a900); // Verde institucional del SENA
  static const double defaultPadding = 16.0;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se seleccionó ninguna imagen.')),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar la imagen: $error')),
        );
      }
    }
  }

  // Mostrar un diálogo para seleccionar entre cámara o galería
  Future<void> _selectImageSource() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar imagen desde:'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cámara'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _pickImage(ImageSource.camera); // Abrir la cámara
              },
            ),
            TextButton(
              child: const Text('Galería'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
                _pickImage(ImageSource.gallery); // Abrir la galería
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Por favor, completa todos los campos e incluye una imagen')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    const String url =
        'https://backendsenauthenticator.up.railway.app/api/objetos/';

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['marca_objeto'] = _marcaController.text
      ..fields['modelo_objeto'] = _modeloController.text
      ..fields['descripcion_objeto'] = _descripcionController.text
      ..fields['usuario_objeto'] = _usuarioController.text;

    if (!kIsWeb) {
      request.files.add(await http.MultipartFile.fromPath(
        'foto_objeto',
        _image!.path,
      ));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
        'foto_objeto',
        await _image!.readAsBytes(),
        filename: _image!.name,
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Objeto creado exitosamente')),
          );
        }
        _marcaController.clear();
        _modeloController.clear();
        _descripcionController.clear();
        _usuarioController.clear();
        setState(() {
          _image = null;
        });
      } else {
        final responseBody = await response.stream.bytesToString();
        final errorResponse = jsonDecode(responseBody);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Error al crear el objeto: ${response.statusCode} - ${errorResponse['message'] ?? 'Sin detalles'}')),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el objeto: $error')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideScreen ? 800 : double.infinity,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Form(
                      key: _formKey, // Asigna la Key al Form
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título
                          Text(
                            '¿Qué objeto desea ingresar?',
                            style: TextStyle(
                              fontSize: isWideScreen ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Campo Marca
                          TextFormField(
                            controller: _marcaController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.branding_watermark,
                                  color: primaryColor),
                              labelText: 'Marca del objeto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa la marca del objeto';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // Campo Modelo
                          TextFormField(
                            controller: _modeloController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.device_hub, color: primaryColor),
                              labelText: 'Modelo del objeto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el modelo del objeto';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // Campo Descripción
                          TextFormField(
                            controller: _descripcionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.description, color: primaryColor),
                              labelText: 'Descripción del objeto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa una descripción del objeto';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // Campo Usuario
                          TextFormField(
                            controller: _usuarioController,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person, color: primaryColor),
                              labelText: 'Usuario del objeto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el usuario del objeto';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // Imagen seleccionada
                          if (_image != null)
                            Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(75.0),
                                  image: DecorationImage(
                                    image: kIsWeb
                                        ? NetworkImage(_image!.path)
                                        : FileImage(File(_image!.path))
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(height: 16.0),
                          // Botón Seleccionar/Cambiar Imagen
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: _selectImageSource,
                              icon: const Icon(Icons.image, color: primaryColor),
                              label: Text(
                                _image == null
                                    ? 'Seleccionar imagen'
                                    : 'Cambiar imagen',
                                style: const TextStyle(color: primaryColor),
                              ),
                              style: ElevatedButton.styleFrom(
                                iconColor: Colors.white, // Fondo blanco
                                side: const BorderSide(color: primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          // Botón Enviar
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _submitData,
                                style: ElevatedButton.styleFrom(
                                  iconColor: primaryColor,
                                  shadowColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      )
                                    : const Text(
                                        'Enviar',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _descripcionController.dispose();
    _usuarioController.dispose();
    super.dispose();
  }
}
