class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String tipoDocumento;
  final String numeroDocumento;
  final String genero;
  final String rol;
  final bool isActive;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.genero,
    required this.rol,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      tipoDocumento: json['tipo_documento_usuario'],
      numeroDocumento: json['numero_documento_usuario'],
      genero: json['genero_usuario'],
      rol: json['rol_usuario'],
      isActive: json['is_active'],
    );
  }
}