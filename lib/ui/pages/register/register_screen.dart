import 'dart:math';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:particles_flutter/component/particle/particle.dart';
import 'package:particles_flutter/particles_engine.dart';
import 'package:reconocimiento_app/services/api_services.dart';
import 'package:reconocimiento_app/styles/styles.dart';
import 'package:reconocimiento_app/ui/pages/custom_app_bar_lobby.dart';
import 'package:reconocimiento_app/ui/router.dart'; // Asegúrate de importar tu archivo de rutas

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  final FocusNode _numeroIdentificacionFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _nombreFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numeroIdentificacionController =
      TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedTipoDocumento =
      'Cédula de ciudadanía'; // Actualiza este valor según lo que el servidor espera
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _numeroIdentificacionFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _confirmPasswordFocusNode.addListener(_onFocusChange);
    _nombreFocusNode.addListener(_onFocusChange);
    _emailFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _numeroIdentificacionFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _confirmPasswordFocusNode.removeListener(_onFocusChange);
    _nombreFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.removeListener(_onFocusChange);

    _numeroIdentificacionFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nombreFocusNode.dispose();
    _emailFocusNode.dispose();

    _numeroIdentificacionController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nombreController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final nombre = _nombreController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final numeroIdentificacion = _numeroIdentificacionController.text.trim();
    final tipoDocumento = _selectedTipoDocumento;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final requestData = {
        'password': password,
        'first_name': nombre,
        'email': email,
        'tipo_documento_usuario': tipoDocumento,
        'numero_documento_usuario': numeroIdentificacion,
      };

      final responseData = await apiService.post('usuarios/', requestData);

      if (responseData['status'] == 'success') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registro exitoso')),
          );
        }
        if (mounted) {
          Navigator.pushNamed(context,
              Routes.login); // Redirigir a la página de inicio de sesión
        }
      } else {
        if (mounted) {
          // ignore: unnecessary_null_comparison
          if (responseData == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error al registrar')),
            );
          } else {
            Navigator.popAndPushNamed(context, Routes.login);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar: $e')),
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBarLobby(title: 'Registrarse'),
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Container(
            color: AppColors.backgroundColor,
            child: Particles(
              awayRadius: 100,
              particles: createParticles(),
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              awayAnimationDuration: const Duration(milliseconds: 500),
              awayAnimationCurve: Curves.easeInOutCirc,
              enableHover: true,
              hoverRadius: 90,
              connectDots: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: _isLoading
                  ? const CardLoading(
                      height: 100,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.all(10),
                    )
                  : Card(
                      shadowColor: AppColors.primaryColor,
                      color: AppColors.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/login/LogoReconocimientoFacialBlanco.png',
                                  width: 100,
                                  height: 100,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Bienvenido a SENAuthenticator",
                                  style: AppStyles.titleStyle,
                                ),
                                const SizedBox(height: 16.0),
                                const Text(
                                  "Regístrate para continuar..",
                                  style: AppStyles.subtitleStyle,
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  focusNode: _nombreFocusNode,
                                  controller: _nombreController,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Nombre',
                                    prefixIcon: Icon(Icons.person,
                                        color: _nombreFocusNode.hasFocus
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor),
                                  ),
                                  style: AppStyles.inputTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su nombre';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  focusNode: _emailFocusNode,
                                  controller: _emailController,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Correo Electrónico',
                                    prefixIcon: Icon(Icons.email,
                                        color: _emailFocusNode.hasFocus
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor),
                                  ),
                                  style: AppStyles.inputTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su correo electrónico';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                DropdownButtonFormField<String>(
                                  value: _selectedTipoDocumento,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Tipo de Documento',
                                    prefixIcon: const Icon(
                                        Icons.document_scanner,
                                        color: AppColors.secondaryColor),
                                  ),
                                  items: <String>[
                                    'Cédula de ciudadanía', // Actualiza estos valores según lo que el servidor espera
                                    'Tarjeta de identidad',
                                    'Cédula de extranjería',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTipoDocumento = newValue!;
                                    });
                                  },
                                  style: const TextStyle(
                                      color: AppColors.secondaryColor),
                                  dropdownColor: Colors.grey[700],
                                  iconEnabledColor: AppColors.primaryColor,
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  focusNode: _numeroIdentificacionFocusNode,
                                  controller: _numeroIdentificacionController,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Cédula',
                                    prefixIcon: Icon(Icons.email,
                                        color: _numeroIdentificacionFocusNode
                                                .hasFocus
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor),
                                  ),
                                  style: AppStyles.inputTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su cédula';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  focusNode: _passwordFocusNode,
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Contraseña',
                                    prefixIcon: Icon(Icons.lock,
                                        color: _passwordFocusNode.hasFocus
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor),
                                  ),
                                  style: AppStyles.inputTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, ingrese su contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  focusNode: _confirmPasswordFocusNode,
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  decoration:
                                      AppStyles.inputDecoration.copyWith(
                                    labelText: 'Confirmar Contraseña',
                                    prefixIcon: Icon(Icons.lock,
                                        color:
                                            _confirmPasswordFocusNode.hasFocus
                                                ? AppColors.primaryColor
                                                : AppColors.secondaryColor),
                                  ),
                                  style: AppStyles.inputTextStyle,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, confirme su contraseña';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _register,
                                    style: AppStyles.buttonStyle,
                                    child: _isLoading
                                        ? const CircularProgressIndicator()
                                        : const Text("Registrarse"),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                const Text(
                                  "O regístrate con ",
                                  style: TextStyle(color: AppColors.textColor),
                                ),
                                const SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "¿Ya tienes una cuenta?",
                                      style:
                                          TextStyle(color: AppColors.textColor),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.login);
                                      },
                                      child: const Text(
                                        "Inicia sesión",
                                        style: TextStyle(
                                            color: AppColors.primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<Particle> createParticles() {
    var rng = Random();
    List<Particle> particles = [];
    for (int i = 0; i < 20; i++) {
      particles.add(Particle(
        color: AppColors.primaryColor.withOpacity(0.6),
        size: rng.nextDouble() * 10,
        velocity: Offset(rng.nextDouble() * 50 * randomSign(),
            rng.nextDouble() * 50 * randomSign()),
      ));
    }
    return particles;
  }

  double randomSign() {
    var rng = Random();
    return rng.nextBool() ? 1.0 : -1.0;
  }
}
